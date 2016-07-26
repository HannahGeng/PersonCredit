//
//  NearModel.m
//  个人职业信用
//
//  Created by zdzx-008 on 16/7/26.
//  Copyright © 2016年 北京职信鼎程. All rights reserved.
//

#import "NearModel.h"

@implementation NearModel

+ (instancetype)nearWithDic:(NSDictionary *)dic
{
    NearModel * near = [[NearModel alloc] init];
    
    near.name = dic[@"name"];
    near.address = dic[@"address"];
    
    return near;
}

@end
