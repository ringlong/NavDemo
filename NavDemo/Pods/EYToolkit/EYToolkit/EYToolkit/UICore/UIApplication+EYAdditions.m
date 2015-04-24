//
//  UIApplication+EYAdditions.m
//  EYToolkit
//
//  Created by Edward Yang on 4/7/13.
//  Copyright (c) 2013 EdwardYang. All rights reserved.
//

#import "UIApplication+EYAdditions.h"
#import "UIDevice+EYAdditions.h"
#import "NSString+EYAdditions.h"
#import "EYPreprocessorMacros.h"

@implementation UIApplication (EYAdditions)
@dynamic interfaceOrientation, isLandscape, isPortrait, orientationString;

- (UIInterfaceOrientation)interfaceOrientation
{
    return self.statusBarOrientation;
}

- (BOOL)isLandscape {
    return UIInterfaceOrientationIsLandscape(self.interfaceOrientation);
}

- (BOOL)isPortrait {
    return UIInterfaceOrientationIsPortrait(self.interfaceOrientation);
}

- (NSString *)orientationString {
    return [UIDevice orientationString:(UIDeviceOrientation)self.interfaceOrientation];
}

#pragma mark - App store
+ (BOOL)appStoreWithAppId:(NSString *)appId {
    NSString *appStoreURLString;
    if (IsOS7OrLater) {
        appStoreURLString = @"itms-apps://itunes.apple.com/app/id";
    } else {
        appStoreURLString = @"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=";
    }
    NSString* urlPath = [appStoreURLString stringByAppendingString:appId];
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlPath]];
}

+ (BOOL)appStoreGiftWithAppId:(NSString *)appId {
    NSString* urlPath = [NSString stringWithFormat:@"itms-apps://buy.itunes.apple.com/WebObjects/MZFinance.woa/wa/giftSongsWizard?gift=1&salableAdamId=%@&productType=C&pricingParameter=STDQ&mt=8&ign-mscache=1", appId];
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlPath]];
}

+ (BOOL)appStoreReviewWithAppId:(NSString *)appId {
    NSString *appStoreURLFormatString;
    if (IsOS7OrLater) {
        if (IsOS8OrLater) {
            appStoreURLFormatString = @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software";
        } else {
            appStoreURLFormatString = @"itms-apps://itunes.apple.com/app/id%@";
        }
    } else {
        appStoreURLFormatString = @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@";
    }
    NSString* urlPath = [NSString stringWithFormat:appStoreURLFormatString, appId];
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlPath]];
}

#pragma mark - Inter App
+ (BOOL)phoneWithNumber:(NSString *)phoneNumber {
    if (nil == phoneNumber) {
        phoneNumber = @"";
    }
    
    NSString* urlPath = [@"tel:" stringByAppendingString:phoneNumber];
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlPath]];
}

+ (BOOL)smsWithNumber:(NSString *)phoneNumber {
    if (nil == phoneNumber) {
        phoneNumber = @"";
    }
    
    NSString* urlPath = [@"sms:" stringByAppendingString:phoneNumber];
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlPath]];
}



+ (BOOL)mailWithRecipient:(NSString *)recipient
                   withCC:(NSString *)cc
                  withBCC:(NSString *)bcc
              withSubject:(NSString *)subject
                 withBody:(NSString *)body {
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    
    static NSString* const __MailScheme = @"mailto:";
    NSString* urlPath = __MailScheme;
    
    if ([recipient isNotEmpty]) {
        urlPath = [urlPath stringByAppendingString:[recipient stringByURLParameterEncoding]];
    }
    if ([cc isNotEmpty]) {
        [parameters setObject:cc forKey:@"cc"];
    }
    if ([bcc isNotEmpty]) {
        [parameters setObject:bcc forKey:@"bcc"];
    }
    if ([subject isNotEmpty]) {
        [parameters setObject:subject forKey:@"subject"];
    }
    if ([body isNotEmpty]) {
        [parameters setObject:body forKey:@"body"];
    }
    
    urlPath = [urlPath stringByAddingQueryDictionary:parameters];
    
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlPath]];
}

@end
