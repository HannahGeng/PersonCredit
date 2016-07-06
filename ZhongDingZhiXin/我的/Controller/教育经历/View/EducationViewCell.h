//
//  EducationViewCell.h
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/11/12.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EducationInfo;

@interface EducationViewCell : UITableViewCell

//设置显示内容
-(void)setContentView:(EducationInfo *)educationInfo;

@end
