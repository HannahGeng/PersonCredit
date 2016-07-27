//
//  RegistModel.m
//  个人职业信用
//
//  Created by zdzx-008 on 16/7/27.
//  Copyright © 2016年 北京职信鼎程. All rights reserved.
//

#import "RegistModel.h"

@implementation RegistModel

+ (instancetype)resgitWithDic:(NSDictionary *)dic
{
    RegistModel * regist = [[RegistModel alloc] init];
    
    regist.location = dic[@"location"];
    regist.locatime = dic[@"locatime"];
    
    return regist;
}

@end
