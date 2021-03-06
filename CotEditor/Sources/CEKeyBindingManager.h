/*
 ==============================================================================
 CEKeyBindingManager
 
 CotEditor
 http://coteditor.com
 
 Created on 2005-09-01 by nakamuxu
 encoding="UTF-8"
 ------------------------------------------------------------------------------
 
 © 2004-2007 nakamuxu
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


// outlineView data key, column identifier
extern NSString *__nonnull const CEKeyBindingTitleKey;
extern NSString *__nonnull const CEKeyBindingChildrenKey;
extern NSString *__nonnull const CEKeyBindingKeySpecCharsKey;
extern NSString *__nonnull const CEKeyBindingSelectorStringKey;


@interface CEKeyBindingManager : NSObject

// singleton
+ (nonnull instancetype)sharedManager;


// Public methods
+ (nonnull NSString *)keySpecCharsFromKeyEquivalent:(nonnull NSString *)string modifierFrags:(NSEventModifierFlags)modifierFlags;
+ (nonnull NSString *)printableKeyStringFromKeySpecChars:(nonnull NSString *)string;

- (void)applyKeyBindingsToMainMenu;

- (nonnull NSString *)selectorStringWithKeyEquivalent:(nonnull NSString *)string modifierFrags:(NSEventModifierFlags)modifierFlags;

- (BOOL)usesDefaultMenuKeyBindings;
- (BOOL)usesDefaultTextKeyBindings;
- (nonnull NSMutableArray *)textKeySpecCharArrayForOutlineDataWithFactoryDefaults:(BOOL)usesFactoryDefaults;
- (nonnull NSMutableArray *)mainMenuArrayForOutlineData:(nonnull NSMenu *)menu;
- (nonnull NSString *)keySpecCharsInDefaultDictionaryFromSelectorString:(nonnull NSString *)selectorString;
- (BOOL)saveMenuKeyBindings:(nonnull NSArray *)outlineViewData;
- (BOOL)saveTextKeyBindings:(nonnull NSArray *)outlineViewData texts:(nullable NSArray *)texts;

@end



// Category for migration from CotEditor 1.x to 2.0. (2014-10)
// It can be removed when the most of users have been already migrated in the future.
@interface CEKeyBindingManager (Migration)

- (BOOL)resetMenuKeyBindings;

@end
