//
//  YCBarChart.h
//  YCChartDemo
//
//  Created by shake on 14-7-24.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCColor.h"

@interface YCBarChart : UIView

/**
 *  横坐标
 */
@property (nonatomic, strong) NSArray *xLabels;

/**
 *  纵坐标
 */
@property (nonatomic, strong) NSArray *yLabels;

/**
 *  值
 */
@property (strong, nonatomic) NSArray *yValues;

/**
 *  显示水平制表线
 */
@property (nonatomic, strong) NSMutableArray *showHorizonLine;

/**
 *  显示对应Item的值
 */
@property (nonatomic, assign) BOOL showBarValue;

/**
 *  显示纵坐标
 */
@property (nonatomic, assign) BOOL showOrdinate;

@property (nonatomic) CGFloat xLabelWidth;
@property (nonatomic) CGFloat yValueMax;
@property (nonatomic) CGFloat yValueMin;

@property (nonatomic, assign) BOOL showRange;

@property (nonatomic, assign) CGRange chooseRange;

@property (nonatomic, strong) NSArray * colors;

/**
 * This method will call and troke the line in animation
 */
- (void)strokeChart;


@end
