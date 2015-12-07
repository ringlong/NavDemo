//
//  ViewController.m
//  NavDemo
//
//  Created by Ryan on 15/4/23.
//  Copyright (c) 2015年 BitAuto. All rights reserved.
//

#import "ViewController.h"
#import "UINavigationBar+Awesome.h"
#import "RRToolkit.h"
#import "MessageLayer.h"
#import "NetworkManager.h"
#import "MJRefresh.h"
#import "LoginViewController.h"
#import "RACEXTScope.h"
#import "MBProgressHUD.h"
#import "POP.h"
#import "AutoViewController.h"
#import "WaterFallViewController.h"
#import "ChartViewController.h"
#import "MasViewController.h"
#import "SonLayer.h"
#import "RRActionSheet.h"
#import "GradientViewController.h"
#import "SearchViewController.h"
#import "CustomeTableViewCell.h"
#import "DecayViewController.h"
#import "CircleViewController.h"
#import "ImageViewController.h"
#import "RRActionSheet.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, RRActionSheetDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"title";
    self.dataSource = [NSMutableArray arrayWithCapacity:20];
    for (NSInteger index = 0; index < 20; index++) {
        [self.dataSource addObject:[NSString stringWithFormat:@"text%ld", (long)index]];
    }
    UIImageView *topImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 232)];
    topImage.image = [UIImage imageNamed:@"per_center_bg"];
    self.tableView.tableHeaderView = topImage;
    
    @weakify(self)
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        [[MessageLayer sharedMessageLayer] showMessage:@"刷新完成" lastTime:2];
        [self.tableView.header endRefreshing];
    }];
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)
        [self loadMore];
    }];
        
    [self setUpHud];
    [self test];
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.sectionHeaderHeight = 30;
    self.tableView.separatorColor = [UIColor colorWithRGBHex:0xececec];
    if ([self.tableView respondsToSelector:@selector(setSectionIndexBackgroundColor:)]) {
        self.tableView.sectionIndexBackgroundColor = [UIColor colorWithRGBHex:0xf5f5f5];
    }
}

- (void)test {
}

- (void)setUpHud {
    if (!self.hud) {
        self.hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        self.hud.square = YES;
        [self.navigationController.view addSubview:self.hud];
    }
}

- (void)loadMore {
    [self.tableView reloadData];
    [self.tableView.footer endRefreshing];
    [self.tableView.footer resetNoMoreData];
}


- (void)didReceiveMemoryWarning {
    [self.dataSource removeAllObjects];
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - HUD

- (void)showHudWithText:(NSString *)text time:(NSTimeInterval)time complitionHandler:(void (^)())handler {
    self.hud.labelText = text;
    [self.hud showAnimated:YES whileExecutingBlock:^{
        handler();
    }];
}

- (void)showHudWithText:(NSString *)text image:(UIImage *)image complitionHandler:(void (^)())handler {
    self.hud.labelText = text;
    self.hud.mode = MBProgressHUDModeCustomView;
    self.hud.customView = [[UIImageView alloc] initWithImage:image];
    [self.hud showAnimated:YES whileExecutingBlock:^{
        handler();
    }];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat offsetY = scrollView.contentOffset.y;
//    CGFloat scale;
//    if (offsetY > 0) {
//        scale = offsetY / self.view.height;
//    }
//    POPBasicAnimation *animaition = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
//    animaition.fromValue = @1;
//    animaition.toValue = @(scale);
//    [self.tableView.tableHeaderView pop_addAnimation:animaition forKey:@"pop"];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[CustomeTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.detailTextLabel.textAlignment = NSTextAlignmentLeft;
    cell.detailTextLabel.text = @"detail";
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"test";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1) {
        LoginViewController *loginView = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginView animated:YES];
    }
    if (indexPath.row == 2) {
        AutoViewController *autoo = [[AutoViewController alloc] init];
        [self.navigationController pushViewController:autoo animated:YES];
    }
    if (indexPath.row == 3) {
//        WaterFallViewController *waterFall = [[WaterFallViewController alloc] init];
//        [self.navigationController pushViewController:waterFall animated:YES];
    }
    if (indexPath.row == 4) {
        ChartViewController *chartView = [[ChartViewController alloc] init];
        [self.navigationController pushViewController:chartView animated:YES];
    }
    if (indexPath.row == 5) {
        MasViewController *masView = [[MasViewController alloc] init];
        [self.navigationController pushViewController:masView animated:YES];
    }
    if (indexPath.row == 6) {
        SearchViewController *search = [[SearchViewController alloc] init];
        [self.navigationController pushViewController:search animated:YES];
    }
    if (indexPath.row == 7) {
        DecayViewController *decay = [[DecayViewController alloc] init];
        [self.navigationController pushViewController:decay animated:YES];
    }
    if (indexPath.row == 8) {
        CircleViewController *circle = [[CircleViewController alloc] init];
        [self.navigationController pushViewController:circle animated:YES];
    }
    if (indexPath.row == 9) {
        ImageViewController *image = [ImageViewController new];
        [self.navigationController pushViewController:image animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
