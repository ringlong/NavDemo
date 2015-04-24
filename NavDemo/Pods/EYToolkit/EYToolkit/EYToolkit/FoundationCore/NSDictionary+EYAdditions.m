//
//  NSDictionary+EYAdditions.m
//  EYToolkit
//
//  Created by Edward Yang on 4/8/13.
//  Copyright (c) 2013 EdwardYang. All rights reserved.
//

#import "NSDictionary+EYAdditions.h"
#import "EYPreprocessorMacros.h"

EY_FIX_CATEGORY_BUG(NSDictionaryEYAdditions)

@implementation NSDictionary (EYAdditions)


@end

@implementation NSMutableDictionary (EYAdditions)

+ (NSMutableDictionary *)dictionaryWithNonRetaining {
    return (__bridge_transfer NSMutableDictionary *)CFDictionaryCreateMutable(nil, 0, nil, nil);
}

@end
