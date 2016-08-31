//
//  EducationInfo.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/11/13.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "EducationInfo.h"

@implementation EducationInfo
- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.job = dictionary[@"organization"];
        self.worktime = dictionary[@"period"];
        self.company = dictionary[@"period"];
    }
    return self;
}

@end
