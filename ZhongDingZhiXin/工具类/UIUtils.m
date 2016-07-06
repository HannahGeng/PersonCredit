//
//  UIUtils.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/9/24.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "UIUtils.h"

@implementation UIUtils

+ (CGFloat)getWindowWidth
{
    UIWindow *mainWindow=[UIApplication sharedApplication].windows[0];
    return mainWindow.frame.size.width;
}
+ (CGFloat)getWindowHeight
{
    UIWindow *mainWindow=[UIApplication sharedApplication].windows[0];
    return mainWindow.frame.size.height;
}

@end
