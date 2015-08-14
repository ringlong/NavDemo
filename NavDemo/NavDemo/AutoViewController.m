//
//  AutoViewController.m
//  NavDemo
//
//  Created by Ryan on 15/5/21.
//  Copyright (c) 2015年 BitAuto. All rights reserved.
//

#import "AutoViewController.h"
#import "Masonry.h"
#import "ReactiveCocoa.h"
#import "RRToolkit.h"

@interface AutoViewController ()

@property (nonatomic, strong) UIButton *anmationButton;
@property (nonatomic, assign) CGSize buttonSize;

@end

@implementation AutoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *viewA = [[UIView alloc] init];
    viewA.backgroundColor = [UIColor blackColor];
    [self.view addSubview:viewA];
    
    UIView *viewB = [[UIView alloc] init];
    viewB.backgroundColor = [UIColor redColor];
    [viewA addSubview:viewB];
    
    @weakify(self)
    [viewA mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(300, 300));
    }];
    
    [viewB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(viewA).insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    
    UIView *viewC = [[UIView alloc] init];
    viewC.backgroundColor = [UIColor orangeColor];
    [viewA addSubview:viewC];
    
    UIView *viewD = [[UIView alloc] init];
    viewD.backgroundColor = [UIColor orangeColor];
    [viewA addSubview:viewD];
    
    CGFloat padding = 10;
    
    [viewC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(viewA.mas_centerY);
        make.left.equalTo(viewA.mas_left).offset(padding);
//        make.right.equalTo(viewD.mas_left).offset(-padding);
        make.height.mas_equalTo(@150);
        make.width.mas_equalTo(@135);
//        make.width.equalTo(viewD);
    }];
    
    [viewD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(viewA.mas_centerY);
        make.left.equalTo(viewC.mas_left).offset(padding);
//        make.right.equalTo(viewA.mas_right).offset(-padding);
        make.size.equalTo(viewC);
//        make.width.equalTo(viewC);
    }];
    
    UIView *topView = UIView.new;
    topView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        UIView *topLayout = (id)self.topLayoutGuide;
        make.top.greaterThanOrEqualTo(topLayout.mas_bottom).offset(padding);
        make.height.mas_equalTo(@40);
        make.left.and.right.equalTo(self.view);
    }];
    
    UIView *bottomView = UIView.new;
    bottomView.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        UIView *bottomLayout = (id)self.bottomLayoutGuide;
        make.bottom.equalTo(bottomLayout.mas_top);
        make.height.mas_equalTo(@40);
        make.left.and.right.equalTo(self.view);
    }];
    
    self.anmationButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.anmationButton.borderWidth = 2;
    self.buttonSize = CGSizeMake(100, 100);
    self.anmationButton.size = self.buttonSize;
    self.anmationButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        self.buttonSize = CGSizeMake(1.3 * _buttonSize.width, 1.3 * _buttonSize.height);
        [self.view setNeedsUpdateConstraints];
        [self.view updateConstraintsIfNeeded];
        [UIView animateWithDuration:0.4 animations:^{
            [self.view layoutIfNeeded];
        }];
        return [RACSignal empty];
    }];
    [self.view addSubview:self.anmationButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)updateViewConstraints {
    @weakify(self)
    [self.anmationButton mas_updateConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.center.equalTo(self.view);
        make.width.lessThanOrEqualTo(self.view);
        make.height.lessThanOrEqualTo(self.view);
        make.width.mas_equalTo(@(self.buttonSize.width)).priorityLow();
        make.height.mas_equalTo(@(self.buttonSize.height)).priorityLow();
    }];
    [super updateViewConstraints];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
