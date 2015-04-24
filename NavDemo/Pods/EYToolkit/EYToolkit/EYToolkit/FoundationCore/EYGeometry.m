//
//  EYGeometry.m
//  EYToolkit
//
//  Created by Edward Yang on 3/13/13.
//  Copyright (c) 2013 EdwardYang. All rights reserved.
//

#import "EYGeometry.h"

CGRect EYRectContract(CGRect rect, CGFloat dx, CGFloat dy) {
    return CGRectMake(rect.origin.x, rect.origin.y, rect.size.width - dx, rect.size.height - dy);
}

CGRect EYRectExpand(CGRect rect, CGFloat dx, CGFloat dy) {
    return CGRectMake(rect.origin.x, rect.origin.y, rect.size.width + dx, rect.size.height + dy);
}

CGRect EYRectShift(CGRect rect, CGFloat dx, CGFloat dy) {
    return CGRectOffset(EYRectContract(rect, dx, dy), dx, dy);
}

CGRect EYRectInset(CGRect rect, UIEdgeInsets insets) {
    return CGRectMake(rect.origin.x + insets.left, rect.origin.y + insets.top,
                      rect.size.width - (insets.left + insets.right),
                      rect.size.height - (insets.top + insets.bottom));
}
