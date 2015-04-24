//
//  NSArray+EYAdditions.m
//  EYToolkit
//
//  Created by Edward Yang on 4/8/13.
//  Copyright (c) 2013 EdwardYang. All rights reserved.
//

#import "NSArray+EYAdditions.h"
#import "EYPreprocessorMacros.h"

EY_FIX_CATEGORY_BUG(NSArrayEYAdditions)

@implementation NSArray (EYAdditions)

@end

@implementation NSMutableArray (EYAdditions)

+ (NSMutableArray *)arrayWithNonRetaining {
    return (__bridge_transfer NSMutableArray *)CFArrayCreateMutable(nil, 0, nil);
}

@end
