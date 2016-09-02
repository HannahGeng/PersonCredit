//
//  EducationViewCell.h
//  个人职业信用
//
//  Created by zdzx-008 on 16/9/2.
//  Copyright © 2016年 北京职信鼎程. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EducationInfo;

@interface EducationViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *educationLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *subjectLabel;

/** model */
@property (nonatomic,strong) EducationInfo * education;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
