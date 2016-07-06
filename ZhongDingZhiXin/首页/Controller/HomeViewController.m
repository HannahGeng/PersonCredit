//
//  HomeViewController.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/9/24.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    TaskViewController *_taskVC;
    WordCarViewController *_wordCarVC;
    NSDictionary *_dic;
    MBProgressHUD * mbHud;
    AppDelegate *app;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray * noticeInfoArray;

@end

@implementation HomeViewController

//显示TabBar
-(void)viewWillAppear:(BOOL)animated{
    
    [self setHidesBottomBarWhenPushed:NO];
    self.tabBarController.tabBar.hidden=NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置背景颜色
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage.png"]]];
    //设置导航栏
    [self setNavigationBar];

    [self loadData];
    
    self.tableView.backgroundColor=[UIColor clearColor];
    self.tableView.scrollEnabled =YES; //设置tableview滚动
    self.tableView.tableFooterView=[[UIView alloc]init];//影藏多余的分割线
}
//加载数据
- (void)loadData
{
      //初始化_noticeInfoArray
    if (!_noticeInfoArray) {
        _noticeInfoArray = [[NSMutableArray alloc] init];
    }
    app = [AppDelegate sharedAppDelegate];
    _dic=[[NSDictionary alloc]initWithObjectsAndKeys:app.uid,@"uid",app.request,@"request",nil];
    
    //初始化请求（同时也创建了一个线程）
    [[HTTPSessionManager sharedManager] POST:GGTZ_URL parameters:_dic result:^(id responseObject, NSError *error) {
        
        NSArray *array = (NSArray *)responseObject[@"result"];
        if (array.count!=0) {

            app.request = responseObject[@"response"];
            for (NSDictionary *dictionary in array) {
                NoticeInfo *noticeInfo = [[NoticeInfo alloc] initWithDictionary:dictionary];
                [_noticeInfoArray addObject:noticeInfo];
            }
            [self.tableView reloadData];

        }

    }];
    
}
//设置导航栏
-(void)setNavigationBar
{
    //设置导航栏的颜色
    NavBarType(@"首页");
    
    //为导航栏添加右侧按钮
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake([UIUtils getWindowWidth]-25, 0, 20, 20);
    [rightBtn setImage:[UIImage imageNamed:@"xiaoxi.png"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(remindButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

-(void)remindButton
{
    NSLog(@"remindButton");
}

#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==0) {
        TitleViewCell *cell=[TitleViewCell cellWithTableView:self.tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==1) {
        NoticeViewCell *cell=[NoticeViewCell cellWithTableView:self.tableView];
        //无色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
        return cell;
    }
    if (indexPath.row==2) {
        
        ListViewCell *cell=[ListViewCell cellWithTableView:self.tableView];
        if (_noticeInfoArray.count>0) {
        NoticeInfo *noticeInfo = _noticeInfoArray[0];
        NSString *tit  =   [[NSUserDefaults standardUserDefaults] objectForKey:@"keycode"];
        NSString *strTitle = [AESCrypt decrypt:noticeInfo.title password:tit];
        NSString *strMark  = [AESCrypt decrypt:noticeInfo.mark password:tit];
        cell.titleName.text=strTitle;
        cell.dateLabel.text=strMark;
        }
        return cell;
    }
    if (indexPath.row==3) {
        ListViewCell *cell=[ListViewCell cellWithTableView:self.tableView];
        
        if (_noticeInfoArray.count>1) {
            NoticeInfo *noticeInfo = _noticeInfoArray[1];
            NSString *tit  =   [[NSUserDefaults standardUserDefaults] objectForKey:@"keycode"];
            NSString *strTitle = [AESCrypt decrypt:noticeInfo.title password:tit];
            NSString *strMark  = [AESCrypt decrypt:noticeInfo.mark password:tit];
            cell.titleName.text=strTitle;
            cell.dateLabel.text=strMark;
        }
        return cell;
    }
    if (indexPath.row==4) {
        ListViewCell *cell=[ListViewCell cellWithTableView:self.tableView];
        if (_noticeInfoArray.count>2) {
            NoticeInfo *noticeInfo = _noticeInfoArray[2];
            NSString *tit  =   [[NSUserDefaults standardUserDefaults] objectForKey:@"keycode"];
            NSString *strTitle = [AESCrypt decrypt:noticeInfo.title password:tit];
            NSString *strMark  = [AESCrypt decrypt:noticeInfo.mark password:tit];
            cell.titleName.text=strTitle;
            cell.dateLabel.text=strMark;
        }
        
        return cell;
    }
    if (indexPath.row==5) {
        ButtonViewCell *cell=[ButtonViewCell cellWithTableView:self.tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.taskButton addTarget:self action:@selector(taskButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.wordCardButton addTarget:self action:@selector(wordCardButtonClick) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
     return nil;
}

-(void)taskButtonClick
{
    _taskVC =[[TaskViewController alloc] initWithNibName:@"TaskViewController" bundle:nil];
    [self.navigationController pushViewController:_taskVC animated:YES];
}

-(void)wordCardButtonClick
{
    _wordCarVC =[[WordCarViewController alloc] initWithNibName:@"WordCarViewController" bundle:nil];
    //隐藏tabBar
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:_wordCarVC animated:YES];
}
#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 150;
    }
    if (indexPath.row==1){
        return 70;
    }
    if (indexPath.row==2){
        return 50;
    }
    if (indexPath.row==3){
        return 50;
    }
    if (indexPath.row==4){
        return 50;
    }
        return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==1) {
        NoticeViewController *companyVC=[[NoticeViewController alloc]init];
        [self.navigationController pushViewController:companyVC animated:YES];
    }
    if (indexPath.row==2) {
        AfficheViewController *afficheVC=[[AfficheViewController alloc]init];
        if (_noticeInfoArray.count>0) {
           afficheVC.noticeInfo=_noticeInfoArray[0];
        }
        [self.navigationController pushViewController:afficheVC animated:YES];
    }
    if (indexPath.row==3) {
        AfficheViewController *afficheVC=[[AfficheViewController alloc]init];
        if (_noticeInfoArray.count>1) {
            afficheVC.noticeInfo=_noticeInfoArray[1];
        }
        [self.navigationController pushViewController:afficheVC animated:YES];
    }
    if (indexPath.row==4) {
        AfficheViewController *afficheVC=[[AfficheViewController alloc]init];
        if (_noticeInfoArray.count>2) {
            afficheVC.noticeInfo=_noticeInfoArray[2];
        }
        [self.navigationController pushViewController:afficheVC animated:YES];
    }
}

@end
