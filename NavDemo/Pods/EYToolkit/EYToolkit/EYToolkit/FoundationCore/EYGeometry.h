//
//  EYGeometry.h
//  EYToolkit
//
//  Created by Edward Yang on 3/13/13.
//  Copyright (c) 2013 EdwardYang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * @return CGRectMake(origin.x, origin.y, size.width, size.height)
 */
CG_INLINE CGRect EYRectMakeWithOriginAndSize(CGPoint origin, CGSize size);
CG_INLINE CGRect EYRectMakeWithOriginAndSize(CGPoint origin, CGSize size) {
    CGRect rect;
    rect.origin = origin;
    rect.size = size;
    return rect;
}

/**
 * @return CGRectMake(origin.x, origin.y, width, height)
 */
CG_INLINE CGRect EYRectMakeWithOrigin(CGPoint origin, CGFloat width, CGFloat height);
CG_INLINE CGRect EYRectMakeWithOrigin(CGPoint origin, CGFloat width, CGFloat height) {
    CGRect rect;
    rect.origin = origin;
    rect.size.width = width; rect.size.height = height;
    return rect;
}

/**
 * @return CGRectMake(x, y, size.width, size.height)
 */
CG_INLINE CGRect EYRectMakeWithSize(CGFloat x, CGFloat y, CGSize size);
CG_INLINE CGRect EYRectMakeWithSize(CGFloat x, CGFloat y, CGSize size) {
    CGRect rect;
    rect.origin.x = x; rect.origin.y = y;
    rect.size = size;
    return rect;
}

/**
 * @return CGRectMake(x, y, w - dx, h - dy)
 */
CG_EXTERN CGRect EYRectContract(CGRect rect, CGFloat dx, CGFloat dy);

/**
 * @return CGRectMake(x, y, w + dx, h + dy)
 */
CG_EXTERN CGRect EYRectExpand(CGRect rect, CGFloat dx, CGFloat dy);

/**
 * @return CGRectMake(x + dx, y + dy, w - dx, h - dy)
 */
CG_EXTERN CGRect EYRectShift(CGRect rect, CGFloat dx, CGFloat dy);

/**
 * @return CGRectMake(x + left, y + top, w - (left + right), h - (top + bottom))
 */
CG_EXTERN CGRect EYRectInset(CGRect rect, UIEdgeInsets insets);
