//
//  ItemListAPIManager.m
//  网络层架构
//
//  Created by xiaerfei on 15/6/27.
//  Copyright (c) 2015年 二哥. All rights reserved.
//

#import "ItemListAPIManager.h"
#import "ServiceKeys.h"

@implementation ItemListAPIManager
//http://api.ycapp.yiche.com/appforum/cheyouhome/?deviceid=000000000000000


#pragma mark - life cycle
-(instancetype)init
{
    self = [super init];
    if (self) {
        self.validator = self;
        self.paramSource = self;
    }
    return self;
}


#pragma mark - APIManager
- (NSString *)methodName;
{
    return @"cheyouhome";
}

- (NSString *)serviceType
{
    return kNetServiceCheyouhome;
}

- (APIManagerRequestType)requestType
{
    return APIManagerRequestTypeGet;
}

#pragma mark - APIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(BaseAPIManager *)manager
{
    return @{@"deviceid":@"000000000000000"};
}

#pragma mark - APIManagerValidator
- (BOOL)manager:(BaseAPIManager *)manager isCorrectWithCallBackData:(NSDictionary *)data
{
    return YES;
}

- (BOOL)manager:(BaseAPIManager *)manager isCorrectWithParamsData:(NSDictionary *)data
{
    return YES;
}
@end
