//
//  WorkViewCell.h
//  个人职业信用
//
//  Created by zdzx-008 on 16/7/18.
//  Copyright © 2016年 北京职信鼎程. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WorkInfo;

@interface WorkViewCell : UITableViewCell

@property (nonatomic,strong)WorkInfo * workModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
