//
//  YCLineChart.m
//  YCChartDemo
//
//  Created by shake on 14-7-24.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import "YCLineChart.h"
#import "YCColor.h"
#import "YCChartLabel.h"

@implementation YCLineChart

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)setYValues:(NSArray *)yValues {
    _yValues = yValues;
    [self setYLabels:yValues];
}

- (void)setYLabels:(NSArray *)yLabels
{
    NSInteger max = 0;
    NSInteger min = 1000000000;

    for (NSArray * ary in yLabels) {
        for (NSString *valueString in ary) {
            NSInteger value = [valueString integerValue];
            if (value > max) {
                max = value;
            }
            if (value < min) {
                min = value;
            }
        }
    }
    
    if (max < 6) {
        max = 6;
    }
    
    if (self.showRange) {
        _yValueMin = min;
    } else {
        _yValueMin = 0;
    }
    _yValueMax = max;
    
    if (_chooseRange.max != _chooseRange.min) {
        _yValueMax = _chooseRange.max;
        _yValueMin = _chooseRange.min;
    }

    CGFloat level = (_yValueMax - _yValueMin) / 5.0;
    CGFloat chartCavanHeight = self.frame.size.height - YCLabelHeight * 3;
    CGFloat levelHeight = chartCavanHeight / 5.0;

    for (int i = 0; i < 6; i++) {
        YCChartLabel * label = [[YCChartLabel alloc] initWithFrame:CGRectMake(0.0, chartCavanHeight - i * levelHeight + 5, YCYLabelwidth, YCLabelHeight)];
		label.text = [NSString stringWithFormat:@"%d", (int)(level * i + _yValueMin)];
		[self addSubview:label];
    }
    
    if ([super respondsToSelector:@selector(setMarkRange:)]) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(YCYLabelwidth, (1 - (_markRange.max - _yValueMin) / (_yValueMax-_yValueMin)) * chartCavanHeight + YCLabelHeight, self.frame.size.width - YCYLabelwidth, (_markRange.max - _markRange.min) / (_yValueMax-_yValueMin) * chartCavanHeight)];
        view.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.1];
        [self addSubview:view];
    }

    // 画横线
    for (int i = 0; i < 6; i++) {
        if ([_showHorizonLine[i] boolValue]) {
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(YCYLabelwidth, YCLabelHeight + i * levelHeight)];
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
    CGFloat num = 0;
    if (xLabels.count >= 20) {
        num = 20.0;
    } else if (xLabels.count <= 1) {
        num = 1.0;
    } else {
        num = xLabels.count;
    }
    _xLabelWidth = (self.frame.size.width - YCYLabelwidth) / num;
    
    for (int i = 0; i < xLabels.count; i++) {
        NSString *labelText = xLabels[i];
        YCChartLabel * label = [[YCChartLabel alloc] initWithFrame:CGRectMake(i * _xLabelWidth + YCYLabelwidth, self.frame.size.height - YCLabelHeight, _xLabelWidth, YCLabelHeight)];
        label.text = labelText;
        [self addSubview:label];
    }
    
    // 画竖线
    for (int i = 0; i < xLabels.count + 1; i++) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(YCYLabelwidth + i * _xLabelWidth, YCLabelHeight)];
        [path addLineToPoint:CGPointMake(YCYLabelwidth + i * _xLabelWidth, self.frame.size.height - 2 * YCLabelHeight)];
        [path closePath];
        shapeLayer.path = path.CGPath;
        shapeLayer.strokeColor = [[[UIColor blackColor] colorWithAlphaComponent:0.1] CGColor];
        shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
        shapeLayer.lineWidth = 1;
        [self.layer addSublayer:shapeLayer];
    }
}

