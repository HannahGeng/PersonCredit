//
//  MyViewController.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/9/24.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_tableDataArray;
    UITableView *_tableView;
    MBProgressHUD * mbHud;
}
@end

@implementation MyViewController

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
    self.title=@"我的";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:20],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
}
-(void)loadData{
    
    _tableDataArray=@[@{@"image":@"xinxi",@"title":@"基本信息"},
                      @{@"image":@"gzjy",@"title":@"工作经验"},
                      @{@"image":@"jyjl",@"title":@"教育经历"},
                      @{@"image":@"qdjl",@"title":@"签到列表"}];
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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier=@"Identifier";
    MyViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[MyViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    //无色
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
        
        [self loadMessageData];
        
    }
    if (indexPath.row==1) {
        
        [self loadWork];
    }
    if (indexPath.row==2) {
        
        [self loadEducate];
    }
    if (indexPath.row == 3)
    {
        
        [self loadRegist];
        
    }
}

//加载数据
- (void)loadWork
{
    AppShare;
    
    AFNetworkReachabilityManager * mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr startMonitoring];
    
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status != 0) {
            
            mbHUDinit;

            //初始化请求（同时也创建了一个线程）
            [[HTTPSessionManager sharedManager] POST:GZJL_URL parameters:Dic result:^(id responseObject, NSError *error) {
                
                NSLog(@"工作经验:%@",responseObject);
                
                NSArray *array = responseObject[@"result"];
                
                NSMutableArray * worka = [NSMutableArray new];
                
                if ([responseObject[@"status"] integerValue] == 1) {
                    
                    app.request=responseObject[@"response"];
                    
                    for (NSDictionary *dictionary in array) {
                        WorkInfo *workInfo = [[WorkInfo alloc] initWithDictionary:dictionary];
                        [worka addObject:workInfo];
                    }
                    
                    app.workArray = worka;
                    
                    //隐藏HUD
                    hudHide;
                    WorkExperienceViewController  *workExperienceVC=[[WorkExperienceViewController alloc]init];
                    [self.navigationController pushViewController:workExperienceVC animated:YES];

                }else{
                    
                    app.workArray = NULL;
                }
                
            }];

        }else
        {
            noWebhud;
        }
        
    }];
    
}

//加载数据
- (void)loadMessageData
{
    AppShare;
    
    //初始化请求（同时也创建了一个线程）
    AFNetworkReachabilityManager * mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr startMonitoring];
    
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status != 0) {
            
            mbHUDinit;

            [[HTTPSessionManager sharedManager] POST:JUCHU_URL parameters:Dic result:^(id responseObject, NSError *error) {
        
                app.avatar = [AESCrypt decrypt:responseObject[@"result"][@"avatar"] password:app.loginKeycode];
                app.from = [AESCrypt decrypt:responseObject[@"result"][@"from"] password:app.loginKeycode];
                app.age = [AESCrypt decrypt:responseObject[@"result"][@"age"] password:app.loginKeycode];
                app.realname = [AESCrypt decrypt:responseObject[@"reault"][@"realname"] password:app.loginKeycode];
                app.sex = [AESCrypt decrypt:responseObject[@"result"][@"sex"] password:app.loginKeycode];
                
                NSMutableArray *array = responseObject[@"result"];
                
                NSLog(@"个人资料%@",array);
                
                if (array.count != 0) {
                    
                    app.request=responseObject[@"response"];
                    
                    app.messages = array;
                }
                
                hudHide;
                
                MessageViewController *messageVC=[[MessageViewController alloc]init];
                [self.navigationController pushViewController:messageVC animated:YES];

            }];
            
        }else
        {
            noWebhud;
        }
        
    }];
    
}

//加载数据
- (void)loadEducate
{
    //显示提示
    mbHUDinit;
    
    AppShare;
    
    AFNetworkReachabilityManager * mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr startMonitoring];
    
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status != 0) {
            
            //初始化请求（同时也创建了一个线程）
            [[HTTPSessionManager sharedManager] POST:JYJL_URL parameters:Dic result:^(id responseObject, NSError *error) {
                                
                NSMutableArray * educate = [NSMutableArray new];
                app.request=responseObject[@"response"];

                if([responseObject[@"status"] integerValue] == 1){
                    
                    for (NSDictionary *dictionary in responseObject[@"result"]) {
                        
                        EducationInfo *educationInfo = [[EducationInfo alloc] initWithDictionary:dictionary];
                        [educate addObject:educationInfo];
                        
                    }
                    
                    app.educateArray = educate;
                    
                }else{
                    
                    app.educateArray = NULL;
                }
                
                hudHide;
                
                EducationExperienceViewController *educationExperienceVC=[[EducationExperienceViewController alloc]init];
                [self.navigationController pushViewController:educationExperienceVC animated:YES];

            }];
            
        }else
        {
            noWebhud;
        }
        
    }];

    
}

- (void)loadRegist
{
    AppShare;
    
    mbHUDinit;
    
    NSMutableArray * registArr = [NSMutableArray array];
    
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:app.uid,@"uid",app.request,@"request", nil];
    [[HTTPSessionManager sharedManager]POST:SIGNLIST_URL parameters:dic result:^(id responseObject, NSError *error) {
        
        app.request = responseObject[@"response"];
        
        NSArray * resultArr = [[NSArray alloc] init];
        
        if ([responseObject[@"status"] integerValue] > 0) {
            
            hudHide;
            
            resultArr = responseObject[@"result"];
        
            for (NSDictionary * dic in resultArr) {
                
                RegistModel * model = [RegistModel resgitWithDic:dic];
                
                [registArr addObject:model];
            }
        
            app.registArray = registArr;
            
        }else{
            
            app.registArray = NULL;
        }
        
        hudHide;
        
        RegisterViewController * regis = [[RegisterViewController alloc] init];
        [self.navigationController pushViewController:regis animated:YES];

        
    }];
    
}

@end
