//
//  QuestionModel.m
//  个人职业信用
//
//  Created by zdzx-008 on 16/7/18.
//  Copyright © 2016年 北京职信鼎程. All rights reserved.
//

#import "QuestionModel.h"

@implementation QuestionModel

+ (instancetype)questionWithDic:(NSDictionary *)dic
{
    QuestionModel * model = [[self alloc] init];
    
    [model setValuesForKeysWithDictionary:dic];
    
    return model;
    
}

@end
