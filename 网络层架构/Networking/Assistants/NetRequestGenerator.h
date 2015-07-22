//
//  NetRequestGenerator.h
//  网络层架构
//
//  Created by xiaerfei on 15/7/1.
//  Copyright (c) 2015年 二哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetRequestGenerator : NSObject

+ (instancetype)sharedInstance;

- (NSMutableURLRequest *)generateGETRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName;
- (NSMutableURLRequest *)generatePOSTRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName;


@end
