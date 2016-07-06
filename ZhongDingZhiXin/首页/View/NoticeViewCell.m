//
//  NoticeViewCell.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/10/22.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "NoticeViewCell.h"

@implementation NoticeViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *cellID=@"NoticeViewCell";
    
    NoticeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NoticeViewCell" owner:self options:nil] lastObject];
    }
    return cell;
}

@end
