//
//  YCBar.m
//  YCChartDemo
//
//  Created by shake on 14-7-24.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import "YCBar.h"
#import "YCColor.h"

@implementation YCBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		_chartLine = [CAShapeLayer layer];
		_chartLine.lineCap = kCALineCapSquare;
		_chartLine.fillColor = [UIColor whiteColor].CGColor;
		_chartLine.lineWidth = self.frame.size.width;
		_chartLine.strokeEnd = 0.0;
		self.clipsToBounds = YES;
		[self.layer addSublayer:_chartLine];
    }
    return self;
}

- (void)setGrade:(CGFloat)grade {
    if (grade == 0) return;
    
	_grade = grade;
    
	UIBezierPath *progressline = [UIBezierPath bezierPath];
    [progressline moveToPoint:CGPointMake(self.frame.size.width / 2.0, self.frame.size.height + 30)];
	[progressline addLineToPoint:CGPointMake(self.frame.size.width / 2.0, (1 - grade) * self.frame.size.height + 15)];
    progressline.lineWidth = 1.0;
    progressline.lineCapStyle = kCGLineCapSquare;
	_chartLine.path = progressline.CGPath;

	if (_barColor) {
		_chartLine.strokeColor = _barColor.CGColor;
	} else {
		_chartLine.strokeColor = [UIColor YCGreenColor].CGColor;
	}
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.5;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = @0;
    pathAnimation.toValue = @1;
    pathAnimation.autoreverses = NO;
    [_chartLine addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    
    _chartLine.strokeEnd = 2.0;
}

- (void)drawRect:(CGRect)rect
{
	// Draw BG
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor YCLightGreyColor].CGColor);
	CGContextFillRect(context, rect);
    
}


@end
