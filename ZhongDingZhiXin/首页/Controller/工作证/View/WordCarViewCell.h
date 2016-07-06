//
//  WordCarViewCell.h
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/11/16.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WordCarInfo;

@interface WordCarViewCell : UITableViewCell

//设置显示内容
-(void)setContentView:(WordCarInfo *)wordCarInfo;

@end
