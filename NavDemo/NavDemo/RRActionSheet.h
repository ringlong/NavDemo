//
//  RRActionSheet.h
//  NavDemo
//
//  Created by Ryan on 15/7/15.
//  Copyright (c) 2015年 BitAuto. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RRActionSheet;

@protocol RRActionSheetDelegate <NSObject>

- (void)actionSheet:(RRActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface RRActionSheet : UIControl

@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, weak) id<RRActionSheetDelegate> delegate;

- (instancetype)initWithTitle:(NSString *)title delegate:(id<RRActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION;


@end
