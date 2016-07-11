//
//  PunishmentViewCell.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/11/12.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "PunishmentViewCell.h"

@interface PunishmentViewCell ()
{
    UIImageView *_topImage;
    UILabel *_titleLable;
    UILabel *_timeLable;
}
@end

@implementation PunishmentViewCell
-(void)viewWillAppear:(BOOL)animated{
    
    NSString *string=APP_Font;
    _titleLable.font=[UIFont systemFontOfSize:15*[string floatValue]];
    _timeLable.font=[UIFont systemFontOfSize:15*[string floatValue]];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //添加内容视图
        [self addContentView];
    }
    return self;
    
}
//添加内容视图
-(void)addContentView{
    
    NSString *str=APP_Font;
    if (!str){
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"change_font"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    _topImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], 10)];
    _topImage.image=[UIImage imageNamed:@"backgroundImage"];
    [self addSubview:_topImage];
    
    _titleLable=[[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(_topImage.frame)+5, 200, 40)];
    _titleLable.font=[UIFont systemFontOfSize:15];
    [self addSubview:_titleLable];
    
    _timeLable =[[UILabel alloc] initWithFrame:CGRectMake([UIUtils getWindowWidth]-125, CGRectGetMaxY(_topImage.frame)+5, 110, 40)];
    _timeLable.font=[UIFont systemFontOfSize:15];
    [self addSubview:_timeLable];
}

-(void)setContentView:(PunishmentInfo*)punishmentInfo{
    AppShare;
    NSString *strTitle  = [AESCrypt decrypt:punishmentInfo.topic password:app.loginKeycode];
//    NSString *strMark=[AESCrypt decrypt:punishmentInfo.topic password:app.loginKeycode];
    [_titleLable setText:strTitle];
//    [_timeLable setText:strMark];
}

@end
