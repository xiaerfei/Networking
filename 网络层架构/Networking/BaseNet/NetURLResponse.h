//
//  NetURLResponse.h
//  网络层架构
//
//  Created by xiaerfei on 15/7/20.
//  Copyright (c) 2015年 上海相非相网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkingConfiguration.h"



@interface NetURLResponse : NSObject

@property (nonatomic, assign, readonly) AIFURLResponseStatus status;
@property (nonatomic, copy, readonly) NSString *contentString;
@property (nonatomic, copy, readonly) id content;
@property (nonatomic, assign, readonly) NSInteger requestId;
@property (nonatomic, copy, readonly) NSURLRequest *request;
@property (nonatomic, copy, readonly) NSData *responseData;
@property (nonatomic,copy,readonly) NSDictionary *responseNSDictionary;
@property (nonatomic, copy) NSDictionary *requestParams;
@property (nonatomic, assign, readonly) BOOL isCache;

- (instancetype)initWithResponseString:(NSString *)responseString
                             requestId:(NSNumber *)requestId
                               request:(NSURLRequest *)request
                          responseData:(NSData *)responseData
                                status:(AIFURLResponseStatus)status;

- (instancetype)initWithResponseString:(NSString *)responseString
                             requestId:(NSNumber *)requestId
                               request:(NSURLRequest *)request
                          responseData:(NSData *)responseData
                                 error:(NSError *)error;

- (instancetype)initWithResponseDictionary:(NSDictionary *)responseNSDictionary
                             requestId:(NSNumber *)requestId
                               request:(NSURLRequest *)request
                          responseData:(NSData *)responseData
                                status:(AIFURLResponseStatus)status;

- (instancetype)initWithResponseNSDictionary:(NSDictionary *)responseNSDictionary
                             requestId:(NSNumber *)requestId
                               request:(NSURLRequest *)request
                          responseData:(NSData *)responseData
                                 error:(NSError *)error;


// 使用initWithData的response，它的isCache是YES，上面函数生成的response的isCache是NO
- (instancetype)initWithData:(NSData *)data;


@end
