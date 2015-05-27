//
//  YCBar.h
//  YCChartDemo
//
//  Created by shake on 14-7-24.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCBar : UIView

@property (nonatomic) CGFloat grade;

@property (nonatomic, strong) CAShapeLayer *chartLine;

@property (nonatomic, strong) UIColor *barColor;

@end
