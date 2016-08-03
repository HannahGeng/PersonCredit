//
//  EducationExperienceViewController.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/10/26.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "EducationViewCell.h"

@interface EducationExperienceViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_educationInfoArray;
    NSArray * array;
    MBProgressHUD * mbHud;//提示
}
@property (weak, nonatomic) IBOutlet UITableView *educationTableView;
@property (weak, nonatomic) IBOutlet UIView *noneView;

@end

@implementation EducationExperienceViewController

//隐藏TabBar
-(void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden=YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppShare;
    
    self.noneView.hidden = YES;
    
    //设置背景颜色
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage"]]];
    //设置导航栏
    [self setNavigationBar];
 
    //初始化_noticeInfoArray
    if (!_educationInfoArray) {
        _educationInfoArray = [[NSMutableArray alloc] init];
    }
    _educationInfoArray = app.educateArray;
    
    if (_educationInfoArray == NULL) {
        
        self.educationTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.noneView.hidden = NO;
        
    }else{
        
        self.educationTableView.scrollEnabled =YES; //设置tableview滚动
        self.educationTableView.tableFooterView=[[UIView alloc]init];//影藏多余的分割线
        
        [self.educationTableView reloadData];

    }

}
//设置导航栏
-(void)setNavigationBar
{
    //设置导航栏的颜色
    NavBarType(@"教育经历");
    
    //为导航栏添加左侧按钮
    leftButton;

}

-(void)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _educationInfoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier=@"Identifier";
    EducationViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (!cell) {
        cell=[[EducationViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (_educationInfoArray.count!=0) {
        EducationInfo *educationInfo = _educationInfoArray[indexPath.row];
        [cell setContentView:educationInfo];
    }
    return cell;
}

#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

@end
