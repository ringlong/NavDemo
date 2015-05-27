//
//  EYToolkitVersion.m
//  EYToolkit
//
//  Created by Edward Yang on 3/12/13.
//  Copyright (c) 2013 EdwardYang. All rights reserved.
//

#import "EYToolkitVersion.h"

static NSString* const EYToolkitVersionString = @"1.0.0";

@implementation EYToolkitVersion

+ (NSString *)version {
    return EYToolkitVersionString;
}

+ (NSInteger)majorVersion {
    return [[[EYToolkitVersionString componentsSeparatedByString:@"."] objectAtIndex:0] intValue];
}

+ (NSInteger)minorVersion {
    return [[[EYToolkitVersionString componentsSeparatedByString:@"."] objectAtIndex:1] intValue];
}

+ (NSInteger)bugfixVersion {
    return [[[EYToolkitVersionString componentsSeparatedByString:@"."] objectAtIndex:2] intValue];
}

@end