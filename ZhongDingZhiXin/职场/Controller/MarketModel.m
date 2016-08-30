//
//  MarketModel.m
//  个人职业信用
//
//  Created by zdzx-008 on 16/8/30.
//  Copyright © 2016年 北京职信鼎程. All rights reserved.
//

#import "MarketModel.h"

@implementation MarketModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        
        self.invitationContent = dic[@"invitationContent"];
        self.companyName = dic[@"companyName"];
        self.invitationTime = dic[@"invitationTime"];
    }
    
    return self;
}


@end
