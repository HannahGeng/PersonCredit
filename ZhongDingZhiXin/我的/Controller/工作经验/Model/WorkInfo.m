//
//  WorkInfo.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/11/13.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "WorkInfo.h"

@implementation WorkInfo

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.job = dictionary[@"job"];
        self.worktime = dictionary[@"worktime"];
        self.company = dictionary[@"company"];
    }
    return self;
}

@end
