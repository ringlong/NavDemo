//
//  UIWindow+EYAdditions.h
//  EYToolkit
//
//  Created by Edward Yang on 3/29/13.
//  Copyright (c) 2013 EdwardYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (EYAdditions)
+ (BOOL)isKeyboardVisible; // Determines if the keyboard is visible.
- (UIView *)findFirstResponder; // Searches the view hierarchy recursively for the first responder, starting with this window.
- (UIView *)findFirstResponderInView:(UIView *)topView; // Searches the view hierarchy recursively for the first responder, starting with topView.
@end
