//
//  QuestionCell.m
//  个人职业信用
//
//  Created by zdzx-008 on 16/7/18.
//  Copyright © 2016年 北京职信鼎程. All rights reserved.
//

#import "QuestionCell.h"

@interface QuestionCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *pubtimeLabel;

@end

@implementation QuestionCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    QuestionCell * cell = [tableView dequeueReusableCellWithIdentifier:@"question"];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    
    return cell;
}

- (void)setQuestmodel:(QuestionModel *)questmodel
{
    _questmodel = questmodel;

    AppShare;
    self.titleLabel.text = [AESCrypt decrypt:questmodel.title password:app.loginKeycode];
    
    NSString * str = [AESCrypt decrypt:questmodel.pubtime password:app.loginKeycode];
    timeCover;
    self.titleLabel.text = currentDateStr;
    
}

@end
