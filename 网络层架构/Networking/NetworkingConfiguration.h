//
//  NetworkingConfiguration.h
//  网络层架构
//
//  Created by xiaerfei on 15/7/20.
//  Copyright (c) 2015年 上海相非相网络科技有限公司. All rights reserved.
//

#ifndef ______NetworkingConfiguration_h
#define ______NetworkingConfiguration_h

typedef NS_ENUM(NSUInteger, AIFURLResponseStatus)
{
    AIFURLResponseStatusSuccess, //作为底层，请求是否成功只考虑是否成功收到服务器反馈。至于签名是否正确，返回的数据是否完整，由上层的RTApiBaseManager来决定。
    AIFURLResponseStatusErrorTimeout,
    AIFURLResponseStatusErrorNoNetwork // 默认除了超时以外的错误都是无网络错误。
};


static NSTimeInterval kAIFNetworkingTimeoutSeconds = 20.0f;

#endif
