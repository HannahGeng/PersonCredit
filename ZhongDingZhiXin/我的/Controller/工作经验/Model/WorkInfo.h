//
//  WorkInfo.h
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/11/13.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkInfo : NSObject

@property (nonatomic, strong) NSString *job;//标题
@property (nonatomic, strong) NSString *worktime;//时间
@property (nonatomic, strong) NSString *company;//内容

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
