//
//  PageViewController.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/10/29.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "PageViewController.h"

@interface PageViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation PageViewController

//隐藏TabBar
-(void)viewWillAppear:(BOOL)animated{
    
    [self setHidesBottomBarWhenPushed:NO];
    self.tabBarController.tabBar.hidden=YES;
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置背景颜色
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage"]]];
    //设置导航栏
    [self setNavigationBar];
    //添加视图
    [self addContentView];

}
//设置导航栏
-(void)setNavigationBar
{
    //设置导航栏的颜色
    self.navigationController.navigationBar.barTintColor=LIGHT_WHITE_COLOR;
    self.title=@"欢迎页";
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

//添加内容视图
-(void)addContentView
{
    //数组内存放的是图片
    NSArray *arr=[NSArray arrayWithObjects:@"yindao-1.1",@"yindao-1.2", nil];
    self.scrollView.frame=CGRectMake(0, 0, [UIUtils getWindowWidth], [UIUtils getWindowHeight]);
    self.scrollView.contentSize=CGSizeMake([UIUtils getWindowWidth]*arr.count, [UIUtils getWindowHeight]-64);
    self.scrollView.pagingEnabled=YES;
    for (int i=0; i<arr.count; i++) {
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake([UIUtils getWindowWidth]*i, 0, [UIUtils getWindowWidth], [UIUtils getWindowHeight]-64)];
        imageView.image=[UIImage imageNamed:arr[i]];
        [self.scrollView addSubview:imageView];
        
    }
    //滚动时是否水平显示滚动条
//    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    //分页显示
    [self.scrollView setPagingEnabled:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
