//
//  NearModel.h
//  个人职业信用
//
//  Created by zdzx-008 on 16/7/26.
//  Copyright © 2016年 北京职信鼎程. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NearModel : NSObject

/** 位置名称 */
@property (nonatomic,strong) NSString * name;
/** 接到名称 */
@property (nonatomic,strong) NSString * address;

+ (instancetype)nearWithDic:(NSDictionary *)dic;

@end
