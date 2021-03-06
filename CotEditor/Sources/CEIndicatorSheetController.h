/*
 ==============================================================================
 CEIndicatorSheetController
 
 CotEditor
 http://coteditor.com
 
 Created on 2014-06-07 by 1024jp
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

@import Cocoa;


@interface CEIndicatorSheetController : NSWindowController <NSWindowDelegate>

@property (nonnull, copy) NSString *informativeText;
@property (readonly, getter=isCancelled) BOOL cancelled;


- (nonnull instancetype)initWithMessage:(nonnull NSString *)message;

- (void)beginSheetForWindow:(nonnull NSWindow *)window;
- (void)endSheet;
- (void)progressIndicator:(CGFloat)delta;  // max = 100

@end
