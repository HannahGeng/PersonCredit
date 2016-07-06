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
    MBProgressHUD *_HUD;//提示
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
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage.png"]]];
    //设置导航栏
    [self setNavigationBar];
    
    //加载数据
    [self loadData];
}
//设置导航栏
-(void)setNavigationBar
{
    //设置导航栏的颜色
    self.navigationController.navigationBar.barTintColor=LIGHT_WHITE_COLOR;
    self.title=@"我的奖励";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:20],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
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
    [self show:MBProgressHUDModeIndeterminate message:@"努力加载中......" customView:self.view];
    
    //初始化_noticeInfoArray
    if (!_punishmentInfoArray) {
        _punishmentInfoArray = [[NSMutableArray alloc] init];
    }

    //初始化请求（同时也创建了一个线程）
    [[HTTPSessionManager sharedManager] POST:JLXX_URL parameters:Dic result:^(id responseObject, NSError *error) {
     
        NSArray *array = (NSArray *)responseObject[@"result"];
        if (array.count==0) {
            
        }
        
        if (array.count!=0) {
            app.request=responseObject[@"response"];
            for (NSDictionary *dictionary in array) {
                PunishmentInfo *punishmentInfo = [[PunishmentInfo alloc] initWithDictionary:dictionary];
                [_punishmentInfoArray addObject:punishmentInfo];
            }
            
            _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, [UIUtils getWindowWidth], [UIUtils getWindowHeight]-100) style:UITableViewStylePlain];
            _tableView.backgroundColor=[UIColor clearColor];
            _tableView.dataSource=self;
            _tableView.delegate=self;
            _tableView.scrollEnabled = YES;
            _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
            [self.view addSubview:_tableView];
            
            [_tableView reloadData];
            //隐藏HUD
            [self hideHUDafterDelay:0.3f];
            
        }

    }];
    
}

#pragma mark HUD
//展示HUD
-(void) show:(MBProgressHUDMode )_mode message:(NSString *)_message customView:(id)_customView
{
    _HUD = [[MBProgressHUD alloc] initWithView:_customView];
    [_customView addSubview:_HUD];
    _HUD.mode=_mode;
    _HUD.customView = _customView;
    _HUD.animationType = MBProgressHUDAnimationZoom;
    _HUD.labelText = _message;
    [_HUD show:YES];
}

//隐藏HUD
- (void)hideHUDafterDelay:(CGFloat)delay
{
    [_HUD hide:YES afterDelay:delay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _punishmentInfoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier=@"Identifier";
    PunishmentViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[PunishmentViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
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
}

@end
