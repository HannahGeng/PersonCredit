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

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
