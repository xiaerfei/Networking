//
//  NetSignatureGenerator.m
//  网络层架构
//
//  Created by xiaerfei on 15/7/20.
//  Copyright (c) 2015年 上海相非相网络科技有限公司. All rights reserved.
//

#import "NetSignatureGenerator.h"

@implementation NetSignatureGenerator

+ (NSString *)signGetWithSigParams:(NSDictionary *)allParams
                        methodName:(NSString *)methodName
                        apiVersion:(NSString *)apiVersion
                        privateKey:(NSString *)privateKey
                         publicKey:(NSString *)publicKey
{
    NSMutableString *string = [[NSMutableString alloc] initWithFormat:@"%@/?",methodName];
    for (NSString *str in allParams.allKeys) {
        [string appendFormat:@"%@=%@&",str,allParams[str]];
    }
    NSRange rang;
    rang.location = 0;
    rang.length = string.length - 1;
    return [string substringWithRange:rang];
}

+ (NSString *)signRestfulGetWithAllParams:(NSDictionary *)allParams
                               methodName:(NSString *)methodName
                               apiVersion:(NSString *)apiVersion
                               privateKey:(NSString *)privateKey
{
    return nil;
}

+ (NSString *)signPostWithApiParams:(NSDictionary *)apiParams
                         privateKey:(NSString *)privateKey
                          publicKey:(NSString *)publicKey
{
    return nil;
}

+ (NSString *)signRestfulPOSTWithApiParams:(id)apiParams
                              commonParams:(NSDictionary *)commonParams
                                methodName:(NSString *)methodName
                                apiVersion:(NSString *)apiVersion
                                privateKey:(NSString *)privateKey
{
    return nil;
}


@end
