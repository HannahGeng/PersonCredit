//
//  WorkViewCell.m
//  个人职业信用
//
//  Created by zdzx-008 on 16/7/18.
//  Copyright © 2016年 北京职信鼎程. All rights reserved.
//

#import "WorkViewCell.h"

@interface WorkViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobLabel;

@end

@implementation WorkViewCell

- (void)setWorkModel:(WorkInfo *)workModel
{
    _workModel = workModel;
    
    AppShare;
    NSString *strMark=[AESCrypt decrypt:workModel.company password:app.loginKeycode];
    [_companyLabel setText:strMark];
    [_timeLabel setText:[AESCrypt decrypt:workModel.worktime password:app.loginKeycode]];
    [_jobLabel setText:[AESCrypt decrypt:workModel.job password:app.loginKeycode]];
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"work";
    WorkViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

@end
