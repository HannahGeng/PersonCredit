//
//  EducationViewCell.m
//  个人职业信用
//
//  Created by zdzx-008 on 16/9/2.
//  Copyright © 2016年 北京职信鼎程. All rights reserved.
//

#import "EducationViewCell.h"

@implementation EducationViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    EducationViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"education"];
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    
    return cell;
}

- (void)setEducation:(EducationInfo *)education
{
    _education = education;
    
    AppShare;
    
    self.educationLabel.text = [AESCrypt decrypt:education.company password:app.loginKeycode];
    self.timeLabel.text = [AESCrypt decrypt:education.worktime password:app.loginKeycode];
    self.subjectLabel.text = [AESCrypt decrypt:education.job password:app.loginKeycode];
}

@end
