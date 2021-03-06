//
//  NetServiceFactory.h
//  网络层架构
//
//  Created by xiaerfei on 15/7/2.
//  Copyright (c) 2015年 上海相非相网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetService.h"




@interface NetServiceFactory : NSObject

+ (instancetype)sharedInstance;
- (NetService<NetServiceProtocal> *)serviceWithIdentifier:(NSString *)identifier;


@end
