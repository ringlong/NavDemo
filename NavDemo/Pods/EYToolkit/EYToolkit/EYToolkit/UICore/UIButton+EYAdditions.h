//
//  UIButton+EYAdditions.h
//  EYToolkit
//
//  Created by Edward Yang on 14-6-12.
//  Copyright (c) 2014年 EdwardYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (EYAdditions)

// Quickly create a button.
+ (instancetype)buttonWithFrame:(CGRect)frame
                           type:(UIButtonType)type
                          title:(NSString *)title
                     titleColor:(UIColor *)titleColor
                      titleFont:(UIFont *)font
                          image:(UIImage *)image
                backgroundImage:(UIImage *)backgroundImage
                       forState:(UIControlState)state
                         target:(id)target
                         action:(SEL)action
               forControlEvents:(UIControlEvents)controlEvents;

// Add some attributes for a button.
- (void)addTitle:(NSString *)title
      titleColor:(UIColor *)titleColor
           image:(UIImage *)image
 backgroundImage:(UIImage *)backgroundImage
        forState:(UIControlState)state;

@end
