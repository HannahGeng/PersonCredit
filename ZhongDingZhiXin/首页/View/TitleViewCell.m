//
//  TitleViewCell.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/10/22.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "TitleViewCell.h"

@interface TitleViewCell()

@end

@implementation TitleViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *cellID=@"TitleViewCell";
    
    TitleViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TitleViewCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //添加cell的背景图片
        cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"beijing"]];
    }
    return cell;
}

@end
