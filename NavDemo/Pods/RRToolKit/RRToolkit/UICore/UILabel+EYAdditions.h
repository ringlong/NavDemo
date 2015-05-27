//
//  UILabel+EYAdditions.h
//  EYToolkit
//
//  Created by Edward Yang on 14-6-12.
//  Copyright (c) 2014年 EdwardYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (EYAdditions)

// Quickly create a label.
+ (instancetype)labelWithFrame:(CGRect)frame
                          text:(NSString *)text
                          font:(UIFont *)font
                     textColor:(UIColor *)textColor
               backgroundColor:(UIColor *)backgroundColor
                 textAlignment:(NSTextAlignment)textAlignment;

@end
