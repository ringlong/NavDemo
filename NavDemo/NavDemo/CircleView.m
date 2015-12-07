//
//  CircleView.m
//  NavDemo
//
//  Created by Ryan on 15/7/10.
//  Copyright (c) 2015年 BitAuto. All rights reserved.
//

#import "CircleView.h"
#import "pop.h"

@interface CircleView ()

@property (nonatomic) CAShapeLayer *circleLayer;

@end

@implementation CircleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSAssert(frame.size.width == frame.size.height, @"宽和高必须相等");
        [self.layer addSublayer:self.circleLayer];
    }
    return self;
}

#pragma mark - setter & getter

- (CAShapeLayer *)circleLayer {
    if (!_circleLayer) {
        CGFloat lineWidth = 4;
        CGFloat radius = CGRectGetWidth(self.bounds) / 2 - lineWidth / 2;
        CGRect rect = CGRectMake(lineWidth / 2, lineWidth / 2, radius * 2, radius * 2);
        
        _circleLayer = CAShapeLayer.layer;
        _circleLayer.path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath;
        _circleLayer.lineWidth = lineWidth;
        _circleLayer.lineCap = kCALineCapRound;
        _circleLayer.lineJoin = kCALineCapRound;
        _circleLayer.strokeColor = self.tintColor.CGColor;
        _circleLayer.fillColor = nil;
    }
    return _circleLayer;
}

- (void)setStrokeColor:(UIColor *)strokeColor {
    _strokeColor = strokeColor;
    self.circleLayer.strokeColor = strokeColor.CGColor;
}

#pragma mark - Instance Method

- (void)setStrokeEnd:(CGFloat)strokeEnd animated:(BOOL)animated {
    if (animated) {
        POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
        animation.toValue = @(strokeEnd);
        animation.springBounciness = 12.f;
        animation.removedOnCompletion = NO;
        [self.circleLayer pop_addAnimation:animation forKey:@"stroke"];
        return;
    }
    self.circleLayer.strokeEnd = strokeEnd;
}

@end
