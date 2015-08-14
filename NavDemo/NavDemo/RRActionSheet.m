//
//  RRActionSheet.m
//  NavDemo
//
//  Created by Ryan on 15/7/15.
//  Copyright (c) 2015年 BitAuto. All rights reserved.
//

#import "RRActionSheet.h"

@interface RRActionSheet ()

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *cancleTitle;
@property (nonatomic, copy) NSString *destructiveTitle;
@property (nonatomic, strong) NSArray *otherTitles;

@end

@implementation RRActionSheet

- (instancetype)initWithTitle:(NSString *)title delegate:(id<RRActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    if (self = [super init]) {
        _title = title;
        _delegate = delegate;
        _cancleTitle = cancelButtonTitle;
        _destructiveTitle = destructiveButtonTitle;
        
        NSMutableArray *arr = [NSMutableArray array];
        
        va_list otherButtonTitleList;
        va_start(otherButtonTitleList, otherButtonTitles);
        {
            for (NSString *otherButtonTitle = otherButtonTitles; otherButtonTitle != nil; otherButtonTitle = va_arg(otherButtonTitleList, NSString *)) {
                [arr addObject:otherButtonTitle];
            }
        }
        va_end(otherButtonTitleList);

        _otherTitles = [NSArray arrayWithArray:arr];
    }
    return self;
}
@end
