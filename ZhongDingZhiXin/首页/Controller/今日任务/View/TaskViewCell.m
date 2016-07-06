//
//  TaskViewCell.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/11/2.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "TaskViewCell.h"

@interface TaskViewCell ()
{
    UIImageView *_pointImage;
    UITextView *_textView;
    UIImageView *_dingImage;
}
@end

@implementation TaskViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellClink:)];
        [self addGestureRecognizer:tap];

        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //添加内容视图
        [self addContentView];
    }
    return self;
    
}
//添加内容视图
-(void)addContentView{
    
    _pointImage =[[UIImageView alloc] initWithFrame:CGRectMake(15, 20, 40, 40)];
    [self addSubview:_pointImage];
    _textView=[[UITextView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_pointImage.frame)+10 , 20, 190, 50)];
    _textView.editable = NO;
    _textView.userInteractionEnabled=YES;
    [self addSubview:_textView];
    _dingImage=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_textView.frame)+35, 20, 25, 35)];
    [self addSubview:_dingImage];
}

-(void)cellClink:(TaskViewCell *)cell{
    
    //发送通知
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"add_name" object:[NSNumber numberWithInt:(int)self.tag]];
}

-(void)setContentView:(NSDictionary *)dictionary andDictionary:(NSDictionary *)dic{
    _textView.text=[NSString stringWithFormat:@"%@ %@",dic[@"address"],dic[@"name"]];
    
    _pointImage.image=[UIImage imageNamed:dictionary[@"image"]];
    _dingImage.image=[UIImage imageNamed:dictionary[@"image2"]];
}

@end