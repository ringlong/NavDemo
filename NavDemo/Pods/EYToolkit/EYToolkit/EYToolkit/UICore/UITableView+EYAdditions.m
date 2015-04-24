//
//  UITableView+EYAdditions.m
//  EYToolkit
//
//  Created by Edward Yang on 14-6-12.
//  Copyright (c) 2014年 EdwardYang. All rights reserved.
//

#import "UITableView+EYAdditions.h"

@implementation UITableView (EYAdditions)

+ (instancetype)tableViewWithFrame:(CGRect)frame
                             style:(UITableViewStyle)style
                        dataSource:(id<UITableViewDataSource>)dataSource
                          delegate:(id<UITableViewDelegate>)delegate
{
    UITableView *tableView = [[[self class] alloc] initWithFrame:frame style:style];
    tableView.dataSource = dataSource;
    tableView.delegate = delegate;
    return tableView;
}

@end
