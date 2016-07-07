//
//  NoticeViewController.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/10/14.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "NoticeViewController.h"

@interface NoticeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_noticeInfoArray;
    MBProgressHUD *mbHud;//提示
}
@property (weak, nonatomic) IBOutlet UITableView *noticeTableView;

@end

@implementation NoticeViewController

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
    NavBarType(@"公司公告");
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
    //显示提示
    mbHUDinit;
    
    AppShare;
    //初始化_noticeInfoArray
    if (!_noticeInfoArray) {
        _noticeInfoArray = [[NSMutableArray alloc] init];
    }
    
    //初始化请求（同时也创建了一个线程）
    [[HTTPSessionManager sharedManager] POST:GGTZ_URL parameters:Dic result:^(id responseObject, NSError *error) {
        
        NSArray *array = (NSArray *)responseObject[@"result"];
        if (array.count!=0) {
            
            app.request=responseObject[@"response"];
            
            for (NSDictionary *dictionary in array) {
                NoticeInfo *noticeInfo = [[NoticeInfo alloc] initWithDictionary:dictionary];
                [_noticeInfoArray addObject:noticeInfo];
            }
           
            self.noticeTableView.backgroundColor=[UIColor clearColor];
            self.noticeTableView.scrollEnabled =YES; //设置tableview滚动
            self.noticeTableView.tableFooterView=[[UIView alloc]init];//影藏多余的分割线
            
            [self.noticeTableView reloadData];
            //隐藏HUD
            hudHide;
            
        }
        
    }];
    
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _noticeInfoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"Identifier";
    TableNoticeViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell=[[TableNoticeViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;

    if (_noticeInfoArray.count!=0) {
        NoticeInfo *noticeInfo = _noticeInfoArray[indexPath.row];
        [cell setContentView:noticeInfo];
     }
    return cell;
}

#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AfficheViewController *affPage=[[AfficheViewController alloc] init];
    affPage.noticeInfo= _noticeInfoArray[indexPath.row];
    
    [self.navigationController pushViewController:affPage animated:YES];
}

@end
