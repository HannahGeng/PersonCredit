//
//  QuestionModel.m
//  个人职业信用
//
//  Created by zdzx-008 on 16/7/18.
//  Copyright © 2016年 北京职信鼎程. All rights reserved.
//

#import "QuestionModel.h"

@implementation QuestionModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.title = dic[@"title"];
        self.content = dic[@"content"];
        self.pubtime = dic[@"pubtime"];
    }
    
    return self;
}

@end
