//
//  WordCarViewCell.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/11/16.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "WordCarViewCell.h"

@interface WordCarViewCell ()
{
    UIImageView *_topImage;
    UILabel *_titleLable;
    UILabel *_timeLable;
}
@end

@implementation WordCarViewCell

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
    
    _topImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], 10)];
    _topImage.image=[UIImage imageNamed:@"backgroundImage"];
    [self addSubview:_topImage];
    
    _titleLable=[[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(_topImage.frame)+5, 210, 40)];
    _titleLable.font=[UIFont systemFontOfSize:15];
    [self addSubview:_titleLable];
    
    _timeLable =[[UILabel alloc] initWithFrame:CGRectMake([UIUtils getWindowWidth]-150, CGRectGetMaxY(_topImage.frame)+5, 120, 40)];
    _timeLable.font=[UIFont systemFontOfSize:15];
    [self addSubview:_timeLable];
}

-(void)setContentView:(WordCarInfo *)wordCarInfo{
    AppShare;
    NSString *strMark=[AESCrypt decrypt:wordCarInfo.job password:app.loginKeycode];
    [_titleLable setText:strMark];
    [_timeLable setText:wordCarInfo.worktime];
}

@end
