//
//  SonLayer.m
//  NavDemo
//
//  Created by Vanessa on 15/7/15.
//  Copyright (c) 2015年 BitAuto. All rights reserved.
//

#import "SonLayer.h"

@implementation SonLayer

- (id)init
{
    self = [super init];
    if (self) {
        NSLog(@"%@", NSStringFromClass([self class]));
        NSLog(@"%@", NSStringFromClass([super class]));
        [UIColor colorWithRed:222/255.0 green:72/255.0 blue:53/255 alpha:1];
    }
    return self;
}

@end
