/*
 ==============================================================================
 CEUnicodeInputPanelController
 
 CotEditor
 http://coteditor.com
 
 Created on 2014-05-06 by 1024jp
 encoding="UTF-8"
 ------------------------------------------------------------------------------
 
 © 2014-2015 1024jp
 
 This program is free software; you can redistribute it and/or modify it under
 the terms of the GNU General Public License as published by the Free Software
 Foundation; either version 2 of the License, or (at your option) any later
 version.
 
 This program is distributed in the hope that it will be useful, but WITHOUT
 ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License along with
 this program; if not, write to the Free Software Foundation, Inc., 59 Temple
 Place - Suite 330, Boston, MA  02111-1307, USA.
 
 ==============================================================================
 */

#import "CEUnicodeInputPanelController.h"
#import "CEEditorWrapper.h"


@interface CEUnicodeInputPanelController () <NSTextFieldDelegate>

@property (nonatomic, nonnull, copy) NSString *unicode;
@property (nonatomic, getter=isValid) BOOL valid;

@end




#pragma mark -

@implementation CEUnicodeInputPanelController

static const NSRegularExpression *unicodeRegex;


#pragma mark Superclass Methods

// ------------------------------------------------------
/// initialize class
+ (void)initialize
// ------------------------------------------------------
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        unicodeRegex = [NSRegularExpression regularExpressionWithPattern:@"^(?:U\\+|0x|\\\\u)?([0-9a-f]{4,5})$"
                                                                 options:NSRegularExpressionCaseInsensitive
                                                                   error:nil];
    });
}


// ------------------------------------------------------
/// initializer of panelController
- (nonnull instancetype)init
// ------------------------------------------------------
{
    self = [super initWithWindowNibName:@"UnicodePanel"];
    if (self) {
        _unicode = @"";
    }
    return self;
}



#pragma mark Delegate

// ------------------------------------------------------
/// text in text field was changed
- (void)controlTextDidChange:(nonnull NSNotification *)notification
// ------------------------------------------------------
{
    NSString *input = [[notification object] stringValue];
    
    NSTextCheckingResult *result = [unicodeRegex firstMatchInString:input options:0
                                                              range:NSMakeRange(0, [input length])];
    
    [self setValid:(result != nil)];
}



#pragma mark Action Messages

// ------------------------------------------------------
/// input unicode character to the frontmost document
- (IBAction)insertToDocument:(nullable id)sender
// ------------------------------------------------------
{
    unsigned int longChar;
    NSScanner *scanner = [NSScanner scannerWithString:[self unicode]];
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"uU+\\"]];
    [scanner scanHexInt:&longChar];
    
    NSTextView *textView = [[[self documentWindowController] editor] focusedTextView];
    UniChar chars[2];
    NSUInteger length = CFStringGetSurrogatePairForLongCharacter(longChar, chars) ? 2 : 1;
    NSString *character = [[NSString alloc] initWithCharacters:chars length:length];
    
    [textView insertText:character replacementRange:[textView selectedRange]];
    [[self window] performClose:sender];
    [self setUnicode:@""];
}

@end
