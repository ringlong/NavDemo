//
//  UILabel+EYAdditions.m
//  EYToolkit
//
//  Created by Edward Yang on 14-6-12.
//  Copyright (c) 2014年 EdwardYang. All rights reserved.
//

#import "UILabel+EYAdditions.h"

@implementation UILabel (EYAdditions)

+ (instancetype)labelWithFrame:(CGRect)frame
                          text:(NSString *)text
                          font:(UIFont *)font
                     textColor:(UIColor *)textColor
               backgroundColor:(UIColor *)backgroundColor
                 textAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label = [[[self class] alloc] initWithFrame:frame];
    if (text) {
        label.text = text;
    }
    if (font) {
        label.font = font;
    }
    if (textColor) {
        label.textColor = textColor;
    }
    if (backgroundColor) {
        label.backgroundColor = backgroundColor;
    }
    label.textAlignment = textAlignment;
    return label;
}

@end
