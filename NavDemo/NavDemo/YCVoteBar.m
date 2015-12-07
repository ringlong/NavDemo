//
//  YCVoteBar.m
//  NavDemo
//
//  Created by Ryan on 15/8/12.
//  Copyright (c) 2015年 BitAuto. All rights reserved.
//

#import "YCVoteBar.h"
#import "pop.h"
#import "RRToolkit.h"

@interface YCVoteBar ()

@property (nonatomic, strong) CAShapeLayer *strokeLayer;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *percentLabel;

@end

@implementation YCVoteBar

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self.layer addSublayer:self.strokeLayer];
        [self addSubview:self.titleLabel];
        [self addSubview:self.percentLabel];
        [self addTarget:self action:@selector(tapVoteBar) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing Background
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
        
    // Drawing Left Marigin
    UIBezierPath *leftMargin = [UIBezierPath bezierPathWithRect:CGRectMake(0, 2, 5, CGRectGetHeight(rect) - 4)];
    [[UIColor colorWithHexString:@"f6f6f6"] setFill];
    [leftMargin fill];
}

#pragma mark - Setter & Getter

- (CAShapeLayer *)strokeLayer {
    if (!_strokeLayer) {
        CGFloat lineWidth = self.height - 2;
        
        UIBezierPath *voteline = [UIBezierPath bezierPath];
        [voteline moveToPoint:CGPointMake(0, self.height * 0.5)];
        [voteline addLineToPoint:CGPointMake(self.width, self.height * 0.5)];
        voteline.lineCapStyle = kCGLineCapButt;
        
        _strokeLayer = CAShapeLayer.layer;
        _strokeLayer.path = voteline.CGPath;
        _strokeLayer.lineWidth = lineWidth;
        _strokeLayer.strokeEnd = 0;
        _strokeLayer.lineCap = kCALineCapButt;
        _strokeLayer.strokeColor = nil;
        _strokeLayer.fillColor = nil;
    }
    return _strokeLayer;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.width - 15, 20)];
        _titleLabel.centerY = self.height * 0.5;
        _titleLabel.textColor = [UIColor blueColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _titleLabel;
}

- (UILabel *)percentLabel {
    if (!_percentLabel) {
        _percentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 50, 20)];
        _percentLabel.centerY = self.height * 0.5;
        _percentLabel.left = self.width - 15 - 50;
        _percentLabel.textColor = [UIColor lightGrayColor];
        _percentLabel.textAlignment = NSTextAlignmentRight;
        _percentLabel.font = [UIFont systemFontOfSize:16];
    }
    return _percentLabel;
}

- (void)setStrokeColor:(UIColor *)strokeColor {
    _strokeColor = strokeColor;
    self.strokeLayer.strokeColor = strokeColor.CGColor;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = title;
}

- (void)setPercent:(NSString *)percent {
    _percent = percent;
    _percentLabel.text = percent;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    _titleLabel.textColor = titleColor;
}

#pragma mark - Instance Method

- (void)setStrokeEnd:(CGFloat)strokeEnd animated:(BOOL)animated {
    if (animated) {
        POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
        animation.toValue = @(strokeEnd);
        animation.springBounciness = 10.f;
        animation.removedOnCompletion = NO;
        [self.strokeLayer pop_addAnimation:animation forKey:@"stroke"];
        return;
    }
    self.strokeLayer.strokeEnd = strokeEnd;
}

- (void)tapVoteBar {
    self.titleColor = [UIColor colorWithHexString:@"333333"];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    self.percentLabel.textColor = [UIColor colorWithHexString:@"333333"];
    if ([self.delegate respondsToSelector:@selector(setVoteBar:)]) {
        [self.delegate setVoteBar:self];
    }
}

@end
