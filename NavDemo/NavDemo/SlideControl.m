//
//  SlideControl.m
//  NavDemo
//
//  Created by Ryan on 15/6/1.
//  Copyright (c) 2015年 BitAuto. All rights reserved.
//

#import "SlideControl.h"
#import "RRToolkit/RRToolkit.h"

static const CGFloat gap = 5;           // 最小值与最大值之间的间隙
CGFloat position0;                      // 坐标起始位置
CGFloat positionMax;                    // 坐标终点位置
CGFloat position5;
CGFloat position10;
CGFloat position15;
CGFloat position20;
CGFloat position25;
CGFloat position40;
CGFloat position60;
CGFloat position80;
CGFloat position100;

@interface SlideControl ()

@property (nonatomic, assign) CGFloat leftValue;                   // 左坐标值
@property (nonatomic, assign) CGFloat rightValue;                  // 右坐标值
@property (nonatomic, assign) NSInteger minValue;                  // 最小值
@property (nonatomic, assign) NSInteger maxValue;                  // 最大值
@property (nonatomic, strong) SlideButton *leftSlider;             // 左滑动快
@property (nonatomic, strong) SlideButton *rightSlider;            // 右滑动快
@property (nonatomic, strong) SlideButton *topTipImage;            // 顶部标识图
@property (nonatomic, strong) UIView *progressView;                // 进度条
@property (nonatomic, assign) BOOL isLeftSwipe;                    // 滑动方向

@end

@implementation SlideControl

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpInterface];
        [self configPosition];
        _minValue = 0;
        _maxValue = 100;
        !_swipeHandler?:_swipeHandler(_minValue, _maxValue);
    }
    return self;
}

// 配置界面
- (void)setUpInterface {
    self.backgroundColor = [UIColor whiteColor];
    self.borderColor = [UIColor blackColor];
    self.borderWidth = 1;
    
    // 标尺
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SlideBackground"] ];
    background.origin = CGPointMake((self.width - background.width) / 2, 70);
    [self addSubview:background];
    position0 = background.left;
    positionMax = background.right;
    self.leftValue = position0;
    self.rightValue = positionMax;
    
    // 左滑标
    self.leftSlider = [[SlideButton alloc] initWithImage:[UIImage imageNamed:@"StartImage"]
                                                position:SlideControlPositionBottom];
    self.leftSlider.centerX = background.left;
    self.leftSlider.top = background.bottom + 2;
    [self.leftSlider setTitle:@"100+" forState:UIControlStateNormal];
    [self addSubview:self.leftSlider];
    
    // 右滑标
    self.rightSlider = [[SlideButton alloc] initWithImage:[UIImage imageNamed:@"EndImage"]
                                                 position:SlideControlPositionTop];
    self.rightSlider.centerX = background.right;
    self.rightSlider.bottom = background.top + 20;
    [self addSubview:self.rightSlider];
    
    // 上浮标
    self.topTipImage = [[SlideButton alloc] initWithImage:[UIImage imageNamed:@"SliderShow"]
                                                 position:SlideControlPositionMid];
    self.topTipImage.centerX = self.leftSlider.centerX;
    self.topTipImage.top = self.rightSlider.top - self.topTipImage.height - 10;
    self.topTipImage.hidden = YES;
    [self addSubview:self.topTipImage];
    
    // 进度条
    self.progressView = [[UIView alloc] initWithFrame:CGRectMake(background.left, self.rightSlider.bottom + 8, background.width, 8)];
    self.progressView.backgroundColor = [UIColor blueColor];
    [self addSubview:self.progressView];

    // 添加手势
    UIPanGestureRecognizer *leftPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(swipeSlider:)];
    [self.leftSlider addGestureRecognizer:leftPan];
    
    UIPanGestureRecognizer *rightPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(swipeSlider:)];
    [self.rightSlider addGestureRecognizer:rightPan];
    
}

// 配置坐标值
- (void)configPosition {
    CGFloat x = (positionMax - position0) / 10.0;
    position5 = position0 + x;
    position10 = position0 + 2 * x;
    position15 = position0 + 3 * x;
    position20 = position0 + 4 * x;
    position25 = position0 + 5 * x;
    position40 = position0 + 6 * x;
    position60 = position0 + 7 * x;
    position80 = position0 + 8 * x;
    position100 = position0 + 9 * x;
}

// 根据view坐标中的值转换为坐标轴上的值
- (NSInteger)coordinateWithPosition:(CGFloat)input {
    CGFloat output = 0;
    if (input <= position0) {
        output = 0;
    } else if (input > position0 && input <= position25) {
        output = (input - position0) / (position25 - position0) * 25;
    } else if (input > position25 && input <= position40) {
        output = (input - position25) / (position40 - position25) * 15 + 25;
    } else if (input > position40 && input <= position100) {
        output = (input - position40) / (position100 - position40) * 60 + 40;
    } else if (input > position100) {
        output = 101;
    }
    return floorf(output);
}

// 滑动响应
- (void)swipeSlider:(UIPanGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan ||
        sender.state == UIGestureRecognizerStateChanged) {
        CGPoint point = [sender translationInView:self];
        if (sender.view == self.leftSlider) {
            _isLeftSwipe = YES;
            self.leftValue += point.x;
        } else {
            _isLeftSwipe = NO;
            self.rightValue += point.x;
        }
        
        if (self.rightValue < self.leftValue + gap) {
            if (_isLeftSwipe) {
                self.rightValue = self.leftValue + gap;
            } else {
                self.leftValue = self.rightValue - gap;
            }
        }
        if (self.leftValue < position0) {
            self.leftValue = position0;
        } else if (self.leftValue >= position100) {
            self.leftValue = position100;
        }
        if (self.rightValue > positionMax) {
            self.rightValue = positionMax;
        } else if (self.rightValue <= position5) {
            self.rightValue = position5;
        }
        
        [sender setTranslation:CGPointZero inView:self];
        self.topTipImage.hidden = NO;
    }
    if (sender.state == UIGestureRecognizerStateEnded) {
        self.topTipImage.hidden = YES;
        !self.swipeHandler?:self.swipeHandler(self.minValue, self.maxValue);
    }
    
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    self.minValue = [self coordinateWithPosition:self.leftValue];
    self.maxValue = [self coordinateWithPosition:self.rightValue];
    
    self.leftSlider.centerX = self.leftValue;
    self.rightSlider.centerX = self.rightValue;
    self.topTipImage.centerX = _isLeftSwipe ? self.leftValue : self.rightValue;
    self.progressView.left = self.leftValue;
    self.progressView.width = self.rightValue - self.leftValue;
    
    [self.leftSlider setTitle:@(self.minValue).stringValue forState:UIControlStateNormal];
    [self.rightSlider setTitle:@(self.maxValue).stringValue forState:UIControlStateNormal];
    [self.topTipImage setTitle:_isLeftSwipe ? @(self.minValue).stringValue : @(self.maxValue).stringValue
                      forState:UIControlStateNormal];
}

@end

@implementation SlideButton

- (instancetype)initWithImage:(UIImage *)image position:(SlideControlPosition)position {
    if (self = [self initWithFrame:CGRectZero]) {
        self.size = image.size;
        self.position = position;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        [self setImage:image forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return CGRectMake(0, 0, self.width, self.height);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat y = 0;
    switch (self.position) {
        case SlideControlPositionTop:
            y = self.height / 4;
            break;
        case SlideControlPositionMid:
            y = self.height / 3;
            break;
        case SlideControlPositionBottom:
            y = self.height * 2 / 5;
            break;
        default:
            break;
    }
    return CGRectMake(0, y, self.width, 12);
}


@end
