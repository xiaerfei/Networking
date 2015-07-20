//
//  NetApiProxy.h
//  网络层架构
//
//  Created by xiaerfei on 15/6/28.
//  Copyright (c) 2015年 二哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetURLResponse.h"


typedef void(^NetCallBack)(NetURLResponse *response);

@interface NetApiProxy : NSObject

+ (instancetype)sharedInstance;

- (NSInteger)callGETWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(NetCallBack)success fail:(NetCallBack)fail;
- (NSInteger)callPOSTWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(NetCallBack)success fail:(NetCallBack)fail;

- (void)cancelRequestWithRequestID:(NSNumber *)requestID;

- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList;


@end
