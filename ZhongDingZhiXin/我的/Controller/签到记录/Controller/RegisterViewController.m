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
@property (weak, nonatomic) IBOutlet UIView *noneView;

@end

@implementation RegisterViewController

//隐藏TabBar
-(void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden=YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    AppShare;
    
    NavBarType(@"签到记录");
    leftButton;
    
    self.registArray = app.registArray;
    
    self.noneView.hidden = YES;

    if (self.registArray == NULL) {
        
        self.resgistTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.noneView.hidden = NO;
        
    }else{
        
        [self.resgistTableView reloadData];

    }
    
}

- (void)backButton
{
    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.registArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RegistCell * cell = [RegistCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.registmodel = self.registArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

@end