- (void)strokeChart {
    for (int i = 0; i < _yValues.count; i++) {
        NSArray *childAry = _yValues[i];
        if (childAry.count==0) {
            return;
        }
        
        // 获取最大最小位置
        CGFloat max = [childAry[0] floatValue];
        CGFloat min = [childAry[0] floatValue];
        NSInteger max_i = 0;
        NSInteger min_i = 0;
        
        for (int j = 0; j < childAry.count; j++) {
            CGFloat num = [childAry[j] floatValue];
            if (max <= num) {
                max = num;
                max_i = j;
            }
            if (min >= num) {
                min = num;
                min_i = j;
            }
        }
        
        //划线
        CAShapeLayer *_chartLine = [CAShapeLayer layer];
        _chartLine.lineCap = kCALineCapRound;
        _chartLine.lineJoin = kCALineJoinBevel;
        _chartLine.fillColor = [UIColor whiteColor].CGColor;
        _chartLine.lineWidth = 2.0;
        _chartLine.strokeEnd = 0.0;
        [self.layer addSublayer:_chartLine];
        
        UIBezierPath *progressline = [UIBezierPath bezierPath];
        CGFloat firstValue = [childAry[0] floatValue];
        CGFloat xPosition = (YCYLabelwidth + _xLabelWidth / 2.0);
        CGFloat chartCavanHeight = self.frame.size.height - YCLabelHeight * 3;
        
        float grade = ((float)firstValue - _yValueMin) / ((float)_yValueMax - _yValueMin);
       
        //第一个点
        BOOL isShowMaxAndMinPoint = YES;
        if (self.showMaxMinArray) {
            if ([self.showMaxMinArray[i] intValue] > 0) {
                isShowMaxAndMinPoint = (max_i == 0 || min_i == 0) ? NO : YES;
            } else {
                isShowMaxAndMinPoint = YES;
            }
        }
        
        [self addPoint:CGPointMake(xPosition, chartCavanHeight - grade * chartCavanHeight + YCLabelHeight)
                 index:i
                isShow:isShowMaxAndMinPoint
                 value:firstValue];

        
        [progressline moveToPoint:CGPointMake(xPosition, chartCavanHeight - grade * chartCavanHeight+YCLabelHeight)];
        [progressline setLineWidth:2.0];
        [progressline setLineCapStyle:kCGLineCapRound];
        [progressline setLineJoinStyle:kCGLineJoinRound];
        NSInteger index = 0;
        for (NSString * valueString in childAry) {
            
            float grade =([valueString floatValue] - _yValueMin) / ((float)_yValueMax - _yValueMin);
            if (index != 0) {
                
                CGPoint point = CGPointMake(xPosition+index * _xLabelWidth, chartCavanHeight - grade * chartCavanHeight + YCLabelHeight);
                [progressline addLineToPoint:point];
                
                BOOL isShowMaxAndMinPoint = YES;
                if (self.showMaxMinArray) {
                    if ([self.showMaxMinArray[i] intValue] > 0) {
                        isShowMaxAndMinPoint = !(max_i == index || min_i == index);
                    } else {
                        isShowMaxAndMinPoint = YES;
                    }
                }
                [progressline moveToPoint:point];
                [self addPoint:point
                         index:i
                        isShow:isShowMaxAndMinPoint
                         value:[valueString floatValue]];
            }
            index += 1;
        }
        
        _chartLine.path = progressline.CGPath;
        if ([[_colors objectAtIndex:i] CGColor]) {
            _chartLine.strokeColor = [_colors[i] CGColor];
        } else {
            _chartLine.strokeColor = [UIColor YCGreenColor].CGColor;
        }
        
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = childAry.count * 0.4;
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        pathAnimation.fromValue = @0;
        pathAnimation.toValue = @1;
        pathAnimation.autoreverses = NO;
        [_chartLine addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
        
        _chartLine.strokeEnd = 1.0;
    }
}

- (void)addPoint:(CGPoint)point index:(NSInteger)index isShow:(BOOL)isHollow value:(CGFloat)value
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(5, 5, 8, 8)];
    view.center = point;
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 4;
    view.layer.borderWidth = 2;
    view.layer.borderColor = [_colors[index] CGColor] ? [_colors[index] CGColor] : [UIColor YCGreenColor].CGColor;
    
    if (isHollow) {
        view.backgroundColor = [UIColor whiteColor];
    } else {
        view.backgroundColor = _colors[index] ? _colors[index] : [UIColor YCGreenColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(point.x - YCTagLabelwidth / 2.0, point.y - YCLabelHeight * 2, YCTagLabelwidth, YCLabelHeight)];
        label.font = [UIFont systemFontOfSize:10];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = view.backgroundColor;
        label.text = [NSString stringWithFormat:@"%d",(int)value];
        [self addSubview:label];
    }
    
    [self addSubview:view];
}


@end
