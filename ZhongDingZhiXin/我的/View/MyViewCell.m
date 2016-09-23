//
//  MyViewCell.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/9/28.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "MyViewCell.h"

@interface MyViewCell ()
{
    UIImageView *_topImage;
    UIImageView *_pointImage;
    UILabel *_titleLabel;
    NSString * _font;
}
@end

@implementation MyViewCell


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
    
    _pointImage =[[UIImageView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(_topImage.frame)+15, 40, 40)];
    [self addSubview:_pointImage];
    
    _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_pointImage.frame)+10, CGRectGetMaxY(_topImage.frame)+15, [UIUtils getWindowWidth]-CGRectGetMaxX(_pointImage.frame)-50-10, 40)];
    [self addSubview:_titleLabel];
    
}

-(void)setContentView:(NSDictionary *)dictionary{
    
    _font = APP_Font;
    
    _pointImage.image=[UIImage imageNamed:dictionary[@"image"]];
    _titleLabel.text=dictionary[@"title"];
    _titleLabel.font=[UIFont systemFontOfSize:15*[_font floatValue]];
}

@end
