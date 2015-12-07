//
//  TestView.m
//  NavDemo
//
//  Created by Vanessa on 15/7/7.
//  Copyright (c) 2015年 BitAuto. All rights reserved.
//

#import "TestView.h"

@implementation TestView



- (void)awakeFromNib {
    self.backgroundColor = self.bgColor;
    self.layer.cornerRadius = self.cornerRadius;
}

- (void)prepareForInterfaceBuilder {
    self.backgroundColor = self.bgColor;
    self.layer.cornerRadius = self.cornerRadius;
}

@end
