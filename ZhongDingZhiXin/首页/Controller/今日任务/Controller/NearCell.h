//
//  NearCell.h
//  个人职业信用
//
//  Created by zdzx-008 on 16/7/26.
//  Copyright © 2016年 北京职信鼎程. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NearModel;

@interface NearCell : UITableViewCell

@property (nonatomic,strong)NearModel * nearmodel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
