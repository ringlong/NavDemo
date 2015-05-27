//
//  MessageLayer.m
//  NavDemo
//
//  Created by Ryan on 15/4/24.
//  Copyright (c) 2015年 BitAuto. All rights reserved.
//

#import "MessageLayer.h"
#import "EYToolkit.h"

#define MSGLAYER_DEFAULTFRAME CGRectMake(0, 0, 220, 40)   // 默认的消息框尺寸，不需要修改其初始位置

#pragma mark - Message 实现
@implementation Message

- (instancetype)init {
    if (self = [super init]) {
        _background = [[UIView alloc] init];
        _background.backgroundColor = [UIColor clearColor];
        _background.userInteractionEnabled = NO;
        _background.clipsToBounds = YES;

        _labelMessage = [UILabel labelWithFrame:CGRectZero
                                           text:nil
                                           font:[UIFont systemFontOfSize:15]
                                      textColor:[UIColor whiteColor]
                                backgroundColor:[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.6]
                                  textAlignment:NSTextAlignmentCenter];
        _labelMessage.numberOfLines = 0;
        _labelMessage.adjustsFontSizeToFitWidth = YES;
        _labelMessage.cornerRadius = 3;
        [_background addSubview:_labelMessage];
        
        _persistTime = 0;
        _isInUse = NO;
    }
    return self;
}

- (void)setBaseFrame:(CGRect)baseFrame {
    _labelMessage.frame = baseFrame;
}

- (void)setFrame:(CGRect)frame {
    _background.frame = frame;
}

- (CGRect)getFrame {
    return _background.frame;
}

- (void)setHidden:(BOOL)hidden {
    _background.hidden = hidden;
}

- (void)setSuperView:(UIView *)superView {
    [superView addSubview:_background];
}

- (void)setAlpha:(CGFloat)alpha {
    _labelMessage.alpha = alpha;
}

- (void)setMessage:(NSString *)message {
    if (IsStringWithAnyText(message)) {
        _labelMessage.text = message;
        _labelMessage.frame = MSGLAYER_DEFAULTFRAME;
        CGSize textSize = [message boundingRectWithSize:CGSizeMake(_labelMessage.width, MAXFLOAT)
                                                options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                             attributes:@{NSFontAttributeName: _labelMessage.font}
                                                context:nil].size;
        _labelMessage.height = textSize.height + 15;
        _background.frame = _labelMessage.frame;
    }
}

- (void)addIndex {
    ++_index;
    _moveTime += MessageLayerMoveTime;
}
@end

#pragma mark - 私有函数声明
@interface MessageLayer (Hidden)

- (NSInteger)getAvailableMessageFromQueue;      // 找到可用的消息框
- (void)rearrangeMessagePosition;               // 重新组织消息框的位置
- (void)onMainTimer:(NSTimer *)timer;
- (void)initMessageLayer;

@end

#pragma mark - 公有函数实现
@implementation MessageLayer

+ (instancetype)sharedMessageLayer {
    static id shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}


- (instancetype)init {
    if (self = [super init]) {
        _isAlreadyInitialized = FALSE;
        UIWindow *mainWindow = [UIApplication sharedApplication].windows.firstObject;
        CGRect frame = MSGLAYER_DEFAULTFRAME;
        CGFloat left = (mainWindow.width - frame.size.width) / 2;
        frame.origin.x = left;
        frame.origin.y = 74;
        self.frame = frame;
        [mainWindow addSubview:self];
        
        _messageList = [NSMutableArray new];
        _positionStatus = [NSMutableArray new];
        [self initMessageLayer];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initMessageLayer];
    }
    return self;
}

- (void)dealloc{
    [_messageList removeAllObjects];
    [_positionStatus removeAllObjects];
}

- (BOOL)showMessage:(NSString *)message lastTime:(CGFloat)time {
    NSInteger index = [self getAvailableMessageFromQueue];
    for (Message *messageObject in self.messageList) {
        if ([messageObject.message isEqualToString:message]) {
            messageObject.timer = time;
            return TRUE;
        }
    }
    if (index == -1) {
        return FALSE;
    }
    if (time <= 0) {
        time = MessageLayerDefaultTimer;
    }
    Message *messageObject = _messageList[index];
    messageObject.message = message;
    messageObject.isInUse = YES;
    messageObject.timer = time;
    messageObject.persistTime = 0;
    messageObject.status = MessageLayerStatusExpanding;
    ++_currentMessageOnShow;
    [self rearrangeMessagePosition];
    messageObject.index = 0;
    _positionStatus[0] = @(index);
    
    [self.superview bringSubviewToFront:self];
    if (!_mainTimer) {
        self.hidden = NO;
        _mainTimer = [NSTimer scheduledTimerWithTimeInterval:MessageLayerTimerInterval
                                                      target:self
                                                    selector:@selector(onMainTimer:)
                                                    userInfo:nil
                                                     repeats:YES];
    }
    return TRUE;
}

