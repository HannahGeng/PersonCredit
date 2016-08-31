//
//  QuestionViewController.m
//  个人职业信用
//
//  Created by zdzx-008 on 16/7/18.
//  Copyright © 2016年 北京职信鼎程. All rights reserved.
//

#import "QuestionViewController.h"

@interface QuestionViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    MBProgressHUD * mbHud;
}
@property (weak, nonatomic) IBOutlet UITableView *questionTableView;
@property (nonatomic,strong)NSMutableArray * questions;

@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NavBarType(@"常见问题");
    leftButton;
    [self loadQuestion];
    mbHUDinit;
}

- (void)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadQuestion
{
    AppShare;

    [[HTTPSessionManager sharedManager] POST:WENTI_URL parameters:Dic result:^(id responseObject, NSError *error) {
        
        NSMutableArray * questionArr = responseObject[@"result"];
        
        NSLog(@"问题数组:%@",questionArr);
        app.request = responseObject[@"response"];
        
        NSMutableArray * questionM = [NSMutableArray array];
        for (NSDictionary * dic in questionArr) {
            QuestionModel * model = [[QuestionModel alloc] initWithDic:dic];
            
            [questionM addObject:model];
        }
        
        self.questions = questionM;
        
        app.questionArray = questionArr;
        
        self.questionTableView.hidden = NO;
        
        [self.questionTableView reloadData];
        
        hudHide;
            
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.questions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuestionCell * quest = [QuestionCell cellWithTableView:tableView];
    quest.selectionStyle = UITableViewCellSelectionStyleNone;
    quest.questmodel = self.questions[indexPath.row];
    
    return quest;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AfficheViewController * aff = [[AfficheViewController alloc] init];
    
    [self.navigationController pushViewController:aff animated:YES];
    
    AppShare;
    app.index = indexPath.row;
}

@end
