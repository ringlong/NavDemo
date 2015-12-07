//
//  RRActionSheet.h
//  NavDemo
//
//  Created by Vanessa on 15/7/16.
//  Copyright (c) 2015年 BitAuto. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RRActionSheet;
@protocol RRActionSheetDelegate <NSObject>

@optional
- (void)actionSheet:(RRActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface RRActionSheet : UIControl

@property (nonatomic, weak) id<RRActionSheetDelegate> delegate;
@property (nonatomic, strong) UIColor *titleColor;

@property(nonatomic) NSInteger cancelButtonIndex;
@property(nonatomic) NSInteger destructiveButtonIndex;

- (instancetype)initWithTitle:(NSString *)title delegate:(id<RRActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

- (void)showInView:(UIView *)view;

@end