- (void)showBellowMessage:(NSString *)message time:(CGFloat)time {
    CGRect frame = MSGLAYER_DEFAULTFRAME;
    UIWindow *mainWindow = [UIApplication sharedApplication].windows.firstObject;
    frame.origin.x = (mainWindow.width - frame.size.width) / 2;
    frame.origin.y = (mainWindow.height - frame.size.height);
    self.frame = frame;
    [self showMessage:message lastTime:time];
}



@end

@implementation MessageLayer (Hidden)

- (void)initMessageLayer {
    if (_isAlreadyInitialized) {
        return;
    }
    
    _currentMessageOnShow = 0;
    self.backgroundColor = [UIColor clearColor];
    for (NSInteger index = 0; index < MessageLayerMagQueueMax; index++) {
        Message *message = [[Message alloc] init];
        [message setSuperView:self];
        [message setBaseFrame:CGRectMake(0, 0, self.left, self.top)];
        [_messageList addObject:message];
        [_positionStatus addObject:@(-1)];
    }
    self.hidden = YES;
    _mainTimer = nil;
}


- (NSInteger)getAvailableMessageFromQueue {
    __block NSInteger index = -1;
    [_messageList enumerateObjectsUsingBlock:^(Message *obj, NSUInteger idx, BOOL *stop) {
        if (!obj.isInUse) {
            index = idx;
            *stop = YES;
        }
    }];
    
    return index;
}

- (void)onMainTimer:(NSTimer *)timer {
    CGRect frame;
    CGFloat width;
    
    for (Message *message in self.messageList) {
        if (!message.isInUse) {
            continue;
        }
        frame = [message getFrame];
        frame.origin = CGPointMake(0, -frame.size.height * message.index);
        if (message.persistTime == 0) {
            frame.origin = CGPointMake(self.width / 2 - 5, 0);
            frame.size.width = 10;
            [message setFrame:frame];
            [message setHidden:NO];
            [message setAlpha:1];
            message.persistTime += MessageLayerTimerInterval;
        } else {
            message.timer -= MessageLayerTimerInterval;
            if (message.timer <= 0) {
                message.isInUse = NO;
                [message setMessage:nil];
                [message setHidden:YES];
                self.positionStatus[message.index] = @(-1);
                --self.currentMessageOnShow;
                continue;
            }
            message.persistTime += MessageLayerTimerInterval;
            if (message.moveTime > 0) {
                message.moveTime -= MessageLayerTimerInterval;
                CGRect currentFrame = [message getFrame];
                CGFloat speed = frame.size.height / MessageLayerMoveTime * MessageLayerTimerInterval;
                currentFrame.origin.y -= speed;
                
                if (message.moveTime <= 0) {
                    message.moveTime = 0;
                    currentFrame.origin.y = -self.height * message.index;
                }
                
                frame.origin.y = currentFrame.origin.y;

            }
            
            if (message.timer <= MessageLayerDissmissTime) {
                CGFloat alpha = 1 / MessageLayerDissmissTime * message.timer;
                [message setAlpha:alpha];
            } else if (message.status == MessageLayerStatusExpanding) {
                width = self.width * (message.persistTime / MessageLayerExpandTime);
                frame.origin.x = (self.width - width) / 2;
                frame.size.width = width;
                if (message.persistTime >= MessageLayerExpandTime) {
                    frame.size.width = self.width;
                    frame.origin.x = 0;
                    message.status = MessageLayerStatusHolding;
                }
            }
            
            [message setFrame:frame];
        }
    }
    
    if (_currentMessageOnShow == 0) {
        [_mainTimer invalidate];
        _mainTimer = nil;
        self.hidden = YES;
    }
}

- (void)rearrangeMessagePosition {
    NSInteger index;
    NSInteger target = -1;
    for (index = 0; index < _currentMessageOnShow; index++) {
        if ([_positionStatus[index]  isEqual: @(-1)]) {
            target = index;
            break;
        }
    }
    for (index = target; index >= 0; index--) {
        if (![_positionStatus[index] isEqual:@(-1)]) {
            NSInteger i = [_positionStatus[index] integerValue];
            [_messageList[i] addIndex];
        }
        if (index > 0) {
            _positionStatus[index] = _positionStatus[index - 1];
        }
    }
}

@end