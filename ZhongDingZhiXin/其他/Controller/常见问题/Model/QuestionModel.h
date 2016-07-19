//
//  QuestionModel.h
//  个人职业信用
//
//  Created by zdzx-008 on 16/7/18.
//  Copyright © 2016年 北京职信鼎程. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionModel : NSObject

/** title */
@property (nonatomic,strong) NSString * title;

/** content */
@property (nonatomic,strong) NSString * content;

/** pubtime */
@property (nonatomic,strong) NSString * pubtime;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
