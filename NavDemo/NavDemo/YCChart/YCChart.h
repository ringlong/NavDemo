//
//  YCChart.h
//	Version 0.1
//  YCChart
//
//  Created by shake on 14-7-24.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCChart.h"
#import "YCColor.h"
#import "YCLineChart.h"
#import "YCBarChart.h"

// 类型
typedef NS_ENUM(NSUInteger, YCChartStyle) {
    YCChartLineStyle,   // 线状图
    YCChartBarStyle,    // 柱状图
};

@class YCChart;

@protocol YCChartDataSource <NSObject>

@required
// 横坐标标题数组
- (NSArray *)YCChart_xLableArray:(YCChart *)chart;

// 数值多重数组
- (NSArray *)YCChart_yValueArray:(YCChart *)chart;

@optional
// 颜色数组
- (NSArray *)YCChart_ColorArray:(YCChart *)chart;

// 显示数值范围
- (CGRange)YCChartChooseRangeInLineChart:(YCChart *)chart;

// 标记数值区域
- (CGRange)YCChartMarkRangeInLineChart:(YCChart *)chart;

// 判断显示横线
- (BOOL)YCChart:(YCChart *)chart showHorizonLineAtIndex:(NSInteger)index;

// 判断显示最大最小值
- (BOOL)YCChart:(YCChart *)chart ShowMaxMinAtIndex:(NSInteger)index;

// 判断显示纵坐标
- (BOOL)YCChartShowOrdinate:(YCChart *)chart;

// 判断是否显示柱状图值
- (BOOL)YCChartShowBarValue:(YCChart *)chart;

@end


@interface YCChart : UIView

// 是否自动显示范围
@property (nonatomic, assign) BOOL showRange;

@property (nonatomic, assign) YCChartStyle chartStyle;

- (instancetype)initwithYCChartDataFrame:(CGRect)rect
                              withSource:(id<YCChartDataSource>)dataSource
                               withStyle:(YCChartStyle)style;

- (void)showInView:(UIView *)view;

- (void)strokeChart;

@end
