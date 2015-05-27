//
//  MasViewController.m
//  NavDemo
//
//  Created by Vanessa on 15/5/26.
//  Copyright (c) 2015年 BitAuto. All rights reserved.
//

#import "MasViewController.h"
#import "Masonry.h"

@interface MasViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (nonatomic) double leftPreviousValue;
- (IBAction)leftControl:(UIStepper *)sender;
- (IBAction)rightControl:(UIStepper *)sender;

@end

@implementation MasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    if (sender.value > _leftPreviousValue) {
        label.text = [label.text stringByAppendingString:@"label"];
    } else {
        label.text = [label.text substringToIndex:label.text.length - (@"label").length];
    }
    self.leftPreviousValue = sender.value;
}
@end
