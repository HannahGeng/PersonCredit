//
//  RegistModel.h
//  个人职业信用
//
//  Created by zdzx-008 on 16/7/27.
//  Copyright © 2016年 北京职信鼎程. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegistModel : NSObject

/** loca */
@property (nonatomic,strong) NSString * location;

/** locatime */
@property (nonatomic,strong) NSString * locatime;

+ (instancetype)resgitWithDic:(NSDictionary *)dic;

@end
