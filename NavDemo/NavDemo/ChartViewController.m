//
//  ChartViewController.m
//  NavDemo
//
//  Created by Ryan on 15/5/25.
//  Copyright (c) 2015年 BitAuto. All rights reserved.
//

#import "ChartViewController.h"
#import "YCChart/YCChart.h"
#import "RRToolkit.h"
#import "SlideControl.h"
#import "YCVoteBar.h"
#import "YCVoteView.h"
#import "ReactiveCocoa.h"

@interface ChartViewController ()<YCChartDataSource>

@end

@implementation ChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    YCChart *chartView = [[YCChart alloc] initwithYCChartDataFrame:CGRectMake(10, 64 + 10, self.view.width - 20, 150) withSource:self withStyle:YCChartBarStyle];
//    [chartView showInView:self.view];
    
//    YCVoteBar *bar = [[YCVoteBar alloc] initWithFrame:CGRectMake(10, 150 + 20, [UIScreen screenWidth] - 20, 44)];
//    bar.borderColor = [UIColor lightGrayColor];
//    bar.strokeColor = [UIColor YCBlueColor];
//    bar.title = @"凯迪拉克";
//    bar.percent = @"15.5%";
//    [bar setStrokeEnd:0 animated:YES];
//    [self.view addSubview:bar];
    
    NSArray *data = @[@{@"title": @"雪佛兰科鲁兹",
                        @"count": @8},
                      @{@"title": @"凯迪拉克总统一号",
                        @"count": @1},
                      @{@"title": @"奔驰E级",
                        @"count": @1},
                      @{@"title": @"爱上一匹野马",
                        @"count": @1},
                      @{@"title": @"可我的家里没有草原",
                        @"count": @1},
                      @{@"title": @"董小姐",
                        @"count": @1},
                      @{@"title": @"奥迪Q7",
                        @"count": @1},
                      @{@"title": @"奥迪Q7",
                        @"count": @1},
                      @{@"title": @"奥迪Q7",
                        @"count": @0}];
    YCVoteView *voteView = [YCVoteView voteViewWithFrame:CGRectMake(10, 170, [UIScreen screenWidth] - 20, YCBarHeight * 9 + 31) voteData:data];
    voteView.count = 15;
    voteView.isVoted = NO;
    voteView.isVoteEnded = YES;
    [self.view addSubview:voteView];
    
    [[voteView rac_signalForSelector:@selector(setVoteBar:) fromProtocol:@protocol(YCVoteBarDelegate)] subscribeNext:^(RACTuple *x) {
        YCVoteBar *bar = x.first;
        NSLog(@"I think I got %@", @(bar.index));
    }];
    NSArray *arr = @[@1, @2, @3, @100, @10];
    NSNumber *max = [arr valueForKeyPath:@"@max.intValue"];
    NSLog(@"max:%@", max);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

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
