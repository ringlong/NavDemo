//
//  YCChart.m
//  YCChart
//
//  Created by shake on 14-7-24.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import "YCChart.h"

@interface YCChart ()

@property (strong, nonatomic) YCLineChart * lineChart;

@property (strong, nonatomic) YCBarChart * barChart;

@property (assign, nonatomic) id<YCChartDataSource> dataSource;

@end

@implementation YCChart

- (instancetype)initwithYCChartDataFrame:(CGRect)rect
                              withSource:(id<YCChartDataSource>)dataSource
                               withStyle:(YCChartStyle)style {
    self.dataSource = dataSource;
    self.chartStyle = style;
    return [self initWithFrame:rect];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = NO;
    }
    return self;
}

- (void)setUpChart {
	if (self.chartStyle == YCChartLineStyle) {
        if(!_lineChart){
            _lineChart = [[YCLineChart alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            [self addSubview:_lineChart];
        }
        
        // 选择标记范围
        if ([self.dataSource respondsToSelector:@selector(YCChartMarkRangeInLineChart:)]) {
            [_lineChart setMarkRange:[self.dataSource YCChartMarkRangeInLineChart:self]];
        }
        
        // 选择显示范围
        if ([self.dataSource respondsToSelector:@selector(YCChartChooseRangeInLineChart:)]) {
            [_lineChart setChooseRange:[self.dataSource YCChartChooseRangeInLineChart:self]];
        }
        
        // 显示颜色
        if ([self.dataSource respondsToSelector:@selector(YCChart_ColorArray:)]) {
            [_lineChart setColors:[self.dataSource YCChart_ColorArray:self]];
        }
        
        // 显示横线
        if ([self.dataSource respondsToSelector:@selector(YCChart:showHorizonLineAtIndex:)]) {
            NSMutableArray *showHorizonArray = [NSMutableArray arrayWithCapacity:6];
            for (int i = 0; i < 6; i++) {
                if ([self.dataSource YCChart:self showHorizonLineAtIndex:i]) {
                    [showHorizonArray addObject:@YES];
                } else {
                    [showHorizonArray addObject:@NO];
                }
            }
            [_lineChart setShowHorizonLine:showHorizonArray];
        }
        
        // 判断显示最大最小值
        if ([self.dataSource respondsToSelector:@selector(YCChart:ShowMaxMinAtIndex:)]) {
            NSMutableArray *showMaxMinArray = [[NSMutableArray alloc] init];
            NSArray *y_values = [self.dataSource YCChart_yValueArray:self];
            if (y_values.count > 0){
                for (int i = 0; i < y_values.count; i++) {
                    if ([self.dataSource YCChart:self ShowMaxMinAtIndex:i]) {
                        [showMaxMinArray addObject:@"1"];
                    } else {
                        [showMaxMinArray addObject:@"0"];
                    }
                }
                _lineChart.showMaxMinArray = showMaxMinArray;
            }
        }
        _lineChart.yValues = [self.dataSource YCChart_yValueArray:self];
        _lineChart.xLabels = [self.dataSource YCChart_xLableArray:self];
        
		[_lineChart strokeChart];

	} else if (self.chartStyle == YCChartBarStyle) {
        if (!_barChart) {
            _barChart = [[YCBarChart alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            [self addSubview:_barChart];
        }
        
        if ([self.dataSource respondsToSelector:@selector(YCChartChooseRangeInLineChart:)]) {
            [_barChart setChooseRange:[self.dataSource YCChartChooseRangeInLineChart:self]];
        }
        
        if ([self.dataSource respondsToSelector:@selector(YCChart_ColorArray:)]) {
            [_barChart setColors:[self.dataSource YCChart_ColorArray:self]];
        }
        
        // 显示横线
        if ([self.dataSource respondsToSelector:@selector(YCChart:showHorizonLineAtIndex:)]) {
            NSMutableArray *showHorizonArray = [NSMutableArray arrayWithCapacity:6];
            for (int i = 0; i < 6; i++) {
                if ([self.dataSource YCChart:self showHorizonLineAtIndex:i]) {
                    [showHorizonArray addObject:@YES];
                } else {
                    [showHorizonArray addObject:@NO];
                }
            }
            _barChart.showHorizonLine = showHorizonArray;
        }

        // 显示纵坐标
        if ([self.dataSource respondsToSelector:@selector(YCChartShowOrdinate:)]) {
            _barChart.showOrdinate = [self.dataSource YCChartShowOrdinate:self];
        } else {
            _barChart.showOrdinate = YES;
        }
        
        // 显示柱状图值
        if ([self.dataSource respondsToSelector:@selector(YCChartShowBarValue:)]) {
            _barChart.showBarValue = [self.dataSource YCChartShowBarValue:self];
        } else {
            _barChart.showBarValue = NO;
        }
        
        _barChart.yValues = [self.dataSource YCChart_yValueArray:self];
        _barChart.xLabels = [self.dataSource YCChart_xLableArray:self];

        [_barChart strokeChart];
	}
}

- (void)showInView:(UIView *)view {
    [self setUpChart];
    [view addSubview:self];
}

- (void)strokeChart {
	[self setUpChart];
	
}



@end
