//
//  YCVoteView.h
//  NavDemo
//
//  Created by Ryan on 15/8/12.
//  Copyright (c) 2015年 BitAuto. All rights reserved.
//

#import <UIKit/UIKit.h>

static const CGFloat YCBarHeight = 44;

@interface YCVoteView : UIView

@property (nonatomic, assign) BOOL isVoted;             // 是否已投票
@property (nonatomic, assign) BOOL isVoteEnded;         // 是否已结束
@property (nonatomic, assign) NSInteger count;

+ (instancetype)voteViewWithFrame:(CGRect)frame voteData:(NSArray *)voteData;

@end
