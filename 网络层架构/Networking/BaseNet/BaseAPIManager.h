//
//  BaseAPIManager.h
//  网络层架构
//
//  Created by xiaerfei on 15/3/25.
//  Copyright (c) 2015年 二哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetURLResponse.h"



@class BaseAPIManager;

static NSString * const kRTAPIBaseManagerRequestID = @"kRTAPIBaseManagerRequestID";


typedef NS_ENUM (NSUInteger, APIManagerErrorType){
    APIManagerErrorTypeDefault,       //没有产生过API请求，这个是manager的默认状态。
    APIManagerErrorTypeSuccess,       //API请求成功且返回数据正确，此时manager的数据是可以直接拿来使用的。
    APIManagerErrorTypeNoContent,     //API请求成功但返回数据不正确。如果回调数据验证函数返回值为NO，manager的状态就会是这个。
    APIManagerErrorTypeParamsError,   //参数错误，此时manager不会调用API，因为参数验证是在调用API之前做的。
    APIManagerErrorTypeTimeout,       //请求超时。RTApiProxy设置的是20秒超时，具体超时时间的设置请自己去看RTApiProxy的相关代码。
    APIManagerErrorTypeNoNetWork      //网络不通。在调用API之前会判断一下当前网络是否通畅，这个也是在调用API之前验证的，和上面超时的状态是有区别的。
};


typedef NS_ENUM (NSUInteger, APIManagerRequestType){
    APIManagerRequestTypeGet,
    APIManagerRequestTypePost,
    APIManagerRequestTypeRestGet,
    APIManagerRequestTypeRestPost
};
/*************************************************************************************************/
/*                                         RTAPIManager                                          */
/*************************************************************************************************/
/*
 APIBaseManager的派生类必须符合这些protocal
 */
@protocol APIManager <NSObject>
@required
- (NSString *)methodName;
- (NSString *)serviceType;
- (APIManagerRequestType)requestType;
@optional
- (void)cleanData;
- (NSDictionary *)reformParams:(NSDictionary *)params;
- (BOOL)shouldCache;

@end

/*************************************************************************************************/
/*                               APIManagerCallbackDataReformer                                  */
/*************************************************************************************************/
//由reform实现
@protocol APIManagerCallbackDataReformer <NSObject>
@required
- (id)manager:(BaseAPIManager *)manager reformData:(NSDictionary *)data;
@end

/*************************************************************************************************/
/*                               APIManagerParamSourceDelegate                                   */
/*************************************************************************************************/
//让manager能够获取调用API所需要的数据,参数
@protocol APIManagerParamSourceDelegate <NSObject>
@required
- (NSDictionary *)paramsForApi:(BaseAPIManager *)manager;
@end

/*************************************************************************************************/
/*                               APIManagerApiCallBackDelegate                                   */
/*************************************************************************************************/
//api回调 返回数据，由controller实现
@protocol APIManagerApiCallBackDelegate <NSObject>
@required
- (void)apiManagerDidSuccess:(BaseAPIManager *)manager;
- (void)apiManagerDidFailed:(BaseAPIManager *)manager;
@end

/*************************************************************************************************/
/*                               APIManagerValidator                                             */
/*************************************************************************************************/
/*
 所有的callback数据都应该在这个函数里面进行检查，事实上，到了回调delegate的函数里面是不需要再额外验证返回数据是否为空的。
 因为判断逻辑都在这里做掉了。
 而且本来判断返回数据是否正确的逻辑就应该交给manager去做，不要放到回调到controller的delegate方法里面去做。
 */
@protocol APIManagerValidator <NSObject>
@required
- (BOOL)manager:(BaseAPIManager *)manager isCorrectWithParamsData:(NSDictionary *)data;
- (BOOL)manager:(BaseAPIManager *)manager isCorrectWithCallBackData:(NSDictionary *)data;
@end

/*************************************************************************************************/
/*                                    APIManagerInterceptor                                    */
/*************************************************************************************************/
/*
APIBaseManager的派生类必须符合这些protocal
 */
@protocol APIManagerInterceptor <NSObject>

@optional
- (void)manager:(BaseAPIManager *)manager beforePerformSuccessWithResponse:(NetURLResponse *)response;
- (void)manager:(BaseAPIManager *)manager afterPerformSuccessWithResponse:(NetURLResponse *)response;

- (void)manager:(BaseAPIManager *)manager beforePerformFailWithResponse:(NetURLResponse *)response;
- (void)manager:(BaseAPIManager *)manager afterPerformFailWithResponse:(NetURLResponse *)response;

- (BOOL)manager:(BaseAPIManager *)manager shouldCallAPIWithParams:(NSDictionary *)params;
- (void)manager:(BaseAPIManager *)manager afterCallingAPIWithParams:(NSDictionary *)params;

@end

/*************************************************************************************************/
/*                                       BaseAPIManager                                          */
/*************************************************************************************************/
@interface BaseAPIManager : NSObject

@property (nonatomic, strong, readonly) id fetchedRawData;
@property (nonatomic, readonly) APIManagerErrorType errorType;
@property (nonatomic, copy, readonly) NSString *errorMessage;
@property (nonatomic, assign, readonly) BOOL isReachable;
@property (nonatomic, assign, readonly) BOOL isLoading;

@property (nonatomic, strong) NSObject<APIManager> *child;
@property (nonatomic, weak) id<APIManagerApiCallBackDelegate> delegate;
@property (nonatomic, weak) id<APIManagerParamSourceDelegate> paramSource;
@property (nonatomic, weak) id<APIManagerInterceptor> interceptor;
@property (nonatomic, weak) id<APIManagerValidator> validator;

- (id)fetchDataWithReformer:(id<APIManagerCallbackDataReformer>)reformer;


//尽量使用loadData这个方法,这个方法会通过param source来获得参数，这使得参数的生成逻辑位于controller中的固定位置
- (NSInteger)loadData;

- (void)cancelAllRequests;
- (void)cancelRequestWithRequestId:(NSInteger)requestID;


// 拦截器方法，继承之后需要调用一下super
- (void)beforePerformSuccessWithResponse:(NetURLResponse *)response;
- (void)afterPerformSuccessWithResponse:(NetURLResponse *)response;

- (void)beforePerformFailWithResponse:(NetURLResponse *)response;
- (void)afterPerformFailWithResponse:(NetURLResponse *)response;

- (BOOL)shouldCallAPIWithParams:(NSDictionary *)params;
- (void)afterCallingAPIWithParams:(NSDictionary *)params;
@end
