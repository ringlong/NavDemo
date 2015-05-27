//
//  ViewController.h
//  NavDemo
//
//  Created by Ryan on 15/4/23.
//  Copyright (c) 2015年 BitAuto. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MBProgressHUD;

@interface ViewController : UITableViewController

@property (nonatomic, strong) MBProgressHUD *hud;

- (void)showHudWithText:(NSString *)text time:(NSTimeInterval)time complitionHandler:(void (^)())handler;

- (void)showHudWithText:(NSString *)text image:(UIImage *)image complitionHandler:(void (^)())handler;

@end

