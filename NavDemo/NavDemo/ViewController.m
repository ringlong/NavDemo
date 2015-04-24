//
//  ViewController.m
//  NavDemo
//
//  Created by Ryan on 15/4/23.
//  Copyright (c) 2015年 BitAuto. All rights reserved.
//

#import "ViewController.h"
#import "UINavigationBar+Awesome.h"
#import "EYToolkit.h"
#import "MessageLayer.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

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
}

- (void)didReceiveMemoryWarning {
    [self.dataSource removeAllObjects];
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.textColor = [UIColor blackColor];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[MessageLayer sharedMessageLayer] showMessage:@"test" lastTime:2];
}

@end
