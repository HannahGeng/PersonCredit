//
//  AppDelegate.h
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/9/24.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,assign) long lat;
@property(assign,nonatomic)long lng;

+ (instancetype)sharedAppDelegate;
@property (strong, nonatomic) NSString *request;//放到请求头 变动、每做一次网络请求token值都不相同
@property (nonatomic,strong)NSString * uid;
/** 登录成功解密的keycode */
@property (nonatomic,strong) NSString * loginKeycode;
/** 未登陆解密的keycode */
@property (nonatomic,strong) NSString * noLoginkeycode;

/** 工作证样式 */
@property (nonatomic,strong) NSString * workStyle;

/** 问题数组 */
@property (nonatomic,strong) NSMutableArray * questionArray;

/** 我的奖励 */
@property (nonatomic,strong) NSArray * punishArray;

/** 我的惩罚 */
@property (nonatomic,strong) NSArray * rewardArray;

/** 常见问题行号 */
@property (nonatomic,assign) NSInteger index;

/** 姓名 */
@property (nonatomic,strong) NSString * name;

@end

