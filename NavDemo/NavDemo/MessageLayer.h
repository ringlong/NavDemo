//
//  MessageLayer.h
//  NavDemo
//
//  Created by Ryan on 15/4/24.
//  Copyright (c) 2015年 BitAuto. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 消息框显示状态 */
typedef NS_ENUM(NSUInteger, MessageLayerStatus){
    /** 展开 */
    MessageLayerStatusExpanding = 1,
    /** 显示 */
    MessageLayerStatusHolding,
    /** 消失 */
    MessageLayerStatusDismiss,
};

static NSUInteger MessageLayerMagQueueMax = 4;           // 最多能同时显示的消息数量，超过将丢弃
static NSTimeInterval MessageLayerDefaultTimer = 3.2;    // 默认单条消息展示时间
static NSTimeInterval MessageLayerTimerInterval = 0.005; // 消息时钟频率
static NSTimeInterval MessageLayerExpandTime = 0.3;      // 消息框展开需要的时间
static NSTimeInterval MessageLayerDissmissTime = 0.8;    // 消息框消失需要的时间
static NSTimeInterval MessageLayerMoveTime = 0.3;        // 消息框垂直方向移动需要的时间

@interface Message : NSObject

@property (nonatomic, assign) NSTimeInterval timer;       // 该条消息显示时间
@property (nonatomic, assign) NSTimeInterval persistTime; // 已经持续时间
@property (nonatomic, assign) NSTimeInterval moveTime;    // 移动时间
@property (nonatomic, assign) NSInteger index;            // 索引
@property (nonatomic, assign) BOOL isInUse;               // 是否正在使用
@property (nonatomic, assign) MessageLayerStatus status;  // 当前显示状态

@property (nonatomic, strong) UILabel *labelMessage;
@property (nonatomic, strong) UIView *background;
@property (nonatomic, copy) NSString *message;

@end


@interface MessageLayer : UIView

@property (nonatomic, strong) NSMutableArray *messageList;        // 消息列表
@property (nonatomic, strong) NSMutableArray *positionStatus;     // 当前消息框位置
@property (nonatomic, strong) NSTimer *mainTimer;                 // 时钟
@property (nonatomic, assign) NSInteger currentMessageOnShow;     // 当前显示的消息数量
@property (nonatomic, assign) NSTimeInterval currentRollTime;     // 当前消息框竖直方向移动计时
@property (nonatomic, assign) BOOL isAlreadyInitialized;          // 是否已经初始化

+ (instancetype)sharedMessageLayer;

/**
 *  显示消息
 *
 *  @param message 消息内容
 *  @param time    显示时间
 *
 *  @return true
 */
- (BOOL)showMessage:(NSString *)message lastTime:(CGFloat)time;

- (void)showBellowMessage:(NSString *)message time:(CGFloat)time;

@end
