//
//  CircleViewController.m
//  NavDemo
//
//  Created by Ryan on 15/7/10.
//  Copyright (c) 2015年 BitAuto. All rights reserved.
//

#import "CircleViewController.h"
#import "CircleView.h"
#import "Masonry.h"

@interface CircleViewController ()

@property (nonatomic, strong) CircleView *circleView;
@property (nonatomic, strong) UISlider *slider;

- (void)sliderChangeed:(UISlider *)sender;

@end

@implementation CircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.circleView];
    [self.view addSubview:self.slider];
    [self.circleView setStrokeEnd:self.slider.value animated:YES];
    
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.circleView.mas_bottom).offset(40);
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.circleView);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - setter & getter

- (CircleView *)circleView {
    if (!_circleView) {
        _circleView = [[CircleView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        _circleView.strokeColor = [UIColor colorWithRed: 0 green: 0.659 blue: 1 alpha: 1];
        _circleView.center = self.view.center;
    }
    return _circleView;
}

- (UISlider *)slider {
    if (!_slider) {
        _slider = [UISlider new];
        _slider.value = 0.7;
        _slider.tintColor = [UIColor colorWithRed: 0 green: 0.659 blue: 1 alpha: 1];
        [_slider addTarget:self action:@selector(sliderChangeed:) forControlEvents:UIControlEventValueChanged];
    }
    return _slider;
}

#pragma mark - Private Instance Method

- (void)sliderChangeed:(UISlider *)sender {
    [self.circleView setStrokeEnd:sender.value animated:YES];
}

@end
