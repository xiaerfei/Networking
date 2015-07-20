//
//  NetApiProxy.m
//  网络层架构
//
//  Created by xiaerfei on 15/6/28.
//  Copyright (c) 2015年 二哥. All rights reserved.
//

#import "NetApiProxy.h"
#import <AFNetworking.h>
#import "NetRequestGenerator.h"


@interface NetApiProxy ()

@property (nonatomic, strong) NSMutableDictionary *dispatchTable;
@property (nonatomic, strong) NSNumber *recordedRequestId;

//AFNetworking stuff
@property (nonatomic, strong) AFHTTPRequestOperationManager *operationManager;

@end

@implementation NetApiProxy

#pragma mark - life cycle
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static NetApiProxy *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NetApiProxy alloc] init];
    });
    return sharedInstance;
}

#pragma mark - public methods

- (NSInteger)callGETWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(NetCallBack)success fail:(NetCallBack)fail
{
    NSURLRequest *request = [[NetRequestGenerator sharedInstance] generateGETRequestWithServiceIdentifier:servieIdentifier requestParams:params methodName:methodName];
    NSNumber *requestId = [self callApiWithRequest:request success:success fail:fail];
    return [requestId integerValue];
}
- (NSInteger)callPOSTWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(NetCallBack)success fail:(NetCallBack)fail
{
    NSURLRequest *request = [[NetRequestGenerator sharedInstance] generatePOSTRequestWithServiceIdentifier:servieIdentifier requestParams:params methodName:methodName];
    NSNumber *requestId = [self callApiWithRequest:request success:success fail:fail];
    return [requestId integerValue];
    return 0;
}

- (void)cancelRequestWithRequestID:(NSNumber *)requestID
{
    NSOperation *requestOperation = self.dispatchTable[requestID];
    [requestOperation cancel];
    [self.dispatchTable removeObjectForKey:requestID];
}

- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList
{
    for (NSNumber *requestId in requestIDList) {
        [self cancelRequestWithRequestID:requestId];
    }
}

#pragma mark - private methods
/** 这个函数存在的意义在于，如果将来要把AFNetworking换掉，只要修改这个函数的实现即可。 */
- (NSNumber *)callApiWithRequest:(NSURLRequest *)request success:(NetCallBack)success fail:(NetCallBack)fail
{
    NSNumber *requestId = [self generateRequestId];
        AFHTTPRequestOperation *httpRequestOperation = [self.operationManager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
            AFHTTPRequestOperation *storedOperation = self.dispatchTable[requestId];
            if (storedOperation == nil) {
                // 如果这个operation是被cancel的，那就不用处理回调了。
                return;
            } else {
                // 请求已经完成，将requestId移除
                [self.dispatchTable removeObjectForKey:requestId];
            }
            NetURLResponse *response = [[NetURLResponse alloc] initWithResponseDictionary:responseObject
                                                                                requestId:requestId
                                                                                  request:operation.request
                                                                             responseData:operation.responseData
                                                                                   status:AIFURLResponseStatusSuccess];
            success?success(response):nil;
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            AFHTTPRequestOperation *storedOperation = self.dispatchTable[requestId];
            if (storedOperation == nil) {
                // 如果这个operation是被cancel的，那就不用处理回调了。
                return;
            } else {
                [self.dispatchTable removeObjectForKey:requestId];
            }
            NetURLResponse *response = [[NetURLResponse alloc] initWithResponseNSDictionary:operation.responseObject
                                                                                  requestId:requestId
                                                                                    request:operation.request
                                                                               responseData:operation.responseData
                                                                                      error:error];
            fail?fail(response):nil;
        }];
    self.dispatchTable[requestId] = httpRequestOperation;
    [[self.operationManager operationQueue] addOperation:httpRequestOperation];
    return requestId;
}

- (NSNumber *)generateRequestId
{
    if (_recordedRequestId == nil) {
        _recordedRequestId = @(1);
    } else {
        if ([_recordedRequestId integerValue] == NSIntegerMax) {
            _recordedRequestId = @(1);
        } else {
            _recordedRequestId = @([_recordedRequestId integerValue] + 1);
        }
    }
    return _recordedRequestId;
}

#pragma mark - getters

- (AFHTTPRequestOperationManager *)operationManager
{
    if (!_operationManager) {
        _operationManager = [AFHTTPRequestOperationManager manager];
        _operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return _operationManager;
}

- (NSMutableDictionary *)dispatchTable
{
    if (_dispatchTable == nil) {
        _dispatchTable = [[NSMutableDictionary alloc] init];
    }
    return _dispatchTable;
}


@end
