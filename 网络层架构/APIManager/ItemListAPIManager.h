//
//  ItemListAPIManager.h
//  网络层架构
//
//  Created by xiaerfei on 15/3/25.
//  Copyright (c) 2015年 二哥. All rights reserved.
//

#import "BaseAPIManager.h"

@interface ItemListAPIManager : BaseAPIManager<APIManager,APIManagerValidator,APIManagerParamSourceDelegate,APIManagerParamSourceDelegate,APIManagerInterceptor>



@end
