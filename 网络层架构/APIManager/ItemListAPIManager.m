//
//  ItemListAPIManager.m
//  网络层架构
//
//  Created by xiaerfei on 15/3/25.
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
        self.validator   = self;
        self.paramSource = self;
        self.interceptor = self;
    }
    return self;
}
#pragma mark - over methods
//- (NSDictionary *)reformParams:(NSDictionary *)params
//{
//    return params;
//}
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
/**
 *   @author xiaerfei, 15-07-21 11:07:54
 *
 *   验证请求的参数是否正确
 *
 *   @param manager manager
 *   @param data    data
 *
 *   @return return bool
 */
- (BOOL)manager:(BaseAPIManager *)manager isCorrectWithParamsData:(NSDictionary *)data
{
    return YES;
}
/**
 *   @author xiaerfei, 15-07-21 11:07:56
 *
 *   验证返回的数据是否正确
 *
 *   @param manager manager
 *   @param data    data
 *
 *   @return YES 正确
 */
- (BOOL)manager:(BaseAPIManager *)manager isCorrectWithCallBackData:(NSDictionary *)data
{
    return YES;
}

- (void)manager:(BaseAPIManager *)manager beforePerformSuccessWithResponse:(NetURLResponse *)response
{
    NSLog(@"intercept");
}
@end
