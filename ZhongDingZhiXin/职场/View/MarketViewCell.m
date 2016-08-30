//
//  MarketViewCell.m
//  个人职业信用
//
//  Created by zdzx-008 on 16/8/30.
//  Copyright © 2016年 北京职信鼎程. All rights reserved.
//

#import "MarketViewCell.h"

@implementation MarketViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    MarketViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"work"];
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    
    return cell;
}

- (void)setMarket:(MarketModel *)market
{
    _market = market;
    
    AppShare;
    //公司名
    self.companyName.text = [AESCrypt decrypt:market.companyName password:app.loginKeycode];
    
    //时间
    NSString * str = [AESCrypt decrypt:market.invitationTime password:app.loginKeycode];
    timeCover;
    self.timeLabel.text = currentDateStr;
}

@end
