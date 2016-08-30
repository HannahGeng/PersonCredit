//
//  MarketModel.h
//  个人职业信用
//
//  Created by zdzx-008 on 16/8/30.
//  Copyright © 2016年 北京职信鼎程. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MarketModel : NSObject

/** invitationContent */
@property (nonatomic,strong) NSString * invitationContent;

/** companyName */
@property (nonatomic,strong) NSString * companyName;

/** invitationTime */
@property (nonatomic,strong) NSString * invitationTime;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
