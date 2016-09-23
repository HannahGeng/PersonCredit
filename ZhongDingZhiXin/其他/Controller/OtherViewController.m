//
//  OtherViewController.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/9/24.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "OtherViewController.h"

#define SHARE_CONTENT_HEIGHT 250

@interface OtherViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_tableDataArray;
    UITableView *_tableView;
    UIView *_contentView;
    UILabel *_buttonLabel;
}

@end

@implementation OtherViewController

//显示TabBar
-(void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden=NO;
    [UILabel appearance].font = [UILabel changeFont];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置背景颜色
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage"]]];
    //设置导航栏
    [self setNavigationBar];
    //加载tableView
    [self addTableView];
    
    [self loadData];//假数据
    
}

//设置导航栏
-(void)setNavigationBar
{
    //设置导航栏的颜色
    NavBarType(@"其他")
}

-(void)loadData{
    
    _tableDataArray=@[@{@"image":@"guanyuzhongding",@"title":@"关于我们"},
                      @{@"image":@"tuijianpy",@"title":@"推荐我们给朋友"},
                      @{@"image":@"fankui",@"title":@"用户反馈"},
                      @{@"image":@"shezhi",@"title":@"设置"}];
}

//加载tableView
- (void)addTableView {
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], [UIUtils getWindowHeight]-64) style:UITableViewStylePlain];
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.scrollEnabled = YES;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView reloadData];
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier=@"Identifier";
    OtherViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[OtherViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    [cell setContentView:_tableDataArray[indexPath.row]];
    
    return cell;
}

#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 3;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
        
        AboutViewController *aboutVC=[[AboutViewController alloc]init];
        [self.navigationController pushViewController:aboutVC animated:YES];
    }
    if (indexPath.row==1) {
        
        NSURL *shareUrl=[NSURL URLWithString:[NSString stringWithFormat:@"%@",@"http://www.newqc.cn"]];
        NSArray *activityItem=@[shareUrl];
        UIActivityViewController *activityController=[[UIActivityViewController alloc]initWithActivityItems:activityItem applicationActivities:nil];
        
        //设置不出现的活动项目
        activityController.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypePostToFacebook,UIActivityTypePostToTwitter,UIActivityTypeMessage,UIActivityTypeMail,UIActivityTypePrint,UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeAirDrop,UIActivityTypeOpenInIBooks];

        [self.navigationController presentViewController:activityController animated:YES completion:nil];
        
    }
    if (indexPath.row==2) {
        FeedbackViewController *feedbackCarVC=[[FeedbackViewController alloc]init];
        [self.navigationController pushViewController:feedbackCarVC animated:YES];
    }
    if (indexPath.row==3) {
        SetViewController *setCarVC=[[SetViewController alloc]init];
        [self.navigationController pushViewController:setCarVC animated:YES];
    }

}

@end
