//
//  YCVoteView.m
//  NavDemo
//
//  Created by Ryan on 15/8/12.
//  Copyright (c) 2015年 BitAuto. All rights reserved.
//

#import "YCVoteView.h"
#import "YCVoteBar.h"
#import "RRToolkit.h"
#import "YCColor.h"

static const CGFloat YCBarTopMargin = 30;

@interface YCVoteView ()<YCVoteBarDelegate>

@property (nonatomic, strong) NSArray *voteData;
@property (nonatomic, strong) NSMutableArray *voteBars;
@property (nonatomic, strong) NSArray *colors;

- (void)configureUserInterface;

@end

@implementation YCVoteView

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame voteData:(NSArray *)voteData {
    if (self = [super initWithFrame:frame]) {
        _voteData = voteData;
        _voteBars = [NSMutableArray array];
        self.backgroundColor = [UIColor whiteColor];
        [self configureUserInterface];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGFloat cubeWidth = 8;
    // draw blue cube
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 5, cubeWidth, 20)];
    [[UIColor colorWithHexString:@"85b3ff"] setFill];
    [path fill];
    
    if (!_isVoted || _isVoteEnded) {
        UIBezierPath *bottomPath = [UIBezierPath bezierPath];
        [bottomPath moveToPoint:CGPointMake(0, CGRectGetMaxY(rect) - 1)];
        [bottomPath addLineToPoint:CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect) - 1)];
        bottomPath.lineWidth = OnePixel();
        [[UIColor colorWithHexString:@"ececec"] setStroke];
        [bottomPath stroke];
        
        for (NSInteger idx = 0; idx < self.voteData.count; idx++) {
            // Drawing Up Line
            UIBezierPath *upPath = [UIBezierPath bezierPath];
            [upPath moveToPoint:CGPointMake(0, YCBarTopMargin + YCBarHeight * idx)];
            [upPath addLineToPoint:CGPointMake(CGRectGetMaxX(rect), YCBarTopMargin + YCBarHeight * idx)];
            upPath.lineWidth = OnePixel();
            [[UIColor colorWithHexString:@"ececec"] setStroke];
            [upPath stroke];
        }
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Text Drawing
    CGRect textRect = CGRectMake(cubeWidth + 8, 5, 55, 20);
    {
        NSString *textContent = @"投票";
        NSMutableParagraphStyle *textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
        textStyle.alignment = NSTextAlignmentLeft;
        
        NSDictionary* textFontAttributes =
        @{NSFontAttributeName:[UIFont systemFontOfSize:UIFont.labelFontSize],
          NSForegroundColorAttributeName: UIColor.blackColor,
          NSParagraphStyleAttributeName: textStyle};
        
        CGFloat textTextHeight = 0;
        if ([textContent respondsToSelector:@selector(boundingRectWithSize:options:context:)]) {
            textTextHeight = [textContent boundingRectWithSize:CGSizeMake(textRect.size.width, INFINITY)  options:NSStringDrawingUsesLineFragmentOrigin attributes:textFontAttributes context:nil].size.height;
        } else {
            textTextHeight = [textContent sizeWithFont:[UIFont systemFontOfSize:[UIFont labelFontSize]] forWidth:textRect.size.width lineBreakMode:NSLineBreakByWordWrapping].height;
        }

        CGContextSaveGState(context);
        CGContextClipToRect(context, textRect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(textRect), CGRectGetMinY(textRect) + (CGRectGetHeight(textRect) - textTextHeight) / 2, CGRectGetWidth(textRect), textTextHeight) withAttributes:textFontAttributes];
        CGContextRestoreGState(context);
    }
}

+ (instancetype)voteViewWithFrame:(CGRect)frame voteData:(NSArray *)voteData {
    return [[self alloc] initWithFrame:frame voteData:voteData];
}

- (void)setIsVoted:(BOOL)isVoted {
    _isVoted = isVoted;
    if (_isVoted) {
        [self setVoteBar:nil];
    }
}

- (void)setIsVoteEnded:(BOOL)isVoteEnded {
    _isVoteEnded = isVoteEnded;
    if (_isVoteEnded) {
        [self setVoteBar:nil];
    }
}

- (NSArray *)colors {
    if (!_colors) {
        _colors = @[@{@"Normal": @"ebf3ff",
                      @"Highlighted": @"85b3ff"},
                    @{@"Normal": @"fef7f1",
                      @"Highlighted": @"ffdbbc"}];
    }
    return _colors;
}

#pragma mark - Privte Instance Method

- (NSUInteger)indexOfTheLargestVoteCount:(NSArray *)voteList {
    NSDictionary *max = [voteList sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *obj1, NSDictionary *obj2) {
        return [obj1[@"count"] intValue] < [obj2[@"count"] intValue];
    }].firstObject;
    return [voteList indexOfObject:max];
}

- (void)configureUserInterface {
    u_int32_t a = arc4random_uniform((u_int32_t)self.colors.count);
    
    NSInteger maxCountIndex = [self indexOfTheLargestVoteCount:self.voteData];

    [self.voteData enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        YCVoteBar *bar = [[YCVoteBar alloc] initWithFrame:CGRectMake(0, YCBarTopMargin + YCBarHeight * idx, self.width, YCBarHeight - OnePixel())];
        bar.delegate = self;
        bar.index = idx;
        bar.title = obj[@"title"];
        if (self.isVoteEnded) {
            bar.strokeColor = [UIColor colorWithHexString:@"f6f6f6"];
        } else {
            if (idx == maxCountIndex) {
                bar.strokeColor = [UIColor colorWithHexString:self.colors[a][@"Highlighted"]];
            } else {
                bar.strokeColor = [UIColor colorWithHexString:self.colors[a][@"Normal"]];
            }
        }
        [bar setStrokeEnd:0 animated:YES];
        [self addSubview:bar];
        [_voteBars addObject:bar];
    }];
}

#pragma mark - YCVoteBarDelegate

- (void)setVoteBar:(YCVoteBar *)voteBar {
    if (!_isVoted) {
        self.count += 1;
        _isVoted = YES;
        [self setNeedsDisplay];
    }
    [_voteBars enumerateObjectsUsingBlock:^(YCVoteBar *obj, NSUInteger idx, BOOL *stop) {
        obj.enabled = NO;
        float voteCount = [self.voteData[idx][@"count"] floatValue];
        if (idx == voteBar.index) {
            voteCount += 1;
        }
        float percent = voteCount / self.count;
        if (_isVoteEnded) {
            if (obj == voteBar) {
                [obj setStrokeEnd:percent animated:YES];
            }
        } else {
            [obj setStrokeEnd:percent animated:YES];
        }
        obj.percent = [NSNumberFormatter localizedStringFromNumber:@(percent) numberStyle:NSNumberFormatterPercentStyle];
        if (obj != voteBar) {
            obj.titleColor = [UIColor colorWithHexString:@"333333"];
        }
    }];
}

@end
