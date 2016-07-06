//
//  RewardInfo.h
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/11/13.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RewardInfo : NSObject

@property (nonatomic, strong) NSString *realname;//姓名
@property (nonatomic, strong) NSString *topic;//事件
@property (nonatomic, strong) NSString *descrip;//内容
@property (nonatomic, strong) NSString *point;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
