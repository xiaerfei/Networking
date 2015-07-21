//
//  HomeService.m
//  网络层架构
//
//  Created by xiaerfei on 15/7/20.
//  Copyright (c) 2015年 上海相非相网络科技有限公司. All rights reserved.
//

#import "HomeService.h"

@implementation HomeService

#pragma mark - AIFServiceProtocal
- (BOOL)isOnline
{
    return YES;
}

- (NSString *)onlineApiBaseUrl
{
    return @"http://api.ycapp.yiche.com/appforum/";
}

- (NSString *)onlineApiVersion
{
    return @"directions/json";
}

- (NSString *)onlinePrivateKey
{
    return @"";
}

- (NSString *)onlinePublicKey
{
    return @"";
}

- (NSString *)offlineApiBaseUrl
{
    return self.onlineApiBaseUrl;
}

- (NSString *)offlineApiVersion
{
    return self.onlineApiVersion;
}

- (NSString *)offlinePrivateKey
{
    return self.onlinePrivateKey;
}

- (NSString *)offlinePublicKey
{
    return self.onlinePublicKey;
}


@end
