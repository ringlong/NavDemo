//
//  NetwordManager.h
//  NavDemo
//
//  Created by Ryan on 15/4/25.
//  Copyright (c) 2015年 BitAuto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "ReactiveCocoa.h"

typedef void(^NetworkHandler)(NSInteger status, NSString *message, NSDictionary *data, NSError *error);

@interface NetworkManager : NSObject

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong, readonly) NSOperationQueue *operationQueue;

+ (instancetype)defaultManager;


- (void)buildPostRequest:(NSString *)urlString
                  params:(NSDictionary *)params
                 success:(NetworkHandler)success
                 failure:(NetworkHandler)failure;

- (void)buildFormRequest:(NSString *)urlString
                  params:(NSDictionary *)params
                 success:(NetworkHandler)success
                 failure:(NetworkHandler)failure;

- (void)buildGetRequest:(NSString *)urlString
                 params:(NSDictionary *)params
                success:(NetworkHandler)success
                failure:(NetworkHandler)failure;

- (void)buildJsonRequest:(NSString *)urlString
                  params:(NSDictionary *)params
                 success:(NetworkHandler)success
                 failure:(NetworkHandler)failure;

- (RACSignal *)buildRACRequestSignalWithURL:(NSString *)urlString
                                 HTTPMethod:(NSString *)method
                                     params:(NSDictionary *)parameters;

- (RACSignal *)buildGetRACRequestSignalWithURL:(NSString *)URLString
                                    parameters:(NSDictionary *)parameters;

- (RACSignal *)buildPostRACRequestSignalWithURL:(NSString *)urlString
                                         params:(NSDictionary *)params;

- (RACSignal *)buildJsonRACRequestSignalWithURL:(NSString *)URLString
                                         params:(NSDictionary *)params;

@end
