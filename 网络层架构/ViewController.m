//
//  ViewController.m
//  网络层架构
//
//  Created by xiaerfei on 15/3/25.
//  Copyright (c) 2015年 二哥. All rights reserved.
//

#import "ViewController.h"
#import "PropertyListReformer.h"

@interface ViewController ()<APIManagerApiCallBackDelegate>

@property (nonatomic,strong) ItemListAPIManager *itemListAPIManager;

@property (nonatomic,strong) PropertyListReformer *propertyListReformer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //这里网络请求
    [self.itemListAPIManager loadData];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - APIManagerApiCallBackDelegate
- (void)apiManagerDidSuccess:(BaseAPIManager *)manager
{
    NSDictionary *dict = [manager fetchDataWithReformer:self.propertyListReformer];
    NSLog(@"success-->%@",dict);
}

- (void)apiManagerDidFailed:(BaseAPIManager *)manager
{
    
}

#pragma mark - getters 

- (ItemListAPIManager *)itemListAPIManager
{
    if (_itemListAPIManager == nil) {
        _itemListAPIManager = [[ItemListAPIManager alloc] init];
        _itemListAPIManager.delegate = self;
    }
    return _itemListAPIManager;
}

- (PropertyListReformer *)propertyListReformer
{
    if (_propertyListReformer == nil) {
        _propertyListReformer = [[PropertyListReformer alloc] init];
    }
    return _propertyListReformer;
}

@end
