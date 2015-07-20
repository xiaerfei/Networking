//
//  NetServiceFactory.m
//  网络层架构
//
//  Created by xiaerfei on 15/7/2.
//  Copyright (c) 2015年 上海相非相网络科技有限公司. All rights reserved.
//

#import "NetServiceFactory.h"
#import "ServiceKeys.h"



#import "HomeService.h"



@interface NetServiceFactory ()

@property (nonatomic, strong) NSMutableDictionary *serviceStorage;

@end

@implementation NetServiceFactory

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static NetServiceFactory *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NetServiceFactory alloc] init];
    });
    return sharedInstance;
}

#pragma mark - public methods
- (NetService<NetServiceProtocal> *)serviceWithIdentifier:(NSString *)identifier
{
    if (self.serviceStorage[identifier] == nil) {
        self.serviceStorage[identifier] = [self newServiceWithIdentifier:identifier];
    }
    return self.serviceStorage[identifier];
}

#pragma mark - private methods
- (NetService<NetServiceProtocal> *)newServiceWithIdentifier:(NSString *)identifier
{
    if ([identifier isEqualToString:kNetServiceCheyouhome]) {
        return [[HomeService alloc] init];
    }
    
    return nil;
}


#pragma mark - getters
- (NSMutableDictionary *)serviceStorage
{
    if (_serviceStorage == nil) {
        _serviceStorage = [[NSMutableDictionary alloc] init];
    }
    return _serviceStorage;
}

@end
