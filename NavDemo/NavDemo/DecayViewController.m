//
//  DecayViewController.m
//  NavDemo
//
//  Created by Ryan on 15/7/10.
//  Copyright (c) 2015年 BitAuto. All rights reserved.
//

#import "DecayViewController.h"
#import "pop.h"
#import "RRToolkit.h"

@interface DecayViewController ()<POPAnimationDelegate>

@property (nonatomic, strong) UIControl *dragView;

- (void)addDragView;
- (void)handlePan:(UIPanGestureRecognizer *)recognizer;
- (void)touchDown:(UIControl *)sender;

@end

@implementation DecayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self addDragView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private Instance Methods

- (void)addDragView {
    self.dragView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.dragView.center = self.view.center;
    self.dragView.layer.cornerRadius = self.dragView.width / 2;
    self.dragView.backgroundColor = [UIColor colorWithRed: 0 green: 0.659 blue: 1 alpha: 1];
    [self.dragView addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchUpInside];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.dragView addGestureRecognizer:pan];
    [self.view addSubview:self.dragView];
}

- (void)touchDown:(UIControl *)sender {
    [sender.layer pop_removeAllAnimations];
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.centerX += translation.x;
    recognizer.view.centerY += translation.y;
    [recognizer setTranslation:CGPointZero inView:self.view];
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [recognizer velocityInView:self.view];
        NSLog(@"%@", NSStringFromCGPoint(velocity));
        
        POPDecayAnimation *animation = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPosition];
        animation.delegate = self;
        animation.velocity = [NSValue valueWithCGPoint:velocity];
        [recognizer.view.layer pop_addAnimation:animation forKey:@"123"];
    }
}

#pragma mark - POPAnimationDelegate

- (void)pop_animationDidApply:(POPDecayAnimation *)anim {
    BOOL isDragViewOutsideOfSuperView = !CGRectContainsRect(self.view.frame, self.dragView.frame);
    if (isDragViewOutsideOfSuperView) {
        CGPoint currentVelocity = [anim.velocity CGPointValue];
        CGPoint velocity = CGPointMake(currentVelocity.x, -currentVelocity.y);
        
        POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
        animation.velocity = [NSValue valueWithCGPoint:velocity];
        animation.toValue = [NSValue valueWithCGPoint:self.view.center];
        [self.dragView.layer pop_addAnimation:animation forKey:@"123"];
    }
}

@end
