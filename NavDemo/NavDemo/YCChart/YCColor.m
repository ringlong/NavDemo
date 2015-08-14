//
//  YCColor.m
//  YCChart
//
//  Created by shake on 14-7-24.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import "YCColor.h"

@implementation YCColor

- (id)init{
    if (self = [super init]) {
        
    }
    return self;
}

- (UIImage *)imageFromColor:(UIColor*)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end


@implementation UIColor (YCChartColor)

+ (UIColor *)YCGreyColor {
    return [UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1.0f];
}

+ (UIColor *)YCLightBlueColor {
    return [UIColor colorWithRed:94.0/255.0 green:147.0/255.0 blue:196.0/255.0 alpha:1.0f];
}

+ (UIColor *)YCGreenColor {
    return [UIColor colorWithRed:77.0/255.0 green:186.0/255.0 blue:122.0/255.0 alpha:1.0f];
}

+ (UIColor *)YCTitleColor {
    return [UIColor colorWithRed:0.0/255.0 green:189.0/255.0 blue:113.0/255.0 alpha:1.0f];
}

+ (UIColor *)YCButtonGreyColor {
    return [UIColor colorWithRed:141.0/255.0 green:141.0/255.0 blue:141.0/255.0 alpha:1.0f];
}

+ (UIColor *)YCFreshGreenColor {
    return [UIColor colorWithRed:77.0/255.0 green:196.0/255.0 blue:122.0/255.0 alpha:1.0f];
}

+ (UIColor *)YCRedColor {
    return [UIColor colorWithRed:245.0/255.0 green:94.0/255.0 blue:78.0/255.0 alpha:1.0f];
}

+ (UIColor *)YCMauveColor {
    return [UIColor colorWithRed:88.0/255.0 green:75.0/255.0 blue:103.0/255.0 alpha:1.0f];
}

+ (UIColor *)YCBrownColor {
    return [UIColor colorWithRed:119.0/255.0 green:107.0/255.0 blue:95.0/255.0 alpha:1.0f];
}

+ (UIColor *)YCBlueColor {
    return [UIColor colorWithRed:82.0/255.0 green:116.0/255.0 blue:188.0/255.0 alpha:1.0f];
}

+ (UIColor *)YCDarkBlueColor {
    return [UIColor colorWithRed:121.0/255.0 green:134.0/255.0 blue:142.0/255.0 alpha:1.0f];
}

+ (UIColor *)YCYellowColor {
    return [UIColor colorWithRed:242.0/255.0 green:197.0/255.0 blue:117.0/255.0 alpha:1.0f];
}

+ (UIColor *)YCWhiteColor {
    return [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0f];
}

+ (UIColor *)YCDeepGreyColor {
    return [UIColor colorWithRed:99.0/255.0 green:99.0/255.0 blue:99.0/255.0 alpha:1.0f];
}

+ (UIColor *)YCPinkGreyColor {
    return [UIColor colorWithRed:200.0/255.0 green:193.0/255.0 blue:193.0/255.0 alpha:1.0f];
}

+ (UIColor *)YCHealYellowColor {
    return [UIColor colorWithRed:245.0/255.0 green:242.0/255.0 blue:238.0/255.0 alpha:1.0f];
}

+ (UIColor *)YCLightGreyColor {
    return [UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0f];
}

+ (UIColor *)YCDarkYellowColor {
    return [UIColor colorWithRed:152.0/255.0 green:150.0/255.0 blue:159.0/255.0 alpha:1.0f];
}

+ (UIColor *)YCPinkDarkColor {
    return [UIColor colorWithRed:170.0/255.0 green:165.0/255.0 blue:165.0/255.0 alpha:1.0f];
}

+ (UIColor *)YCCloudWhiteColor {
    return [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1.0f];
}

+ (UIColor *)YCBlackColor {
    return [UIColor colorWithRed:45.0/255.0 green:45.0/255.0 blue:45.0/255.0 alpha:1.0f];
}

+ (UIColor *)YCStarYellowColor {
    return [UIColor colorWithRed:252.0/255.0 green:223.0/255.0 blue:101.0/255.0 alpha:1.0f];
}

+ (UIColor *)YCTwitterColor {
    return [UIColor colorWithRed:0.0/255.0 green:171.0/255.0 blue:243.0/255.0 alpha:1.0];
}

+ (UIColor *)YCWeiboColor {
    return [UIColor colorWithRed:250.0/255.0 green:0.0/255.0 blue:33.0/255.0 alpha:1.0];
}

+ (UIColor *)YCiOSGreenColor {
    return [UIColor colorWithRed:98.0/255.0 green:247.0/255.0 blue:77.0/255.0 alpha:1.0];
}

+ (UIColor *)randomColor {
    return [UIColor colorWithRed:arc4random() * 1. / UINT32_MAX
                           green:arc4random() * 1. / UINT32_MAX
                            blue:arc4random() * 1. / UINT32_MAX
                           alpha:1.0f];
}

+ (UIColor *)colorWithPercent:(CGFloat)percent {
    return [UIColor colorWithRed:82.0 / 255.0
                           green:116.0 / 255.0
                            blue:188.0 / 255.0 * percent
                           alpha:1];
}

@end
