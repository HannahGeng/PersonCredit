//
//  MarketViewController.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/9/24.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "MarketViewController.h"

@interface MarketViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    MBProgressHUD * mbHud;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *backView;

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
    
    mbHUDinit;

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
    
    [[HTTPSessionManager sharedManager] POST:WORK_URL parameters:Dic result:^(id responseObject, NSError *error) {
        
        app.request=responseObject[@"response"];
        
        if ([responseObject[@"status"] integerValue] == 1) {
            
            NSArray * array = responseObject[@"result"];
            
            for (NSDictionary *dictionary in array) {
                
                MarketModel * market = [[MarketModel alloc] initWithDic:dictionary];
                
                [_tableDataArray addObject:market];
            }
                        
            self.tableView.tableFooterView=[[UIView alloc]init];//影藏多余的分割线
            
            [self.tableView reloadData];
            
            hudHide;
            
        }else
        {
            hudHide;
            
            self.backView.hidden = NO;
            
            self.tableView.hidden = YES;
        }

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
    
    cell.numIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"jrrwdizhi%ld",indexPath.row + 1]];

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
