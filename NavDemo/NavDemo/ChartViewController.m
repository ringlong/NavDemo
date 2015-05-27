//
//  ChartViewController.m
//  NavDemo
//
//  Created by Ryan on 15/5/25.
//  Copyright (c) 2015年 BitAuto. All rights reserved.
//

#import "ChartViewController.h"
#import "YCChart/YCChart.h"
#import "EYToolkit.h"

@interface ChartViewController ()<YCChartDataSource>

@end

@implementation ChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    YCChart *chartView = [[YCChart alloc] initwithYCChartDataFrame:CGRectMake(10, 64 + 10, self.view.width - 20, 150) withSource:self withStyle:YCChartBarStyle];
    [chartView showInView:self.view];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - YCChartDataSource

- (NSArray *)YCChart_ColorArray:(YCChart *)chart {
    return @[[UIColor blueColor]];
}

- (NSArray *)YCChart_xLableArray:(YCChart *)chart {
    return @[@"e", @"f", @"g"];
}

- (NSArray *)YCChart_yValueArray:(YCChart *)chart {
    return @[@[@"1", @"2", @"3"]];
}

- (CGRange)YCChartChooseRangeInLineChart:(YCChart *)chart {
    return CGRangeMake(5, 0);
}

- (BOOL)YCChartShowOrdinate:(YCChart *)chart {
    return YES;
}

- (BOOL)YCChartShowBarValue:(YCChart *)chart {
    return YES;
}

- (BOOL)YCChart:(YCChart *)chart showHorizonLineAtIndex:(NSInteger)index {
    return YES;
}

@end
