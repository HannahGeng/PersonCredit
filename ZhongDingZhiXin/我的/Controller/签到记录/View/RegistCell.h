//
//  RegistCell.h
//  个人职业信用
//
//  Created by zdzx-008 on 16/7/27.
//  Copyright © 2016年 北京职信鼎程. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RegistModel;

@interface RegistCell : UITableViewCell

@property (nonatomic,strong)RegistModel * registmodel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
