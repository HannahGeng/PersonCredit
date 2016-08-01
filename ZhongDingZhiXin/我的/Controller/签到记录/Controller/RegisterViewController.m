//
//  RegisterViewController.m
//  个人职业信用
//
//  Created by zdzx-008 on 16/7/27.
//  Copyright © 2016年 北京职信鼎程. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    MBProgressHUD * mbHud;
}

@property (nonatomic,strong) NSArray * registArray;
@property (weak, nonatomic) IBOutlet UITableView *resgistTableView;

@end

@implementation RegisterViewController

//隐藏TabBar
-(void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden=YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    mbHUDinit;
    
    NavBarType(@"签到记录");
    leftButton;
    
    [self loadData];
}

- (void)backButton
{
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)loadData
{
    AppShare;
    NSMutableArray * registArr = [NSMutableArray array];
    
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:app.uid,@"uid",app.request,@"request", nil];
    [[HTTPSessionManager sharedManager]POST:SIGNLIST_URL parameters:dic result:^(id responseObject, NSError *error) {
        
        NSLog(@"签到记录:%@",responseObject);
        
        if ([responseObject[@"status"] integerValue] > 0) {
            
            hudHide;
            
            self.registArray = responseObject[@"result"];
        }
        
        for (NSDictionary * dic in self.registArray) {
            
            RegistModel * model = [RegistModel resgitWithDic:dic];
            
            [registArr addObject:model];
        }
        
        self.registArray = registArr;
        
        [self.resgistTableView reloadData];
        
        app.request = responseObject[@"response"];
    }];

}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.registArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RegistCell * cell = [RegistCell cellWithTableView:tableView];
    
    cell.registmodel = self.registArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

@end
