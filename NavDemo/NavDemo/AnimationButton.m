//
//  AnimationButton.m
//  NavDemo
//
//  Created by Ryan on 15/5/9.
//  Copyright (c) 2015年 BitAuto. All rights reserved.
//

#import "AnimationButton.h"
#import <QuartzCore/QuartzCore.h>

CGFloat menuStrokeStart = 0.325;
CGFloat menuStrokeEnd = 0.9;
CGFloat hamburgerStrokeStart = 0.028;
CGFloat hamburgerStrokeEnd = 0.111;

@interface AnimationButton ()

@property (strong, nonatomic) CAShapeLayer *top;
@property (strong, nonatomic) CAShapeLayer *middle;
@property (strong, nonatomic) CAShapeLayer *bottom;

@end

@implementation AnimationButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        _top = [CAShapeLayer layer];
        _middle = [CAShapeLayer layer];
        _bottom = [CAShapeLayer layer];
        _top.path = [self shortStroke].CGPath;
        _middle.path = [self outLine].CGPath;
        _bottom.path = [self shortStroke].CGPath;
        
        for (CAShapeLayer *layer in @[_top, _middle, _bottom]) {
            layer.fillColor = [UIColor clearColor].CGColor;
            layer.strokeColor = [UIColor whiteColor].CGColor;
            layer.lineWidth = 4.;
            layer.miterLimit = 4.;
            layer.lineCap = kCALineCapRound;
            layer.masksToBounds = YES;
            
            CGPathRef strokingPath = CGPathCreateCopyByStrokingPath(layer.path, nil, 4, kCGLineCapRound, kCGLineJoinMiter, 4);
            layer.bounds = CGPathGetPathBoundingBox(strokingPath);
            layer.actions = @{@"strokeStart": [NSNull null],
                              @"strokeEnd": [NSNull null],
                              @"transform": [NSNull null]};
            [self.layer addSublayer:layer];
        }
        
        _top.anchorPoint = CGPointMake(28 / 30, 0.5);
        _top.position = CGPointMake(40, 18);
        
        _middle.position = CGPointMake(27, 27);
        _middle.strokeStart = hamburgerStrokeStart;
        _middle.strokeEnd = hamburgerStrokeEnd;
        
        _bottom.anchorPoint = CGPointMake(28 / 30, 0.5);
        _bottom.position = CGPointMake(40, 36);
    }
    return self;
}

- (UIBezierPath *)shortStroke {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(2, 2)];
    [path addLineToPoint:CGPointMake(28, 2)];
    return path;
}

- (UIBezierPath *)outLine {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(10, 27)];
    [path addCurveToPoint:CGPointMake(40, 27) controlPoint1:CGPointMake(12, 27) controlPoint2:CGPointMake(28.02, 27.00)];
    [path addCurveToPoint:CGPointMake(27, 2) controlPoint1:CGPointMake(55.92, 27.00) controlPoint2:CGPointMake(50.47, 2.00)];
    [path addCurveToPoint:CGPointMake(2, 27) controlPoint1:CGPointMake(13.16, 2.00) controlPoint2:CGPointMake(2.00, 13.16)];
    [path addCurveToPoint:CGPointMake(27, 52) controlPoint1:CGPointMake(2.00, 40.84) controlPoint2:CGPointMake(13.16, 52.00)];
    [path addCurveToPoint:CGPointMake(52, 27) controlPoint1:CGPointMake(40.84, 52.00) controlPoint2:CGPointMake(52.00, 40.84)];
    [path addCurveToPoint:CGPointMake(27, 2) controlPoint1:CGPointMake(52.00, 13.16) controlPoint2:CGPointMake(42.39, 2.00)];
    [path addCurveToPoint:CGPointMake(2, 27) controlPoint1:CGPointMake(13.16, 2.00) controlPoint2:CGPointMake(2.00, 13.16)];
    return path;
}

- (void)setShowMenu:(BOOL)showMenu {
    _showMenu = showMenu;
    CABasicAnimation *strokeStart = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    CABasicAnimation *strokeEnd = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    CABasicAnimation *topTransform = [CABasicAnimation animationWithKeyPath:@"transform"];
    CABasicAnimation *bottomTransform = [topTransform copy];
    
    if (showMenu) {
        strokeStart.toValue = @(menuStrokeStart);
        strokeStart.duration = 0.5;
        strokeStart.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25 :-0.4 :0.5 :1];
        
        strokeEnd.toValue = @(menuStrokeEnd);
        strokeEnd.duration = 0.6;
        strokeEnd.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25 :-0.4 :0.5 :1];
        
        CATransform3D translation = CATransform3DMakeTranslation(-4, 0, 0);
        topTransform.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(translation, -M_PI_4, 0, 0, 1)];
        topTransform.beginTime = CACurrentMediaTime() + 0.25;
        
        bottomTransform.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(translation, M_PI_4, 0, 0, 1)];
        bottomTransform.beginTime = CACurrentMediaTime() + 0.25;
    } else {
        strokeStart.toValue = @(hamburgerStrokeStart);
        strokeStart.duration = 0.5;
        strokeStart.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25 :0 :0.5 :1.2];
        strokeStart.beginTime = CACurrentMediaTime() + 0.1;
        strokeStart.fillMode = kCAFillModeBackwards;
        
        strokeEnd.toValue = @(hamburgerStrokeEnd);
        strokeEnd.duration = 0.6;
        strokeEnd.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25 :0.3 :0.5 :0.9];
        
        topTransform.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        topTransform.beginTime = CACurrentMediaTime() + 0.05;
        
        bottomTransform.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        bottomTransform.beginTime = CACurrentMediaTime() + 0.05;
    }
    [self ocb_applyAnimation:strokeStart onLayer:_middle];
    [self ocb_applyAnimation:strokeEnd onLayer:_middle];
    [self ocb_applyAnimation:topTransform onLayer:_top];
    [self ocb_applyAnimation:bottomTransform onLayer:_bottom];
}

- (void)ocb_applyAnimation:(CABasicAnimation *)animation onLayer:(CALayer *)layer{
    if (!animation.fromValue) {
        animation.fromValue = [layer.presentationLayer valueForKey:animation.keyPath];
    }
    [layer addAnimation:animation forKey:animation.keyPath];
    [layer setValue:animation.toValue forKeyPath:animation.keyPath];
}

@end
