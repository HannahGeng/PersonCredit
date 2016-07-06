//
//  RewardInfo.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/11/13.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "RewardInfo.h"

@implementation RewardInfo
- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.realname = dictionary[@"realname"];
        self.topic = dictionary[@"topic"];
        self.descrip = dictionary[@"description"];
        self.point=dictionary[@"point"];
    }
    return self;
}

@end
