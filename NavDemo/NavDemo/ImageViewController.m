//
//  ImageViewController.m
//  NavDemo
//
//  Created by Ryan on 15/7/10.
//  Copyright (c) 2015年 BitAuto. All rights reserved.
//

#import "ImageViewController.h"
#import "pop.h"
#import "RRToolkit.h"

typedef struct {
    CGFloat progress;
    CGFloat toValue;
    CGFloat currentValue;
} AnimationInfo;

@interface ImageViewController ()

@property (nonatomic, strong) UIImageView *imageView;

- (void)handlePan:(UIPanGestureRecognizer *)recognizer;
- (void)handleTap:(UITapGestureRecognizer *)recognizer;
- (AnimationInfo)animationInfoForLayer:(CALayer *)layer;
- (void)scaleDownView:(UIView *)view;
- (void)scaleUpView:(UIView *)view;
- (void)pauseAllAnimations:(BOOL)pause forLayer:(CALayer *)layer;

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imageView];
    [self scaleDownView:self.imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private Getter

- (UIImageView *)imageView {
    if (!_imageView) {
        CGFloat width = CGRectGetWidth(self.view.bounds) - 20;
        CGFloat height = roundf(width * 0.75);
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        _imageView.center = self.view.center;
        _imageView.image = [UIImage imageNamed:@"per_center_bg"];
        _imageView.userInteractionEnabled = YES;
        _imageView.cornerRadius = 4;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        [_imageView addGestureRecognizer:tap];
        [_imageView addGestureRecognizer:pan];
    }
    return _imageView;
}

#pragma mark - Private Instance Method

- (void)scaleDownView:(UIView *)view {
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    animation.toValue = [NSValue valueWithCGSize:CGSizeMake(0.5, 0.5)];
    animation.springBounciness = 10.;
    [view.layer pop_addAnimation:animation forKey:@"scale"];
}

- (void)scaleUpView:(UIView *)view {
    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    positionAnimation.toValue = [NSValue valueWithCGPoint:self.view.center];
    [view.layer pop_addAnimation:positionAnimation forKey:@"position"];
    
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
    animation.springBounciness = 10.;
    [view.layer pop_addAnimation:animation forKey:@"scale"];
}

- (void)pauseAllAnimations:(BOOL)pause forLayer:(CALayer *)layer {
    for (NSString *key in layer.pop_animationKeys) {
        POPAnimation *animation = [layer pop_animationForKey:key];
        animation.paused = pause;
    }
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    AnimationInfo animationInfo = [self animationInfoForLayer:recognizer.view.layer];
    BOOL hasAnimations = recognizer.view.layer.pop_animationKeys.count;
    
    if (hasAnimations && animationInfo.progress < 0.98) {
        [self pauseAllAnimations:NO forLayer:recognizer.view.layer];
        return;
    }
    
    [recognizer.view.layer pop_removeAllAnimations];
    if (animationInfo.toValue == 1 || recognizer.view.layer.affineTransform.a == 1) {
        [self scaleDownView:recognizer.view];
        return;
    }
    [self scaleUpView:recognizer.view];
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    [self scaleDownView:recognizer.view];
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.centerX += translation.x;
    recognizer.view.centerY += translation.y;
    [recognizer setTranslation:CGPointZero inView:self.view];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [recognizer velocityInView:self.view];
        
        POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
        animation.velocity = [NSValue valueWithCGPoint:velocity];
        animation.dynamicsTension = 10.;
        animation.dynamicsFriction = 1.;
        animation.springBounciness = 12.;
        [recognizer.view.layer pop_addAnimation:animation forKey:@"position"];
    }
}

- (AnimationInfo)animationInfoForLayer:(CALayer *)layer {
    POPSpringAnimation *animation = [layer pop_animationForKey:@"scale"];
    CGPoint toValue = [animation.toValue CGPointValue];
    CGPoint currentValue = [[animation valueForKey:@"currentValue"] CGPointValue];
    
    CGFloat min = MIN(toValue.x, currentValue.x);
    CGFloat max = MAX(toValue.x, currentValue.x);
    
    AnimationInfo info;
    info.toValue = toValue.x;
    info.currentValue = currentValue.x;
    info.progress = min / max;
    return info;
}

@end
