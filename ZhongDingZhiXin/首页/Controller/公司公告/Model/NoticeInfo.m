//
//  NoticeInfo.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/11/12.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "NoticeInfo.h"

@implementation NoticeInfo

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.title = dictionary[@"title"];
        self.mark = dictionary[@"mark"];
        self.content = dictionary[@"content"];
        self.realname = dictionary[@"realname"];
        self.topic = dictionary[@"topic"];
        self.descrip = dictionary[@"description"];
        self.point=dictionary[@"point"];
        self.pubtime = dictionary[@"pubtime"];
    }
    return self;
}

@end
