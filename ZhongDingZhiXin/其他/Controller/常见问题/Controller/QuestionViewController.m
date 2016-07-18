//
//  QuestionViewController.m
//  个人职业信用
//
//  Created by zdzx-008 on 16/7/18.
//  Copyright © 2016年 北京职信鼎程. All rights reserved.
//

#import "QuestionViewController.h"

@interface QuestionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *questionTableView;
@property (nonatomic,strong)NSMutableArray * questions;

@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NavBarType(@"常见问题");
    leftButton;
    [self loadQuestion];
    
}

- (void)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadQuestion
{
    AppShare;

    [[HTTPSessionManager sharedManager] POST:WENTI_URL parameters:Dic result:^(id responseObject, NSError *error) {
        
        NSArray * questionArr = (NSArray *)responseObject[@"result"];
        
        if (questionArr != 0) {
            
            app.request = responseObject[@"response"];
            
            for (NSDictionary *dict in questionArr) {
                QuestionModel  * question = [QuestionModel questionWithDic:dict];
                [self.questions addObject:question];
            }
        }
        
        [self.questionTableView reloadData];
            
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.questions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuestionCell * quest = [QuestionCell cellWithTableView:tableView];
    
    quest.questmodel = self.questions[indexPath.row];
    
    return quest;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

@end
