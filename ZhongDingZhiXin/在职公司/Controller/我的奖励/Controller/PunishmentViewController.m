//
//  PunishmentViewController.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/10/26.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "PunishmentViewController.h"

@interface PunishmentViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_punishmentInfoArray;
    UITableView *_tableView;
    MBProgressHUD *mbHud;//提示
}

@end

@implementation PunishmentViewController

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
    NavBarType(@"我的奖励");
    
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
    if (!_punishmentInfoArray) {
        _punishmentInfoArray = [[NSMutableArray alloc] init];
    }

    //初始化请求（同时也创建了一个线程）
    [[HTTPSessionManager sharedManager] POST:JLXX_URL parameters:Dic result:^(id responseObject, NSError *error) {
     
        NSLog(@"我的奖励:%@",responseObject);
        
        NSArray *array = (NSArray *)responseObject[@"result"];
        
        if (array.count!=0) {
            app.request=responseObject[@"response"];
            for (NSDictionary *dictionary in array) {
                PunishmentInfo *punishmentInfo = [[PunishmentInfo alloc] initWithDictionary:dictionary];
                [_punishmentInfoArray addObject:punishmentInfo];
            }
            
            app.punishArray = array;
            
            _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 10, [UIUtils getWindowWidth], [UIUtils getWindowHeight]-100) style:UITableViewStylePlain];
            _tableView.backgroundColor=[UIColor clearColor];
            _tableView.dataSource=self;
            _tableView.delegate=self;
            _tableView.scrollEnabled = YES;
            _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
            [self.view addSubview:_tableView];
            
            [_tableView reloadData];
            
            //隐藏HUD
            hudHide;
        }

    }];
    
}

#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _punishmentInfoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier=@"Identifier";
    
    PunishmentViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (!cell) {
        cell=[[PunishmentViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (_punishmentInfoArray.count!=0) {
        
        PunishmentInfo *punishmentInfo = _punishmentInfoArray[indexPath.row];
        [cell setContentView:punishmentInfo];
    }
    return cell;
}

#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AppShare;
    
    app.index = indexPath.row;
    
    AfficheViewController * affich = [[AfficheViewController alloc] init];
    
    [self.navigationController pushViewController:affich animated:YES];
    
}

@end
