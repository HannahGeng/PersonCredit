//
//  MessageViewController.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/10/26.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView *_imageView;
    UILabel *_fontLabel1;
    UILabel *_fontLabel2;
    UILabel *_fontLabel3;
    UILabel *_fontLabel4;
    UILabel *_fontLabel5;

    NSMutableArray *_messageArray;
    UITableViewCell *_cell;
    NSString * _avatar;
    NSString * _from;
    NSString * _age;
    NSString * _realname;
    NSString * _education;
    NSString * _sex;
    NSString * _state;
}

@property (weak, nonatomic) IBOutlet UITableView *messageTableView;
@end

@implementation MessageViewController

//隐藏TabBar
-(void)viewWillAppear:(BOOL)animated{
    
    NSString *string=APP_Font;
    _fontLabel1.font=[UIFont systemFontOfSize:15*[string floatValue]];
    _fontLabel2.font=[UIFont systemFontOfSize:15*[string floatValue]];
    _fontLabel3.font=[UIFont systemFontOfSize:15*[string floatValue]];
    _fontLabel4.font=[UIFont systemFontOfSize:15*[string floatValue]];
    _fontLabel5.font=[UIFont systemFontOfSize:15*[string floatValue]];
    _cell.detailTextLabel.font=[UIFont systemFontOfSize:15*[string floatValue]];
    self.tabBarController.tabBar.hidden=YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置背景颜色
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage"]]];
    //设置导航栏
    [self setNavigationBar];
    //添加视图
    [self addContentView];
    
    //加载数据
    [self performSelectorInBackground:@selector(loadData) withObject:nil];
}

//设置导航栏
-(void)setNavigationBar
{
    NavBarType(@"个人信息");
    
    //为导航栏添加左侧按钮
    leftButton;
}
//添加内容视图
-(void)addContentView
{
    NSString *str=APP_Font;
    if (!str){
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"change_font"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }

    self.messageTableView.backgroundColor=[UIColor clearColor];
    self.messageTableView.scrollEnabled =NO; //设置tableview 不能滚动
    self.messageTableView.tableFooterView=[[UIView alloc]init];//影藏多余的分割线
    
    _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 20, 50, 50)];
    _imageView.backgroundColor=[UIColor lightGrayColor];
    _imageView.layer.cornerRadius=5;
    [self.messageTableView addSubview:_imageView];
    
    _fontLabel1=[[UILabel alloc]initWithFrame:CGRectMake(15, 90, 50, 30)];
    _fontLabel1.text=@"姓名";
    _fontLabel1.font=[UIFont systemFontOfSize:15];
    [self.messageTableView addSubview:_fontLabel1];
    
    _fontLabel2=[[UILabel alloc]initWithFrame:CGRectMake(15, 140, 70, 30)];
    _fontLabel2.text=@"手机号";
    _fontLabel2.font=[UIFont systemFontOfSize:15];
    [self.messageTableView addSubview:_fontLabel2];
    
    _fontLabel3=[[UILabel alloc]initWithFrame:CGRectMake(15, 190, 130, 30)];
    _fontLabel3.text=@"密码";
    _fontLabel3.font=[UIFont systemFontOfSize:15];
    [self.messageTableView addSubview:_fontLabel3];
    
    _fontLabel4=[[UILabel alloc]initWithFrame:CGRectMake(15, 250, 50, 30)];
    _fontLabel4.text=@"性别";
    _fontLabel4.font=[UIFont systemFontOfSize:15];
    [self.messageTableView addSubview:_fontLabel4];
    
    _fontLabel5=[[UILabel alloc]initWithFrame:CGRectMake(15, 300, 50, 30)];
    _fontLabel5.text=@"地区";
    _fontLabel5.font=[UIFont systemFontOfSize:15];
    [self.messageTableView addSubview:_fontLabel5];
    
    
}
-(void)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

//加载数据
- (void)loadData
{
    AppShare;
    //初始化_noticeInfoArray
    if (!_messageArray) {
        _messageArray = [[NSMutableArray alloc] init];
    }
    
    //初始化请求（同时也创建了一个线程）
    [[HTTPSessionManager sharedManager] POST:JUCHU_URL parameters:Dic result:^(id responseObject, NSError *error) {
        
        NSLog(@"基本信息:%@",responseObject);
        NSLog(@"\n密码:%@",app.loginKeycode);
        
        _avatar = [AESCrypt decrypt:responseObject[@"result"][@"avatar"] password:app.loginKeycode];
        _from = [AESCrypt decrypt:responseObject[@"result"][@"from"] password:app.loginKeycode];
        _age = [AESCrypt decrypt:responseObject[@"result"][@"age"] password:app.loginKeycode];
        _realname = [AESCrypt decrypt:responseObject[@"reault"][@"realname"] password:app.loginKeycode];
        _sex = [AESCrypt decrypt:responseObject[@"result"][@"sex"] password:app.loginKeycode];
        _state = [AESCrypt decrypt:responseObject[@"result"][@"state"] password:app.loginKeycode];
        
        NSArray *array = (NSArray *)responseObject[@"result"];
        if (array.count != 0) {
            
            app.request=responseObject[@"response"];
        
        }
        [self.messageTableView reloadData];
        
    }];
        
}

#pragma mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 4;
    }else{
        return 2;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *cellIdentifier=@"cellIdentifier";
    
    _cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!_cell) {
        
        _cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        
        if (indexPath.section==0) {
            if (indexPath.row==0) {
                _cell.detailTextLabel.font=[UIFont systemFontOfSize:15];
                _cell.detailTextLabel.text=@"设置头像";
            }else if (indexPath.row==1){
                _cell.detailTextLabel.font=[UIFont systemFontOfSize:15];
                _cell.detailTextLabel.text=_realname;
                
                NSLog(@"cell-realname:%@",_realname);
                
            }else if (indexPath.row==2){
                _cell.detailTextLabel.font=[UIFont systemFontOfSize:15];
                _cell.detailTextLabel.text=@"修改";
                
            }else{
                _cell.detailTextLabel.font=[UIFont systemFontOfSize:15];
                _cell.detailTextLabel.text=@"修改";
            }
        }
        if (indexPath.section==1) {
            if (indexPath.row==0) {
                _cell.detailTextLabel.font=[UIFont systemFontOfSize:15];
                _cell.detailTextLabel.text=_sex;

            }else{
                _cell.detailTextLabel.font=[UIFont systemFontOfSize:15];
                _cell.detailTextLabel.text=_from;
            }
        }
    }
    _cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    _cell.detailTextLabel.textColor=PASS_COLOR;
    _cell.detailTextLabel.font=[UIFont systemFontOfSize:13];
    return _cell;
}

#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 70;
        }else{
            return 50;
        }
    }else{
        return 50;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

@end
