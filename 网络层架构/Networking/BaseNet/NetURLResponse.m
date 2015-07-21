//
//  NetURLResponse.m
//  网络层架构
//
//  Created by xiaerfei on 15/4/5.
//  Copyright (c) 2015年 上海相非相网络科技有限公司. All rights reserved.
//

#import "NetURLResponse.h"

@interface NetURLResponse ()
@property (nonatomic, assign, readwrite) AIFURLResponseStatus status;
@property (nonatomic, copy, readwrite) NSString *contentString;
@property (nonatomic, copy, readwrite) id content;
@property (nonatomic, assign, readwrite) NSInteger requestId;
@property (nonatomic, copy, readwrite) NSURLRequest *request;
@property (nonatomic, copy, readwrite) NSData *responseData;
@property (nonatomic,copy,readwrite) NSDictionary *responseNSDictionary;
@property (nonatomic, assign, readwrite) BOOL isCache;


@end

@implementation NetURLResponse

#pragma mark - life cycle
- (instancetype)initWithResponseString:(NSString *)responseString
                             requestId:(NSNumber *)requestId
                               request:(NSURLRequest *)request
                          responseData:(NSData *)responseData
                                status:(AIFURLResponseStatus)status
{
    self = [super init];
    if (self) {
        self.contentString = responseString;
        self.content = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
        self.status = status;
        self.requestId = [requestId integerValue];
        self.request = request;
        self.responseData = responseData;
//        self.requestParams = request.requestParams;
        self.isCache = NO;

    }
    return self;
}

- (instancetype)initWithResponseString:(NSString *)responseString
                             requestId:(NSNumber *)requestId
                               request:(NSURLRequest *)request
                          responseData:(NSData *)responseData
                                 error:(NSError *)error
{
    self = [super init];
    if (self) {
        self.contentString = responseString.length == 0?@"":responseString;
        self.status = [self responseStatusWithError:error];
        self.requestId = [requestId integerValue];
        self.request = request;
        self.responseData = responseData;
//        self.requestParams = request.requestParams;
        self.isCache = NO;
        
        if (responseData) {
            self.content = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
        } else {
            self.content = nil;
        }

    }
    return self;
}

- (instancetype)initWithResponseDictionary:(NSDictionary *)responseNSDictionary
                                 requestId:(NSNumber *)requestId
                                   request:(NSURLRequest *)request
                              responseData:(NSData *)responseData
                                    status:(AIFURLResponseStatus)status
{
    self = [super init];
    if (self) {
        self.responseNSDictionary = responseNSDictionary;
        self.status = status;
        self.requestId = [requestId integerValue];
        self.request = request;
        self.responseData = responseData;
        //        self.requestParams = request.requestParams;
        self.isCache = NO;

    }
    return self;
}

- (instancetype)initWithResponseNSDictionary:(NSDictionary *)responseNSDictionary
                                   requestId:(NSNumber *)requestId
                                     request:(NSURLRequest *)request
                                responseData:(NSData *)responseData
                                       error:(NSError *)error
{
    self = [super init];
    if (self) {
        self.responseNSDictionary = responseNSDictionary;
        self.status = [self responseStatusWithError:error];
        self.requestId = [requestId integerValue];
        self.request = request;
        self.responseData = responseData;
        //        self.requestParams = request.requestParams;
        self.isCache = NO;

        if (responseData) {
            self.content = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
        } else {
            self.content = nil;
        }

    }
    return self;
}


// 使用initWithData的response，它的isCache是YES，上面函数生成的response的isCache是NO
- (instancetype)initWithData:(NSData *)data
{
    self = [super init];
    if (self) {
        self.contentString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        self.status = [self responseStatusWithError:nil];
        self.requestId = 0;
        self.request = nil;
        self.responseData = [data copy];
        self.content = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
        self.isCache = YES;
    }
    return self;
}


#pragma mark - private methods
- (AIFURLResponseStatus)responseStatusWithError:(NSError *)error
{
    if (error) {
        AIFURLResponseStatus result = AIFURLResponseStatusErrorNoNetwork;
        
        // 除了超时以外，所有错误都当成是无网络
        if (error.code == NSURLErrorTimedOut) {
            result = AIFURLResponseStatusErrorNoNetwork;
        }
        return result;
    } else {
        return AIFURLResponseStatusSuccess;
    }
}
@end
