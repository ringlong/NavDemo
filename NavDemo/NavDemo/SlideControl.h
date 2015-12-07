//
//  SlideControl.h
//  NavDemo
//
//  Created by Ryan on 15/6/1.
//  Copyright (c) 2015年 BitAuto. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  滑块的位置， 位置不同时，背景图片不同，TitleLabel的位置也不同，需要据此判断
 */
typedef NS_ENUM(NSUInteger, SlideControlPosition) {
    SlideControlPositionTop,
    SlideControlPositionMid,
    SlideControlPositionBottom,
};

/**
 *  滑动之后的回调
 *
 *  @param min 最小值
 *  @param max 最大值
 */
typedef void(^swipeHandler)(NSInteger min, NSInteger max);

@interface SlideControl : UIView

@property (nonatomic, copy) swipeHandler swipeHandler;

@end

/**
 *  自定义滑动Button
 */
@interface SlideButton : UIButton

@property (nonatomic, assign) SlideControlPosition position;
- (instancetype)initWithImage:(UIImage *)image position:(SlideControlPosition)position;

@end
