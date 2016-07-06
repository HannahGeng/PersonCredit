//
//  CompanyViewController.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/9/24.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "CompanyViewController.h"

@interface CompanyViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_tableDataArray;
    UITableView *_tableView;
}
@end

@implementation CompanyViewController

//显示TabBar
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=NO;
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
    self.navigationController.navigationBar.barTintColor=LIGHT_WHITE_COLOR;
    self.title=@"在职公司";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:20],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
}
-(void)loadData{
    
    _tableDataArray=@[@{@"image":@"zzgg",@"title":@"在职公司公告"},
                      @{@"image":@"wdcf",@"title":@"我的惩罚"},
                      @{@"image":@"wdjl",@"title":@"我的奖励"}
                     ];
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
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier=@"Identifier";
    CompanyViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[CompanyViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
       NoticeViewController *noticeVC=[[NoticeViewController alloc]init];
        [self.navigationController pushViewController:noticeVC animated:YES];
    }
    if (indexPath.row==1) {
        RewardViewController  *rewardVC=[[RewardViewController alloc]init];
        [self.navigationController pushViewController:rewardVC animated:YES];
    }
    if (indexPath.row==2) {
        PunishmentViewController *punishmentVC=[[PunishmentViewController alloc]init];
        [self.navigationController pushViewController:punishmentVC animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
