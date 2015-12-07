//
//  TestView.h
//  NavDemo
//
//  Created by Vanessa on 15/7/7.
//  Copyright (c) 2015年 BitAuto. All rights reserved.
//

#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface TestView : UIView

@property (nonatomic) IBInspectable UIColor * bgColor;
@property (nonatomic) IBInspectable CGFloat cornerRadius;
@property (nonatomic) IBInspectable CGFloat buttonConnerRadius;
@property (nonatomic) IBInspectable UIColor * tapColor1;
@property (nonatomic) IBInspectable UIColor * tapColor2;
@property (nonatomic) IBInspectable CGSize circleSize;
@property (nonatomic) IBInspectable CGSize shadowSize;

@end
