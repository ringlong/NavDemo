//
//  YCColor.h
//  YCChart
//
//  Created by shake on 14-7-24.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

// constant
static const CGFloat chartMargin = 10;
static const CGFloat xLabelMargin = 15;
static const CGFloat yLabelMargin = 15;
static const CGFloat YCLabelHeight = 10;
static const CGFloat YCYLabelwidth = 30;
static const CGFloat YCTagLabelwidth = 80;

// 范围
struct Range {
    CGFloat max;
    CGFloat min;
};

typedef struct Range CGRange;

CG_INLINE CGRange CGRangeMake(CGFloat max, CGFloat min);

CG_INLINE CGRange

CGRangeMake(CGFloat max, CGFloat min){
    CGRange p;
    p.max = max;
    p.min = min;
    return p;
}

static const CGRange CGRangeZero = {0, 0};

@interface YCColor : NSObject
- (UIImage *)imageFromColor:(UIColor *)color;
@end

@interface UIColor (YCChartColor)

+ (UIColor *)YCGreyColor;
+ (UIColor *)YCLightBlueColor;
+ (UIColor *)YCGreenColor;
+ (UIColor *)YCTitleColor;
+ (UIColor *)YCButtonGreyColor;
+ (UIColor *)YCFreshGreenColor;
+ (UIColor *)YCRedColor;
+ (UIColor *)YCMauveColor;
+ (UIColor *)YCBrownColor;
+ (UIColor *)YCBlueColor;
+ (UIColor *)YCDarkBlueColor;
+ (UIColor *)YCYellowColor;
+ (UIColor *)YCWhiteColor;
+ (UIColor *)YCDeepGreyColor;
+ (UIColor *)YCPinkGreyColor;
+ (UIColor *)YCHealYellowColor;
+ (UIColor *)YCLightGreyColor;
+ (UIColor *)YCDarkYellowColor;
+ (UIColor *)YCPinkDarkColor;
+ (UIColor *)YCCloudWhiteColor;
+ (UIColor *)YCBlackColor;
+ (UIColor *)YCStarYellowColor;
+ (UIColor *)YCTwitterColor;
+ (UIColor *)YCWeiboColor;
+ (UIColor *)YCiOSGreenColor;
+ (UIColor *)randomColor;

@end

