//
//  TableNoticeViewCell.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/11/12.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "TableNoticeViewCell.h"

@interface TableNoticeViewCell ()
{
    UIImageView *_topImage;
    UILabel *_titleLable;
    UILabel *_timeLable;
    NSString * _font;
}

@end

@implementation TableNoticeViewCell

-(void)viewWillAppear:(BOOL)animated{
    
    [UILabel appearance].font = [UILabel changeFont];
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
    
    _topImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], 0)];
    _topImage.image=[UIImage imageNamed:@"backgroundImage"];
    [self addSubview:_topImage];
    
    _titleLable=[[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(_topImage.frame)+5, 200, 40)];
    _font = APP_Font;
    _titleLable.font=[UIFont systemFontOfSize:15 * [_font floatValue]];
    
    [self addSubview:_titleLable];
    
    _timeLable =[[UILabel alloc] initWithFrame:CGRectMake([UIUtils getWindowWidth]-115, CGRectGetMaxY(_topImage.frame)+5, 100, 40)];
    _timeLable.font=[UIFont systemFontOfSize:15];
    [self addSubview:_timeLable];
}

-(void)setContentView:(NoticeInfo*)noticeInfo{
    
    AppShare;
    NSString * strTitle  = [AESCrypt decrypt:noticeInfo.title password:app.loginKeycode];
    NSString * strMark = [AESCrypt decrypt:noticeInfo.mark password:app.loginKeycode];
    
    [_titleLable setText:strTitle];
    
    //时间戳转标准时间
    NSString * str= strMark;//时间戳
    
    timeCover;
    
    [_timeLable setText:currentDateStr];

}

@end
