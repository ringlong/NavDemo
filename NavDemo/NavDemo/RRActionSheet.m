//
//  RRActionSheet.m
//  NavDemo
//
//  Created by Vanessa on 15/7/16.
//  Copyright (c) 2015年 BitAuto. All rights reserved.
//

#import "RRActionSheet.h"
#import "Masonry.h"

const CGFloat kCellHeight = 44;
const CGFloat kSeparatorHeight = 5;
const CGFloat kFontSize = 17;
const NSTimeInterval kAnimationDuration = 0.2;

@interface RRActionSheet ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *cancelTitle;
@property (nonatomic, copy) NSString *destructiveTitle;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *otherTitles;

@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *sheetView;

- (void)setUserInterface;
- (void)hideActionSheet;
- (void)cancelButtonClicked;
@end

@implementation RRActionSheet

#pragma mark - Life Cycle
- (instancetype)initWithTitle:(NSString *)title delegate:(id<RRActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    if (self = [super init]) {
        _delegate = delegate;
        _title = title;
        _cancelTitle = cancelButtonTitle;
        _destructiveTitle = destructiveButtonTitle;
        _titleColor = [UIColor colorWithRed:0.20 green:0.20 blue:0.20 alpha:1.00];

        NSMutableArray *objects = [NSMutableArray array];
        va_list args;
        va_start(args, otherButtonTitles);
        for (NSString *currentObject = otherButtonTitles; currentObject; currentObject = va_arg(args, NSString *)) {
            [objects addObject:currentObject];
        }
        va_end(args);
        if (_destructiveTitle) {
            [objects insertObject:_destructiveTitle atIndex:0];
            _destructiveButtonIndex = 0;
        }
        _otherTitles = [NSArray arrayWithArray:objects];
        _cancelButtonIndex = _otherTitles.count;
        [self setUserInterface];
    }
    return self;
}

#pragma mark - Setter && Getter

- (void)setTitleColor:(UIColor *)titleColor {
    if (_titleColor != titleColor) {
        _titleColor = titleColor;
        [_tableView reloadData];
        NSAttributedString *attributedTitle =
        [[NSAttributedString alloc]
         initWithString:_cancelTitle
             attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kFontSize],
                          NSForegroundColorAttributeName: _titleColor}];
        
        [_cancelButton setAttributedTitle:attributedTitle forState:UIControlStateNormal];
    }
}

- (UIView *)sheetView {
    if (!_sheetView) {
        _sheetView = [[UIView alloc] init];
        _sheetView.backgroundColor = UIColor.clearColor;
    }
    return _sheetView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = UIColor.whiteColor;
        _tableView.rowHeight = kCellHeight;
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            _tableView.separatorInset = UIEdgeInsetsZero;
        }
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            _tableView.layoutMargins = UIEdgeInsetsZero;
        }
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELL"];
    }
    return _tableView;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.backgroundColor = [UIColor whiteColor];
        [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        NSAttributedString *attributedTitle =
        [[NSAttributedString alloc]
         initWithString:_cancelTitle
         attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kFontSize],
                      NSForegroundColorAttributeName: _titleColor}];
                      
        [_cancelButton setAttributedTitle:attributedTitle forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 2;
        _titleLabel.text = _title;
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:13.f];
        _titleLabel.userInteractionEnabled = YES;
    }
    return _titleLabel;
}

#pragma mark - Public Instance Methoe

- (void)showInView:(UIView *)view {
    [view.window addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(view.window);
    }];
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"position.y";
    animation.fromValue = @(800);
    animation.duration = kAnimationDuration;
    [_sheetView.layer addAnimation:animation forKey:@"com.history.animation"];
}

#pragma mark - Private Instance Method

- (CGFloat)totalHeight {
    NSInteger rows = _otherTitles.count + 1 + (_title.length ? 1 : 0);
    return rows * kCellHeight + kSeparatorHeight;
}

- (void)setUserInterface {
    [self addTarget:self action:@selector(hideActionSheet) forControlEvents:UIControlEventTouchUpInside];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4f];

    [self addSubview:self.sheetView];
    [self.sheetView addSubview:self.tableView];
    [self.sheetView addSubview:self.cancelButton];

    BOOL moreThanScreen = self.totalHeight > [UIScreen mainScreen].bounds.size.height - 28;
    CGFloat sheetHeight = moreThanScreen ? [UIScreen mainScreen].bounds.size.height - 28 : self.totalHeight;
    
    [_sheetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.and.trailing.equalTo(self);
        make.height.mas_equalTo(@(sheetHeight));
    }];
    
    _tableView.bounces = moreThanScreen;
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.equalTo(_sheetView);
        make.bottom.equalTo(_cancelButton.mas_top).offset(-kSeparatorHeight);
        if (moreThanScreen) {
            make.height.mas_equalTo(@([UIScreen mainScreen].bounds.size.height - 28 - 2 * kCellHeight - kSeparatorHeight));
        } else {
            make.height.mas_equalTo(@(_otherTitles.count * kCellHeight));
        }
    }];
    
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.and.bottom.equalTo(_sheetView);
        make.height.mas_equalTo(@(kCellHeight));
    }];
    
    if (_title.length) {
        [_sheetView addSubview:self.titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.and.trailing.equalTo(_sheetView);
            make.bottom.equalTo(_tableView.mas_top);
            make.height.mas_equalTo(@(kCellHeight));
        }];
    }
}

- (void)hideActionSheet {
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"position.y";
    animation.toValue = @(800);
    animation.duration = kAnimationDuration;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [_sheetView.layer addAnimation:animation forKey:@"com.history.animation"];
    
    [UIView animateKeyframesWithDuration:kAnimationDuration
                                   delay:kAnimationDuration
                                 options:UIViewKeyframeAnimationOptionCalculationModeLinear
                              animations:^{
                                  self.alpha = 0.f;
                              }
                              completion:^(BOOL finished) {
                                  [self removeFromSuperview];
                              }];
}

- (void)cancelButtonClicked {
    [self hideActionSheet];
    if ([self.delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
        [self.delegate actionSheet:self clickedButtonAtIndex:_cancelButtonIndex];
    }
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _otherTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];

    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.text = _otherTitles[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:kFontSize];
    if (_destructiveTitle && indexPath.row == _destructiveButtonIndex) {
        cell.textLabel.textColor = [UIColor redColor];
    } else {
        cell.textLabel.textColor = self.titleColor;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self hideActionSheet];
    
    if ([_delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
        [_delegate actionSheet:self clickedButtonAtIndex:indexPath.row];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        cell.separatorInset = UIEdgeInsetsZero;
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins = UIEdgeInsetsZero;
    }
}

@end
