/*
 ==============================================================================
 CEPanelController
 
 This class is an abstract class for panels related to document.
 
 CotEditor
 http://coteditor.com
 
 Created on 2014-03-18 by 1024jp
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

#import "CEPanelController.h"


@interface CEPanelController ()

@property (readwrite, nonatomic, nullable, weak) CEWindowController *documentWindowController;

@end




#pragma mark -

@implementation CEPanelController

static NSMutableDictionary *instances;


#pragma mark Singleton

// ------------------------------------------------------
/// return shared instance (inheritable)
+ (nonnull instancetype) sharedController
// ------------------------------------------------------
{
    // This method is based on the following article:
    // http://qiita.com/hal_sk/items/b4e51c33e7c9d29964ab
    
    __block id obj;
    @synchronized(self) {
        if (instances[NSStringFromClass(self)] == nil) {
            obj = [[self alloc] init];
        }
    }
    obj = instances[NSStringFromClass(self)];
    return obj;
}


// ------------------------------------------------------
/// allocate
+ (nonnull instancetype)allocWithZone:(nonnull NSZone *)zone
// ------------------------------------------------------
{
    // This method is based on the following article:
    // http://qiita.com/hal_sk/items/b4e51c33e7c9d29964ab
    
    @synchronized(self) {
        if (instances[NSStringFromClass(self)] == nil) {
            id instance = [super allocWithZone:zone];
            if (instances == nil) {
                instances = [NSMutableDictionary dictionary];
            }
            instances[NSStringFromClass(self)] = instance;
            return instance;
        }
    }
    return nil;
}



#pragma mark Superclass Methods

// ------------------------------------------------------
/// default initializer
- (nonnull instancetype)initWithWindow:(nullable NSWindow *)window
// ------------------------------------------------------
{
    self = [super initWithWindow:window];
    if (self) {
        // observe key window change
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(windowDidBecomeMain:)
                                                     name:NSWindowDidBecomeMainNotification
                                                   object:nil];
        // apply current window
        NSNotification *notification = [NSNotification notificationWithName:NSWindowDidBecomeMainNotification object:window];
        [self windowDidBecomeMain:notification];
    }
    return self;
}


// ------------------------------------------------------
/// clean up
- (void)dealloc
// ------------------------------------------------------
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



#pragma mark Notifications

//=======================================================
// NSWindow Notification  < window
//=======================================================

// ------------------------------------------------------
/// notification about main window change
- (void)windowDidBecomeMain:(nonnull NSNotification *)notification
// ------------------------------------------------------
{
    // update properties if the new main window is a document window
    if ([[[NSApp mainWindow] windowController] isKindOfClass:[CEWindowController class]]) {
        [self setDocumentWindowController:(CEWindowController *)[[NSApp mainWindow] windowController]];
        
        [self keyDocumentDidChange];
    }
}



#pragma mark Abstract Methods

// ------------------------------------------------------
/// invoke when frontmost document window changed (abstract)
- (void)keyDocumentDidChange
// ------------------------------------------------------
{
    // override in subclass
}

@end
