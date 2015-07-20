//
//  NetSignatureGenerator.h
//  网络层架构
//
//  Created by xiaerfei on 15/7/20.
//  Copyright (c) 2015年 上海相非相网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetSignatureGenerator : NSObject

+ (NSString *)signGetWithSigParams:(NSDictionary *)allParams
                        methodName:(NSString *)methodName
                        apiVersion:(NSString *)apiVersion
                        privateKey:(NSString *)privateKey
                         publicKey:(NSString *)publicKey;

+ (NSString *)signRestfulGetWithAllParams:(NSDictionary *)allParams
                               methodName:(NSString *)methodName
                               apiVersion:(NSString *)apiVersion
                               privateKey:(NSString *)privateKey;

+ (NSString *)signPostWithApiParams:(NSDictionary *)apiParams
                         privateKey:(NSString *)privateKey
                          publicKey:(NSString *)publicKey;

+ (NSString *)signRestfulPOSTWithApiParams:(id)apiParams
                              commonParams:(NSDictionary *)commonParams
                                methodName:(NSString *)methodName
                                apiVersion:(NSString *)apiVersion
                                privateKey:(NSString *)privateKey;

@end
