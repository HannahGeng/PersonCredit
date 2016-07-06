//
//  TaskView.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/11/2.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "TaskView.h"

@interface TaskView ()<UITableViewDataSource,UITableViewDelegate>
{
    UIView *_contentView;
    NSArray *_tableDataArray;
    NSArray *_nameArray;
}
@end

@implementation TaskView
- (id)initWithFrame:(CGRect)frame andArray:(NSArray *)array
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        _nameArray=array;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self    action:@selector(removeView)];
        [self addGestureRecognizer:tapGesture];
        
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(20, [UIUtils getWindowHeight]-480, [UIUtils getWindowWidth]-20*2, 480)];
        UITapGestureRecognizer *tapContentGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
        [_contentView addGestureRecognizer:tapContentGesture];
        [_contentView setBackgroundColor:SHARE_CONTENT_WHITE_COLOR];
        [self addSubview:_contentView];
        
        [self addTableView];
        [self loadData];
    }
    return self;
}

-(void)loadData{
    
    _tableDataArray=@[@{@"image":@"jrrwdizhi1@2x.png",@"image2":@"jrrwdingw.png"},
                      @{@"image":@"jrrwdizhi2@2x.png",@"image2":@"jrrwdingw.png"},
                      @{@"image":@"jrrwdizhi3@2x.png",@"image2":@"jrrwdingw.png"},
                      @{@"image":@"jrrwdizhi4@2x.png",@"image2":@"jrrwdingw.png"},
                      @{@"image":@"jrrwdizhi5@2x.png",@"image2":@"jrrwdingw.png"},
                      @{@"image":@"jrrwdizhi6@2x.png",@"image2":@"jrrwdingw.png"}];
}

-(void)addTableView
{
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth]-40, 480) style:UITableViewStylePlain];
    tableView.backgroundColor=[UIColor whiteColor];
    tableView.delegate=self;
    tableView.dataSource=self;

    [_contentView addSubview:tableView];
    
}
- (void)showInView:(UIView *)view
{
    [view addSubview:self];
    [UIView animateWithDuration:0.3
                     animations:^{
                         [self setBackgroundColor:LIGHT_OPAQUE_BLACK_COLOR];
                         [_contentView setFrame:CGRectMake(20, [UIUtils getWindowHeight]-480, [UIUtils getWindowWidth]-40, 480)];
                     } completion:nil];
}

- (void)removeView
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         [self setBackgroundColor:[UIColor clearColor]];
                         [_contentView setFrame:CGRectMake(20, [UIUtils getWindowHeight], [UIUtils getWindowWidth]-40, 480)];
                     } completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_nameArray.count<=6) {
          return _nameArray.count;
    }
    else{
    
        return 6;
    
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    TaskViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[TaskViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.tag=indexPath.row;
    [cell setContentView:_tableDataArray[indexPath.row] andDictionary:_nameArray[indexPath.row]];
    
    return cell;
}


#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
@end
