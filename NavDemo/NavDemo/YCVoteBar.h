//
//  YCVoteBar.h
//  NavDemo
//
//  Created by Ryan on 15/8/12.
//  Copyright (c) 2015年 BitAuto. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YCVoteBar;

@protocol YCVoteBarDelegate <NSObject>

- (void)setVoteBar:(YCVoteBar *)voteBar;

@end

@interface YCVoteBar : UIControl

/**
 *  序号
 */
@property (nonatomic, assign) NSInteger index;

/**
 *  颜色
 */
@property (nonatomic, strong) UIColor *strokeColor;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *percent;
@property (nonatomic, copy) UIColor *titleColor;

@property (nonatomic, weak) id<YCVoteBarDelegate> delegate;

- (void)setStrokeEnd:(CGFloat)strokeEnd animated:(BOOL)animated;

@end
