//
//  NearCell.m
//  个人职业信用
//
//  Created by zdzx-008 on 16/7/26.
//  Copyright © 2016年 北京职信鼎程. All rights reserved.
//

#import "NearCell.h"

@implementation NearCell

- (void)setNearmodel:(NearModel *)nearmodel
{
    _nearmodel = nearmodel;
    
    self.addName.text = nearmodel.name;
    self.geoName.text = nearmodel.address;
   
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NearCell * cell = [tableView dequeueReusableCellWithIdentifier:@"near"];
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
        
    return cell;
}

@end
