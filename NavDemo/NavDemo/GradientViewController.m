//
//  GradientViewController.m
//  NavDemo
//
//  Created by Vanessa on 15/7/21.
//  Copyright (c) 2015年 BitAuto. All rights reserved.
//

#import "GradientViewController.h"

@interface GradientViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *transcantTextView;
@property (weak, nonatomic) IBOutlet UITextView *originalTextView;

@property (strong, nonatomic) CADisplayLink *displayLink;
@property (strong, nonatomic) CAGradientLayer *gradient;
@property (assign, nonatomic) BOOL initLayout;
@property (assign, nonatomic) BOOL order;

- (IBAction)endEdit:(UITapGestureRecognizer *)sender;

@end

@implementation GradientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gradient.startPoint = CGPointMake(0, 0);
    self.gradient.endPoint = CGPointMake(1, 1);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (!self.initLayout) {
        self.gradient.frame = _originalTextView.bounds;
        
        _originalTextView.frame = _originalTextView.bounds;
        _gradient.colors = @[(id)[UIColor colorWithRed:0 green:0.46 blue:1 alpha:1].CGColor,
                             (id)[UIColor colorWithRed:0.91 green:0.28 blue:0.5 alpha:1].CGColor];
        _gradient.locations = @[@0.0, @1.0];
        
        _gradient.mask = _originalTextView.layer;

        [_transcantTextView.layer addSublayer:_gradient];
    }
}

- (CAGradientLayer *)gradient {
    if (!_gradient) {
        _gradient = [CAGradientLayer layer];
    }
    return _gradient;
}

- (IBAction)endEdit:(UITapGestureRecognizer *)sender {
    [_transcantTextView resignFirstResponder];
}

- (void)callBackShimmer {
    if (self.order) {
        self.gradient.startPoint = CGPointMake(0, _gradient.startPoint.y + 0.01);
        self.gradient.endPoint = CGPointMake(_gradient.endPoint.x - 0.01, 1.0);
        
        if (self.gradient.startPoint.y >= 1) {
            self.order = NO;
        }
    } else {
        self.gradient.startPoint = CGPointMake(0, _gradient.startPoint.y - 0.01);
        self.gradient.endPoint = CGPointMake(_gradient.endPoint.x + 0.01, 1.0);
        
        if (self.gradient.startPoint.y <= 0) {
            self.order = YES;
        }
    }
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    _originalTextView.text = textView.text;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if (self.displayLink) {
        [self.displayLink invalidate];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(callBackShimmer)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

@end
