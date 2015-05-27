//
//  NetwordManager.m
//  NavDemo
//
//  Created by Ryan on 15/4/25.
//  Copyright (c) 2015年 BitAuto. All rights reserved.
//

#import "NetworkManager.h"
#import "RACEXTScope.h"

static NSString * const kBaseURL = @"http://api.ycapp.yiche.com/";
static NSString * const kUserDefaultCookie = @"mycookie";

static NSTimeInterval requestTimeoutInterval = 60;

@implementation NetworkManager

#pragma mark - 初始化

+ (instancetype)defaultManager {
    static NetworkManager *networkManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkManager = [[self alloc] init];
    });
    return networkManager;
}

- (instancetype)init {
    if (self = [super init]) {
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/plain", @"text/html", nil];
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _manager.requestSerializer.timeoutInterval = requestTimeoutInterval;
        _operationQueue = _manager.operationQueue;
    }
    return self;
}

#pragma mark - Cookie

- (void)setRequestCookies {
    [_manager.requestSerializer setValue:@"cookie" forHTTPHeaderField:@"Cookie"];
}

- (BOOL)deleteLocalCookies {
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookies = [cookieStorage cookiesForURL:[NSURL URLWithString:kBaseURL]];
    for (NSHTTPCookie *cookie in cookies) {
        [cookieStorage deleteCookie:cookie];
    }
    return TRUE;
}

// 解析cookie
- (void)parseCookie {
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookies = [cookieStorage cookiesForURL:[NSURL URLWithString:kBaseURL]];
    for (NSHTTPCookie *cookie in cookies) {
        NSLog(@"cookie: %@", cookie);
    }
}

/**
 *  从response的HeaderField获得头文件，从头文件中通过NSHTTPCookie的cookiesWithResponseHeaderFields
 *  组成cookie的NSArray，将生成cookie的array，使用NSHttpCookie的reqeustHeaderFieldsWithCookies方法
 *  拼接成合法的http header field。最后set到request中即可。
 *  [manager.requestSerializer setValue:[requestFields objectForKey:@"Cookie"]
 *                   forHTTPHeaderField:@"Cookie"];
 */
- (void)getCookie:(AFHTTPRequestOperation *)operation {
    
    NSDictionary *allHeaderFields = operation.response.allHeaderFields;
    NSArray *cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:allHeaderFields
                                                              forURL:[NSURL URLWithString:kBaseURL]];
    NSDictionary* requestFields = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
    [[NSUserDefaults standardUserDefaults] setValue:requestFields[@"Cookie"] forKey:kUserDefaultCookie];
}

#pragma mark - build Request

- (void)buildGetRequest:(NSString *)urlString
                 params:(NSDictionary *)params
                success:(NetworkHandler)success
                failure:(NetworkHandler)failure {
    [_manager GET:urlString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
//        [self getCookie:task];
        [self parseCookie];
        success(1, @"success", responseObject, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(0, @"failure", nil, error);
    }];
}

- (void)buildFormRequest:(NSString *)urlString
                  params:(NSDictionary *)params
                 success:(NetworkHandler)success
                 failure:(NetworkHandler)failure {
    NSError *error;
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlString parameters:params error:&error];
    if (error) {
        failure(0, @"FAILURE", nil, error);
        return;
    }
    [_manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            failure(0, @"FAILURE", nil, error);
        } else {
            success(1, @"success", responseObject, nil);
        }
    }];
    
}

- (void)buildPostRequest:(NSString *)urlString
                  params:(NSDictionary *)params
                 success:(NetworkHandler)success
                 failure:(NetworkHandler)failure {
    [_manager POST:urlString parameters:params success:^(NSURLSessionDataTask *operation, id responseObject) {
        success(1, @"SUCCESS",responseObject, nil);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(0, @"FAILURE", nil, error);
    }];
}

- (void)buildJsonRequest:(NSString *)urlString
                  params:(NSDictionary *)params
                 success:(NetworkHandler)success
                 failure:(NetworkHandler)failure {
    NSError *error;
    NSMutableURLRequest *request = [_manager.requestSerializer requestWithMethod:@"POST" URLString:urlString parameters:params error:&error];
    if (error) {
        failure(0, @"FAILURE", nil, error);
        return;
    }
    [_manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            failure(0, @"FAILURE", nil, error);
        } else {
            success(1, @"success", responseObject, nil);
        }
    }];
}

#pragma mark - Build RAC Signal

- (RACSignal *)buildRACRequestSignalWithURL:(NSString *)urlString
                                 HTTPMethod:(NSString *)method
                                     params:(NSDictionary *)parameters {
    
    RACSignal *signal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        // 创建request
        NSError *serializationError = nil;
        NSMutableURLRequest *request = [_manager.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:urlString relativeToURL:_manager.baseURL] absoluteString] parameters:parameters error:&serializationError];
        
        if (serializationError) {
            [subscriber sendError:serializationError];
        }
        // 创建请求
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperationManager manager] HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [subscriber sendError:error];
        }];
        
        [_manager.operationQueue addOperation:operation];
        
        return [RACDisposable disposableWithBlock:^{
            [operation cancel];
        }];
    }] doError:^(NSError *error) {
        NSLog(@"error : %@", error);
    }];
    
    RACMulticastConnection *connection = [signal publish];
    [connection connect];
    
    return connection.signal;
}

- (RACSignal *)buildGetRACRequestSignalWithURL:(NSString *)URLString
                                    parameters:(NSDictionary *)parameters {
    return [self buildRACRequestSignalWithURL:URLString HTTPMethod:@"GET" params:parameters];
}

- (RACSignal *)buildPostRACRequestSignalWithURL:(NSString *)urlString
                                         params:(NSDictionary *)params {
    return [self buildRACRequestSignalWithURL:urlString HTTPMethod:@"POST" params:params];
}

- (RACSignal *)buildJsonRACRequestSignalWithURL:(NSString *)URLString
                                         params:(NSDictionary *)params {
    _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    return [self buildRACRequestSignalWithURL:URLString HTTPMethod:@"POST" params:params];
}

@end
