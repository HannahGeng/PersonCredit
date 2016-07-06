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
    MBProgressHUD * mbHud;//提示
}
@property (weak, nonatomic) IBOutlet UITableView *educationTableView;

@end

@implementation EducationExperienceViewController

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
    self.title=@"教育经历";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:20],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
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
    if (!_educationInfoArray) {
        _educationInfoArray = [[NSMutableArray alloc] init];
    }

    //初始化请求（同时也创建了一个线程）

    [[HTTPSessionManager sharedManager] POST:GZJL_URL parameters:Dic result:^(id responseObject, NSError *error) {
        
        NSArray *array = (NSArray *)responseObject[@"result"];
        
        if (array.count!=0) {
            app.request=responseObject[@"response"];
            for (NSDictionary *dictionary in array) {
                EducationInfo *educationInfo = [[EducationInfo alloc] initWithDictionary:dictionary];
                [_educationInfoArray addObject:educationInfo];
            }
        }
            self.educationTableView.dataSource=self;
            self.educationTableView.delegate=self;
            self.educationTableView.backgroundColor=[UIColor clearColor];
            self.educationTableView.scrollEnabled =YES; //设置tableview滚动
            self.educationTableView.tableFooterView=[[UIView alloc]init];//影藏多余的分割线
            
            [self.educationTableView reloadData];
        
            hudHide;

    }];
    
}
#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _educationInfoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier=@"Identifier";
    EducationViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[EducationViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

@end
