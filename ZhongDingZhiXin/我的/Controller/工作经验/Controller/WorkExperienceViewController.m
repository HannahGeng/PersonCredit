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
    NSDictionary *_dic;
    MBProgressHUD *_HUD;//提示
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
    self.title=@"工作经验";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:20],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    //为导航栏添加左侧按钮
    UIButton* leftBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 20, 20);
    [leftBtn setImage:[UIImage imageNamed:@"fanhui-5.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
}

-(void)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}
//加载数据
- (void)loadData
{
    //显示提示
    [self show:MBProgressHUDModeIndeterminate message:@"努力加载中......" customView:self.view];
    
    //初始化_noticeInfoArray
    if (!_workInfoArray) {
        _workInfoArray = [[NSMutableArray alloc] init];
    }
    AppDelegate *app = [AppDelegate sharedAppDelegate];
    NSString *str=app.keycode;
    NSString *stri=[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    _dic=[[NSDictionary alloc]initWithObjectsAndKeys:stri,@"uid",str,@"request",nil];
    
    //初始化请求（同时也创建了一个线程）
    [[HTTPSessionManager sharedManager] POST:GZJL_URL parameters:_dic result:^(id responseObject, NSError *error) {
        
        NSArray *array = (NSArray *)responseObject[@"result"];
        if (array.count!=0) {
            AppDelegate *app = [AppDelegate sharedAppDelegate];
            app.keycode=responseObject[@"response"];
            for (NSDictionary *dictionary in array) {
                WorkInfo *workInfo = [[WorkInfo alloc] initWithDictionary:dictionary];
                [_workInfoArray addObject:workInfo];
            }
            self.workTableView.dataSource=self;
            self.workTableView.delegate=self;
            self.workTableView.backgroundColor=[UIColor clearColor];
            self.workTableView.scrollEnabled =YES; //设置tableview滚动
            self.workTableView.tableFooterView=[[UIView alloc]init];//影藏多余的分割线
            
            [self.workTableView reloadData];
            //隐藏HUD
            [self hideHUDafterDelay:0.3f];
            
        }
        NSString *stri=[[NSUserDefaults standardUserDefaults] objectForKey:@"keycode"];
        NSLog(@"%@",stri);

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
    return _workInfoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier=@"Identifier";
    WorkViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[WorkViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    if (_workInfoArray.count!=0) {
        WorkInfo *workInfo = _workInfoArray[indexPath.row];
        [cell setContentView:workInfo];
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
