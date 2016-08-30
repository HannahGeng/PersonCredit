//
//  MarketViewController.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/9/24.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "MarketViewController.h"

@interface MarketViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic,strong) NSMutableArray * tableDataArray;

@end

@implementation MarketViewController

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
    NavBarType(@"职位邀请")
}

- (void)loadData
{
    AppShare;
    
    if (!_tableDataArray) {
        _tableDataArray = [[NSMutableArray alloc] init];
    }
    
    [[HTTPSessionManager sharedManager] POST:WORK_URL parameters:Dic result:^(id responseObject, NSError *error) {
       
        NSLog(@"职位邀请:%@",responseObject);
        
        if ([responseObject[@"status"] integerValue] == 1) {
            
            _backgroundImageView.hidden = YES;
            
            app.request=responseObject[@"response"];
            
            NSArray * array = responseObject[@"result"];
            
            for (NSDictionary *dictionary in array) {
                
                MarketModel * market = [[MarketModel alloc] initWithDic:dictionary];
                
                [_tableDataArray addObject:market];
            }
            
            NSLog(@"数组:%@",_tableDataArray);
            
            self.tableView.backgroundColor=[UIColor clearColor];
            self.tableView.scrollEnabled =YES; //设置tableview滚动
            self.tableView.tableFooterView=[[UIView alloc]init];//影藏多余的分割线
            
            [self.tableView reloadData];
        }
        
        NSLog(@"uid:%@",[AESCrypt decrypt:responseObject[@"result"][0][@"uid"] password:app.loginKeycode]);
        
        NSLog(@"invitationContent:%@",[AESCrypt decrypt:responseObject[@"result"][0][@"invitationContent"] password:app.loginKeycode]);
        
        NSLog(@"companyName:%@",[AESCrypt decrypt:responseObject[@"result"][0][@"companyName"] password:app.loginKeycode]);
        
        NSLog(@"invitationTime:%@",[AESCrypt decrypt:responseObject[@"result"][0][@"invitationTime"] password:app.loginKeycode]);
        
        NSString * str = [AESCrypt decrypt:responseObject[@"result"][0][@"invitationTime"] password:app.loginKeycode];
        
        timeCover;
        
        NSLog(@"时间:%@",currentDateStr);

    }];
}

#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MarketViewCell * cell = [MarketViewCell cellWithTableView:tableView];
    
    cell.market = self.tableDataArray[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 3;
}

@end
