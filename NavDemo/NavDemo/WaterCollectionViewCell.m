//
//  WaterCollectionViewCell.m
//  NavDemo
//
//  Created by Ryan on 15/5/22.
//  Copyright (c) 2015年 BitAuto. All rights reserved.
//

#import "WaterCollectionViewCell.h"
#import "EYToolkit.h"

@implementation WaterCollectionViewCell

- (void)drawRect:(CGRect)rect {
    CGFloat width = (self.width - 4 * 5) / 3;
    CGFloat height = _image.size.height / _image.size.width * width;
    [_image drawInRect:CGRectMake(0, 0, width, height)];
}


- (void)setImage:(UIImage *)image {
    if (_image != image) {
        _image = image;
    }
    [self setNeedsDisplay];
}

@end
