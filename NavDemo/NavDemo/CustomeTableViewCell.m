//
//  CustomeTableViewCell.m
//  NavDemo
//
//  Created by Ryan on 15/7/7.
//  Copyright (c) 2015年 BitAuto. All rights reserved.
//

#import "CustomeTableViewCell.h"
#import "RRToolkit.h"

@implementation CustomeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //NSLog(@"宽%f高%f",titleSize.width,titleSize.height);
    self.detailTextLabel.textAlignment = NSTextAlignmentLeft;
//    [self.detailTextLabel sizeToFit];
    self.detailTextLabel.left = self.textLabel.right + 20;
}

@end
