//
//  EYPreprocessorMacros.h
//  EYToolkit
//
//  Created by Edward Yang on 3/13/13.
//  Copyright (c) 2013 EdwardYang. All rights reserved.
//

#ifndef EYFrameworkCore_EYPreprocessorMacros_h
#define EYFrameworkCore_EYPreprocessorMacros_h

/**
 * Borrowed from Apple's AvailabiltyInternal.h header.It's a gcc-supported flag.
 */
#define __EYDEPRECATED __attribute__((deprecated))

/**
 * Add this macro before each category implementation, so we don't have to use
 * -all_load or -force_load to load object files from static libraries that only contain
 * categories and no classes.
 * See http://developer.apple.com/library/mac/#qa/qa2006/qa1490.html for more info.
 */
#define EY_FIX_CATEGORY_BUG(name) @interface EY_FIX_CATEGORY_BUG_##name : NSObject @end \
                                  @implementation EY_FIX_CATEGORY_BUG_##name @end

////////////////////////////////////////////////////////////////////////////////////////////////////
// Valid Macro Function                                                                           //
////////////////////////////////////////////////////////////////////////////////////////////////////
#define IsString(__string) ([(__string) isKindOfClass:[NSString class]])
#define IsStringWithAnyText(__string) (IsString(__string) && ([((NSString *)__string) length] > 0))

#define IsArray(__array) ([(__array) isKindOfClass:[NSArray class]])
#define IsArrayWithAnyItem(__array) (IsArray(__array) && ([((NSArray *)__array) count] > 0))

#define IsDictionary(__dict) ([(__dict) isKindOfClass:[NSDictionary class]])
#define IsDictionaryWithAnyKeyValue(__dict) (IsDictionary(__dict) && ([[((NSDictionary *)__dict) allKeys] count] > 0))

#define IsSet(__set) ([(__set) isKindOfClass:[NSSet class]])
#define IsSetWithAnyItem(__set) (IsSet(__set) && ([((NSSet *)__set) count] > 0))

#define IsNumber(__number) ([(__number) isKindOfClass:[NSNumber class]])

#define IsOS6OrLater    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define IsOS7OrLater    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IsOS8OrLater    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#endif //EYFrameworkCore_EYPreprocessorMacros_h
