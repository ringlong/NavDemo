//
//  YCBarChart.m
//  YCChartDemo
//
//  Created by shake on 14-7-24.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import "YCBarChart.h"
#import "YCChartLabel.h"
#import "YCBar.h"

@interface YCBarChart ()

@property (nonatomic, strong) UIScrollView *myScrollView;

@end

@implementation YCBarChart

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
    }
    return self;
}

- (UIScrollView *)myScrollView {
    if (!_myScrollView) {
        _myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(self.showOrdinate?YCYLabelwidth:0, 0, self.frame.size.width - (self.showOrdinate?YCYLabelwidth:0), self.frame.size.height)];
        [self addSubview:_myScrollView];
    }
    return _myScrollView;
}

- (void)setYValues:(NSArray *)yValues {
    _yValues = yValues;
    [self setYLabels:_yValues];
}

- (void)setYLabels:(NSArray *)yLabels {
    CGFloat max = 0;
    CGFloat min = 1000000000;
    for (NSArray *array in yLabels) {
        for (NSString *valueString in array) {
            CGFloat value = [valueString floatValue];
            if (value > max) {
                max = value;
            }
            if (value < min) {
                min = value;
            }
        }
    }
    
    if (max < 6) {
        max = 6.;
    }
    
    if (self.showRange) {
        _yValueMin = min;
    } else {
        _yValueMin = 0;
    }
    
    _yValueMax = (int)max;
    
    if (_chooseRange.max != _chooseRange.min) {
        _yValueMax = _chooseRange.max;
        _yValueMin = _chooseRange.min;
    }

    float level = (_yValueMax - _yValueMin) / 5.0;
    CGFloat chartCavanHeight = self.frame.size.height - YCLabelHeight * 3;
    CGFloat levelHeight = chartCavanHeight / 5.0;
    
    if (self.showOrdinate) {
        for (int i = 0; i < 6; i++) {
            YCChartLabel * label = [[YCChartLabel alloc] initWithFrame:CGRectMake(0.0, chartCavanHeight - i * levelHeight + 5, YCYLabelwidth, YCLabelHeight)];
            label.text = [NSString stringWithFormat:@"%.0f", level * i + _yValueMin];
            [self addSubview:label];
        }
    }
    
    // 画横线
    CGFloat lineLeft = self.myScrollView.frame.origin.x;
    for (int i = 0; i < 6; i++) {
        if ([_showHorizonLine[i] boolValue]) {
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(lineLeft, YCLabelHeight + i * levelHeight)];
            [path addLineToPoint:CGPointMake(self.frame.size.width, YCLabelHeight + i * levelHeight)];
            [path closePath];
            shapeLayer.path = path.CGPath;
            shapeLayer.strokeColor = [[[UIColor blackColor] colorWithAlphaComponent:0.1] CGColor];
            shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
            shapeLayer.lineWidth = 1;
            [self.layer addSublayer:shapeLayer];
        }
    }

}

- (void)setXLabels:(NSArray *)xLabels {
    _xLabels = xLabels;
    NSInteger num;
    
    if (xLabels.count >= 8) {
        num = 8;
    } else if (xLabels.count <= 4) {
        num = 4;
    } else {
        num = xLabels.count;
    }
    _xLabelWidth = self.myScrollView.frame.size.width / num;
    
    for (int i = 0; i < xLabels.count; i++) {
        YCChartLabel * label = [[YCChartLabel alloc] initWithFrame:CGRectMake((i * _xLabelWidth), self.frame.size.height - YCLabelHeight, _xLabelWidth, YCLabelHeight)];
        label.text = xLabels[i];
        [self.myScrollView addSubview:label];
    }
    
    CGFloat max = ((xLabels.count - 1) * _xLabelWidth + chartMargin) + _xLabelWidth;
    if (self.myScrollView.frame.size.width < max - 10) {
        self.myScrollView.contentSize = CGSizeMake(max, self.frame.size.height);
    }
}

- (void)strokeChart {
    
    CGFloat chartCavanHeight = self.frame.size.height - YCLabelHeight * 3;
	
    for (int i = 0; i < _yValues.count; i++) {
        if (i == 2) return;
        
        NSArray *childAry = _yValues[i];
        
        for (int j = 0; j < childAry.count; j++) {
            NSString *valueString = childAry[j];
            CGFloat value = valueString.floatValue;
            CGFloat grade = (value - _yValueMin) / (_yValueMax - _yValueMin);
            
            CGFloat barLeft = (j + (_yValues.count == 1 ? 0.1 : 0.05)) * _xLabelWidth + i * _xLabelWidth * 0.47;
            CGFloat barWidth = _xLabelWidth * (_yValues.count == 1 ? 0.5 : 0.45);
            
            YCBar *bar = [[YCBar alloc] initWithFrame:CGRectMake(barLeft, YCLabelHeight, barWidth, chartCavanHeight)];
            
            bar.barColor = _colors[i];
            bar.grade = grade;
            [self.myScrollView addSubview:bar];
            
            if (_showBarValue) {
                YCChartLabel * label = [[YCChartLabel alloc] initWithFrame:CGRectMake(barLeft, 0, barWidth, YCLabelHeight)];

                label.text = valueString;
                [self.myScrollView addSubview:label];
            }

        }
    }
}

@end
