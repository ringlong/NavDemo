//
//  YCLineChart.h
//  YCChartDemo
//
//  Created by shake on 14-7-24.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "YCColor.h"

@interface YCLineChart : UIView

@property (nonatomic, strong) NSArray *xLabels;

@property (nonatomic, strong) NSArray *yLabels;

@property (nonatomic, strong) NSArray *yValues;

@property (nonatomic, strong) NSArray *colors;

@property (nonatomic, assign) CGFloat xLabelWidth;
@property (nonatomic, assign) CGFloat yValueMin;
@property (nonatomic, assign) CGFloat yValueMax;

@property (nonatomic, assign) CGRange markRange;

@property (nonatomic, assign) CGRange chooseRange;

@property (nonatomic, assign) BOOL showRange;

@property (nonatomic, retain) NSMutableArray *showHorizonLine;
@property (nonatomic, retain) NSMutableArray *showMaxMinArray;

- (void)strokeChart;

@end
