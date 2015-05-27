//
//  UITableView+EYAdditions.h
//  EYToolkit
//
//  Created by Edward Yang on 14-6-12.
//  Copyright (c) 2014年 EdwardYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (EYAdditions)

// Quickly create a tableView.
+ (instancetype)tableViewWithFrame:(CGRect)frame
                             style:(UITableViewStyle)style
                        dataSource:(id<UITableViewDataSource>)dataSource
                          delegate:(id<UITableViewDelegate>)delegate;

@end
