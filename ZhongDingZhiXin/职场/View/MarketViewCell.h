//
//  MarketViewCell.h
//  个人职业信用
//
//  Created by zdzx-008 on 16/8/30.
//  Copyright © 2016年 北京职信鼎程. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MarketModel;

@interface MarketViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *numIcon;
@property (weak, nonatomic) IBOutlet UILabel *companyName;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

/** model */
@property (nonatomic,strong) MarketModel * market;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
