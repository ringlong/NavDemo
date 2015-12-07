//
//  AppDelegate.m
//  NavDemo
//
//  Created by Ryan on 15/4/23.
//  Copyright (c) 2015年 BitAuto. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

#if DEBUG
#import "FLEXManager.h"
#endif

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    ViewController *view = [[ViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:view];
    self.window.rootViewController = nav;
    
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blueColor],
                                                         NSFontAttributeName: [UIFont systemFontOfSize:21]};
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    return YES;
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
#if DEBUG
        [[FLEXManager sharedManager] showExplorer];
#endif
    }
}

@end
