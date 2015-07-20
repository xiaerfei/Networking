//
//  NetService.m
//  网络层架构
//
//  Created by xiaerfei on 15/7/2.
//  Copyright (c) 2015年 上海相非相网络科技有限公司. All rights reserved.
//

#import "NetService.h"

@implementation NetService

- (instancetype)init
{
    self = [super init];
    if (self) {
        if ([self conformsToProtocol:@protocol(NetServiceProtocal)]) {
            self.child = (id<NetServiceProtocal>)self;
        }
    }
    return self;
}


#pragma mark - getters
- (NSString *)privateKey
{
    return self.child.isOnline ? self.child.onlinePrivateKey : self.child.offlinePrivateKey;
}

- (NSString *)publicKey
{
    return self.child.isOnline ? self.child.onlinePublicKey : self.child.offlinePublicKey;
}

- (NSString *)apiBaseUrl
{
    return self.child.isOnline ? self.child.onlineApiBaseUrl : self.child.offlineApiBaseUrl;
}

- (NSString *)apiVersion
{
    return self.child.isOnline ? self.child.onlineApiVersion : self.child.offlineApiVersion;
}



@end
