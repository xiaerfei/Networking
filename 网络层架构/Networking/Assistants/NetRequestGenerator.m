//
//  NetRequestGenerator.m
//  网络层架构
//
//  Created by xiaerfei on 15/7/1.
//  Copyright (c) 2015年 二哥. All rights reserved.
//

#import "NetRequestGenerator.h"
#import "NetServiceFactory.h"
#import "NetSignatureGenerator.h"
#import "NetworkingConfiguration.h"
#import <AFNetworking.h>

@interface NetRequestGenerator ()

@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;

@end

@implementation NetRequestGenerator

#pragma mark - public methods
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static NetRequestGenerator *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NetRequestGenerator alloc] init];
    });
    return sharedInstance;
}

- (NSURLRequest *)generateGETRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName
{
    NetService *service = [[NetServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    NSString *signa = [NetSignatureGenerator signGetWithSigParams:requestParams methodName:methodName apiVersion:service.apiVersion privateKey:service.privateKey publicKey:service.publicKey];
    NSString *urlString = [NSString stringWithFormat:@"%@%@",service.apiBaseUrl,signa];
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"GET" URLString:urlString parameters:nil error:NULL];
    request.timeoutInterval = kAIFNetworkingTimeoutSeconds;
    return request;
}
- (NSURLRequest *)generatePOSTRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName
{
    NSURLRequest *request = nil;
    return request;
}


#pragma mark - getters and setters
- (AFHTTPRequestSerializer *)httpRequestSerializer
{
    if (_httpRequestSerializer == nil) {
        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
        _httpRequestSerializer.timeoutInterval = kAIFNetworkingTimeoutSeconds;
        _httpRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    }
    return _httpRequestSerializer;
}

@end
