//
//  TaskView.h
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/11/2.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskView : UIView

- (id)initWithFrame:(CGRect)frame andArray:(NSArray *)array;
- (void)showInView:(UIView *)view;
- (void)removeView;

@end
