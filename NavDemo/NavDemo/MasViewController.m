//
//  MasViewController.m
//  NavDemo
//
//  Created by Vanessa on 15/5/26.
//  Copyright (c) 2015年 BitAuto. All rights reserved.
//

#import "MasViewController.h"
#import "Masonry.h"
#import "RRToolkit/RRToolkit.h"

@interface MasViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (nonatomic) double leftPreviousValue;
@property (nonatomic) double rightPreviousValue;
- (IBAction)leftControl:(UIStepper *)sender;
- (IBAction)rightControl:(UIStepper *)sender;
- (IBAction)adjustScale:(UISlider *)sender;

@end

@implementation MasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.containerView.backgroundColor = self.bkColor;
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.tag = 100;
    label1.backgroundColor = [UIColor yellowColor];
    label1.text = @"label";
    [self.containerView addSubview:label1];
    
    UILabel *label2 = [UILabel new];
    label2.tag = 101;
    label2.backgroundColor = [UIColor greenColor];
    label2.text = @"label";
    [self.containerView addSubview:label2];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_containerView.mas_top).offset(5);
        make.left.equalTo(_containerView.mas_left).offset(2);
        make.height.mas_equalTo(@40);
    }];
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_top);
        make.left.equalTo(label1.mas_right).offset(2);
        make.right.lessThanOrEqualTo(_containerView.mas_right).offset(-2);
        make.height.equalTo(label1.mas_height);
    }];
    
    [label1 setContentHuggingPriority:UILayoutPriorityRequired
                              forAxis:UILayoutConstraintAxisHorizontal];
    [label1 setContentCompressionResistancePriority:UILayoutPriorityRequired
                                            forAxis:UILayoutConstraintAxisHorizontal];
    
    [label2 setContentHuggingPriority:UILayoutPriorityRequired
                              forAxis:UILayoutConstraintAxisHorizontal];
    [label2 setContentCompressionResistancePriority:UILayoutPriorityDefaultLow
                                            forAxis:UILayoutConstraintAxisHorizontal];
    self.leftPreviousValue = 0;
    self.rightPreviousValue = 0;
    
    UIView *superView = [[UIView alloc] init];
    superView.tag = 102;
    superView.backgroundColor = [UIColor brownColor];
    [self.containerView addSubview:superView];
    
    UIView *subView = [UIView new];
    subView.backgroundColor = [UIColor purpleColor];
    [superView addSubview:subView];
    
    [superView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label1.mas_bottom).offset(150);
        make.width.mas_equalTo(@150);
        make.height.mas_equalTo(@40);
    }];
    
    [subView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView.mas_top);
        make.bottom.equalTo(superView.mas_bottom);
        make.left.equalTo(superView.mas_left);
        make.width.equalTo(superView.mas_width).multipliedBy(0.5);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)leftControl:(UIStepper *)sender {
    UILabel *label = (UILabel *)[self.containerView viewWithTag:100];
    if (sender.value > _leftPreviousValue) {
        label.text = [label.text stringByAppendingString:@"label"];
    } else {
        label.text = [label.text substringToIndex:label.text.length - (@"label").length];
    }
    self.leftPreviousValue = sender.value;
}

- (IBAction)rightControl:(UIStepper *)sender {
    UILabel *label = (UILabel *)[self.containerView viewWithTag:101];
    if (sender.value > _rightPreviousValue) {
        label.text = [label.text stringByAppendingString:@"label"];
    } else {
        label.text = [label.text substringToIndex:label.text.length - (@"label").length];
    }
    self.rightPreviousValue = sender.value;
}

- (IBAction)adjustScale:(UISlider *)sender {
    UIView *superView = [self.containerView viewWithTag:102];
    [superView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@(superView.width * sender.value));
    }];
}

@end
