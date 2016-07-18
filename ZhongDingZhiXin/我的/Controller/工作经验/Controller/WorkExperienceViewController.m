//
//  WorkExperienceViewController.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/10/26.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "WorkExperienceViewController.h"

@interface WorkExperienceViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_workInfoArray;
    MBProgressHUD *mbHud;//提示
}

@property (weak, nonatomic) IBOutlet UITableView *workTableView;

@end

@implementation WorkExperienceViewController

//隐藏TabBar
-(void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden=YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置背景颜色
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage"]]];
    //设置导航栏
    [self setNavigationBar];
    
    //加载数据
    [self loadData];
}
//设置导航栏
-(void)setNavigationBar
{
    //设置导航栏的颜色
    NavBarType(@"工作经验");
    
    //为导航栏添加左侧按钮
    leftButton;

}

-(void)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}
//加载数据
- (void)loadData
{
    AppShare;
    //显示提示
    mbHUDinit;
    
    //初始化_noticeInfoArray
    if (!_workInfoArray) {
        _workInfoArray = [[NSMutableArray alloc] init];
    }
    
    //初始化请求（同时也创建了一个线程）
    [[HTTPSessionManager sharedManager] POST:GZJL_URL parameters:Dic result:^(id responseObject, NSError *error) {
        
        NSLog(@"工作经验:%@",responseObject);
        
        NSArray *array = responseObject[@"result"];
        if (array.count!=0) {
            
            app.request=responseObject[@"response"];
            
            for (NSDictionary *dictionary in array) {
                WorkInfo *workInfo = [[WorkInfo alloc] initWithDictionary:dictionary];
                [_workInfoArray addObject:workInfo];
            }
           
            self.workTableView.backgroundColor=[UIColor clearColor];
            self.workTableView.scrollEnabled =YES; //设置tableview滚动
            self.workTableView.tableFooterView=[[UIView alloc]init];//影藏多余的分割线
            
            [self.workTableView reloadData];
            //隐藏HUD
            hudHide;
            
        }

    }];
    
}
#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _workInfoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WorkViewCell *cell=[WorkViewCell cellWithTableView:tableView];
    
    if (_workInfoArray.count!=0) {
        
        cell.workModel = _workInfoArray[indexPath.row];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.selected = NO;
    
    return cell;
}

#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

@end
