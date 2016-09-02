//
//  PunishmentInfo.h
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/11/13.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PunishmentInfo : NSObject

@property (nonatomic, strong) NSString *realname;//标题
@property (nonatomic, strong) NSString *topic;//时间
@property (nonatomic, strong) NSString *descrip;//内容
@property (nonatomic, strong) NSString *point;//内容

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
