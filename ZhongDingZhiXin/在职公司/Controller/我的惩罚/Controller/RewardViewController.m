//
//  RewardViewController.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/10/26.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "RewardViewController.h"

@interface RewardViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_rewardInfoArray;
    MBProgressHUD *mbHud;//提示
}
@property (weak, nonatomic) IBOutlet UITableView *rewardTableView;

@end

@implementation RewardViewController

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
    NavBarType(@"我的惩罚");
    
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
    if (!_rewardInfoArray) {
        _rewardInfoArray = [[NSMutableArray alloc] init];
    }
    
    //初始化请求（同时也创建了一个线程）
    [[HTTPSessionManager sharedManager] POST:CHXX_URL parameters:Dic result:^(id responseObject, NSError *error) {
        
        NSArray *array = (NSArray *)responseObject[@"result"];
      
        if ([responseObject[@"status"] integerValue] == 1) {
            
            NSLog(@"我的惩罚:%@",responseObject);
            
            app.request=responseObject[@"response"];
            
            for (NSDictionary *dictionary in array) {
                RewardInfo *rewardInfo = [[RewardInfo alloc] initWithDictionary:dictionary];
                [_rewardInfoArray addObject:rewardInfo];
            }
            
            self.rewardTableView.backgroundColor=[UIColor clearColor];
            self.rewardTableView.scrollEnabled =YES; //设置tableview滚动
            self.rewardTableView.tableFooterView=[[UIView alloc]init];//影藏多余的分割线
            self.rewardTableView.hidden = NO;
            
            [self.rewardTableView reloadData];
            
            app.rewardArray = array;
            
            //隐藏HUD
            hudHide;
            
        }else{
            
            NSLog(@"暂无惩罚");
        }

    }];  
    
}
#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _rewardInfoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier=@"Identifier";
    RewardViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cell) {
        cell=[[RewardViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (_rewardInfoArray.count!=0) {
        
        RewardInfo*rewardInfo = _rewardInfoArray[indexPath.row];
        [cell setContentView:rewardInfo];
    }
    return cell;
}

#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AfficheViewController * affich = [[AfficheViewController alloc] init];
    
    [self.navigationController pushViewController:affich animated:YES];
    
    AppShare;
    
    app.index = indexPath.row;
}

@end
