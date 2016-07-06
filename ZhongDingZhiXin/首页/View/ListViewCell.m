//
//  ListViewCell.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/10/22.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "ListViewCell.h"

@implementation ListViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *cellID=@"ListViewCell";
    
    ListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ListViewCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
