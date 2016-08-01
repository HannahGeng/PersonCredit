//
//  TitleViewCell.h
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/10/22.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLable;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
