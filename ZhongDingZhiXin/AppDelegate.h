//
//  AppDelegate.h
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/9/24.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件
@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    
    UINavigationController *navigationController;
}

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

/** nearArray */
@property (nonatomic,strong) NSMutableArray * nearArray;

/** dicNearArray */
@property (nonatomic,strong) NSMutableArray * dicNearArray;

/** mobilephone */
@property (nonatomic,strong) NSString * mobilephone;

/** coor */
@property (nonatomic,assign) CLLocationCoordinate2D coordinate;

/** time */
@property (nonatomic,strong) NSString * timeStr;

/** 首页address */
@property (nonatomic,strong) NSString * firAddress;

/** 其他address */
@property (nonatomic,strong) NSString * address;

/** 首页数组 */
@property (nonatomic,strong) NSArray * firstArray;

//个人资料的地区
@property (nonatomic,strong)NSString * from;

/** avatar */
@property (nonatomic,strong) NSString * avatar;

/** age */
@property (nonatomic,strong) NSString * age;

/** realname */
@property (nonatomic,strong) NSString * realname;

/** sex */
@property (nonatomic,strong) NSString * sex;

/** myMessage */
@property (nonatomic,strong) NSMutableArray * messages;

/** http */
@property (nonatomic,strong) NSString * http;

/** workArray */
@property (nonatomic,strong) NSMutableArray * workArray;

/** educateArr */
@property (nonatomic,strong) NSMutableArray * educateArray;

/** registArray */
@property (nonatomic,strong) NSMutableArray * registArray;

/** 工作地 */
@property (nonatomic,strong) NSString * workAddress;

/** 邮箱 */
@property (nonatomic,strong) NSString * email;

/** 工作电话 */
@property (nonatomic,strong) NSString * workPhone;

/** index */
@property (nonatomic,assign) NSInteger numIndex;

@end

