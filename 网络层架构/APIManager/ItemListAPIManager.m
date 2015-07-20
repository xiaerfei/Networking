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



@end
