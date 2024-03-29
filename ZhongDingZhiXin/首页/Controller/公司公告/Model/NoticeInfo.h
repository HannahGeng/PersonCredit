//
//  NoticeInfo.h
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/11/12.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NoticeInfo : NSObject

@property (nonatomic, strong) NSString *title;//标题
@property (nonatomic, strong) NSString *mark;//时间
@property (nonatomic, strong) NSString *content;//内容
@property (nonatomic, strong) NSString *realname;//标题
@property (nonatomic, strong) NSString *topic;//时间
@property (nonatomic, strong) NSString *descrip;//内容
@property (nonatomic, strong) NSString *point;
@property (nonatomic, strong) NSString * pubtime;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
