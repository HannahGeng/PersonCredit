//
//  RegistCell.m
//  个人职业信用
//
//  Created by zdzx-008 on 16/7/27.
//  Copyright © 2016年 北京职信鼎程. All rights reserved.
//

#import "RegistCell.h"

@interface RegistCell ()

@property (weak, nonatomic) IBOutlet UILabel *localText;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation RegistCell

- (void)setRegistmodel:(RegistModel *)registmodel
{
    _registmodel = registmodel;
    
    self.localText.text = registmodel.location;
    self.timeLabel.text = registmodel.locatime;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    RegistCell * cell = [tableView dequeueReusableCellWithIdentifier:@"regist"];
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    
    return cell;
}

@end
