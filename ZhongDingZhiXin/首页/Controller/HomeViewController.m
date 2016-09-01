//
//  HomeViewController.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/9/24.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate>
{
    TaskViewController *_taskVC;
    WordCarViewController *_wordCarVC;
    MBProgressHUD * mbHud;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray * noticeInfoArray;

@end

@implementation HomeViewController

//显示TabBar
-(void)viewWillAppear:(BOOL)animated{
    
    [self setHidesBottomBarWhenPushed:NO];
    self.tabBarController.tabBar.hidden=NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppShare;
    
    //设置背景颜色
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage"]]];
    
    //设置导航栏
    [self setNavigationBar];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.scrollEnabled = NO; //设置tableview滚动
    self.tableView.tableFooterView = [[UIView alloc]init];//影藏多余的分割线
    
    //初始化_noticeInfoArray
    if (!_noticeInfoArray) {
        _noticeInfoArray = [[NSMutableArray alloc] init];
    }
    
    for (NSDictionary *dictionary in app.firstArray) {
        
        NoticeInfo * noticeInfo = [[NoticeInfo alloc] initWithDictionary:dictionary];
        
        [_noticeInfoArray addObject:noticeInfo];
    }
    
    [self.tableView reloadData];
    
}

//设置导航栏
-(void)setNavigationBar
{
    //设置导航栏的颜色
    NavBarType(@"首页");
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AppShare;
    if (indexPath.row==0) {
        
        TitleViewCell *cell=[TitleViewCell cellWithTableView:self.tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameLable.text = app.name;
        
        if (app.firAddress.length == 0) {
            
            cell.addressLabel.text = @"最近登录信息：暂无";

        }else{
            cell.addressLabel.text = [NSString stringWithFormat:@"最近登录信息：%@",app.firAddress];
        }
        cell.iconView.layer.masksToBounds = YES;
        cell.iconView.layer.cornerRadius=40;
        
        NSData *data=[[NSUserDefaults standardUserDefaults]objectForKey:@"image"];
        
        if (!data) {
            cell.iconView.image = [UIImage imageNamed:@"touxiang"];
        }else{
            
            cell.iconView.image=[UIImage imageWithData:data];
        }
        
        return cell;
    }
    if (indexPath.row==1) {
        
        NoticeViewCell *cell=[NoticeViewCell cellWithTableView:self.tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
        return cell;
    }
    if (indexPath.row==2) {
        
        ListViewCell *cell=[ListViewCell cellWithTableView:self.tableView];
        if (_noticeInfoArray.count>0) {
            
            NoticeInfo *noticeInfo = _noticeInfoArray[0];
            
            NSString *strTitle = [AESCrypt decrypt:noticeInfo.title password:app.loginKeycode];
            NSString *strMark  = [AESCrypt decrypt:noticeInfo.mark password:app.loginKeycode];
            cell.titleName.text=strTitle;
            NSString * str = strMark;
            timeCover;
            cell.dateLabel.text = currentDateStr;
        }
        
        return cell;
    }
    if (indexPath.row==3) {
        
        ListViewCell *cell=[ListViewCell cellWithTableView:self.tableView];
        
        if (_noticeInfoArray.count>1) {
            NoticeInfo *noticeInfo = _noticeInfoArray[1];
           
            NSString *strTitle = [AESCrypt decrypt:noticeInfo.title password:app.loginKeycode];
            NSString *strMark  = [AESCrypt decrypt:noticeInfo.mark password:app.loginKeycode];
            cell.titleName.text=strTitle;
            NSString * str = strMark;
            timeCover;
            cell.dateLabel.text = currentDateStr;
        }
        return cell;
    }
    if (indexPath.row==4) {
        
        ListViewCell *cell=[ListViewCell cellWithTableView:self.tableView];
        if (_noticeInfoArray.count>2) {
            
            NoticeInfo *noticeInfo = _noticeInfoArray[2];
            NSString *strTitle = [AESCrypt decrypt:noticeInfo.title password:app.loginKeycode];
            NSString *strMark  = [AESCrypt decrypt:noticeInfo.mark password:app.loginKeycode];
            cell.titleName.text=strTitle;
            NSString * str = strMark;
            timeCover;
            cell.dateLabel.text = currentDateStr;
        }
        
        return cell;
    }
    if (indexPath.row==5) {
        
        ButtonViewCell *cell=[ButtonViewCell cellWithTableView:self.tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.taskButton addTarget:self action:@selector(taskButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.wordCardButton addTarget:self action:@selector(wordCardButtonClick) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
     return nil;
}

-(void)taskButtonClick
{
    AFNetworkReachabilityManager * mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr startMonitoring];
    
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status != 0) {
            
            _taskVC =[[TaskViewController alloc] initWithNibName:@"TaskViewController" bundle:nil];
            
            [self.navigationController pushViewController:_taskVC animated:YES];
            
        }else
        {
            noWebhud;
        }
        
    }];
    
}     

-(void)wordCardButtonClick
{
    AFNetworkReachabilityManager * mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr startMonitoring];
    
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status != 0) {
            
            _wordCarVC =[[WordCarViewController alloc] initWithNibName:@"WordCarViewController" bundle:nil];
            //隐藏tabBar
            [self setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:_wordCarVC animated:YES];
            
        }else
        {
            noWebhud;
        }
        
    }];
    
}

#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 150;
    }
    if (indexPath.row==1){
        return 70;
    }
    if (indexPath.row==2){
        return 50;
    }
    if (indexPath.row==3){
        return 50;
    }
    if (indexPath.row==4){
        return 50;
    }
        return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        //创建对象
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择",@"拍照", nil];
        
        //在视图上展示
        [actionSheet showInView:self.view];
    }
    if (indexPath.row==1) {
        AFNetworkReachabilityManager * mgr = [AFNetworkReachabilityManager sharedManager];
        [mgr startMonitoring];
        
        [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            if (status != 0) {
                
                NoticeViewController *companyVC=[[NoticeViewController alloc]init];
                [self.navigationController pushViewController:companyVC animated:YES];
                
            }else
            {
                noWebhud;
            }
            
        }];

    }
    if (indexPath.row==2) {
        AfficheViewController *afficheVC=[[AfficheViewController alloc]init];
        if (_noticeInfoArray.count>0) {
           afficheVC.noticeInfo=_noticeInfoArray[0];
        }
        [self.navigationController pushViewController:afficheVC animated:YES];
    }
    if (indexPath.row==3) {
        AfficheViewController *afficheVC=[[AfficheViewController alloc]init];
        if (_noticeInfoArray.count>1) {
            afficheVC.noticeInfo=_noticeInfoArray[1];
        }
        [self.navigationController pushViewController:afficheVC animated:YES];
    }
    if (indexPath.row==4) {
        AfficheViewController *afficheVC=[[AfficheViewController alloc]init];
        if (_noticeInfoArray.count>2) {
            afficheVC.noticeInfo=_noticeInfoArray[2];
        }
        [self.navigationController pushViewController:afficheVC animated:YES];
    }
}

#pragma mark UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    // 相册 0 拍照 1
    switch (buttonIndex) {
        case 0:
            //从相册中读取
            [self readImageFromAlbum];
            break;
        case 1:
            //拍照
            [self readImageFromCamera];
            break;
        default:
            break;
    }
}

//图片完成之后处理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    
    NSData *data;
    
    //判断图片是不是png格式的文件
    if (UIImagePNGRepresentation(image)) {
        
        //返回为png图像。
        data = UIImagePNGRepresentation(image);
        
    }else {
        
        //返回为JPEG图像。
        data = UIImageJPEGRepresentation(image, 1.0);
    }
    
    TitleViewCell * cell = [[TitleViewCell alloc] init];
    cell.iconView.image = [UIImage imageWithData:data];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"image"];
    
    //结束操作
    [self dismissViewControllerAnimated:YES completion:nil];
}

//从相册中读取
- (void)readImageFromAlbum {
    
    //创建对象
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    //（选择类型）表示仅仅从相册中选取照片
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    //设置在相册选完照片后，是否跳到编辑模式进行图片剪裁。(允许用户编辑)
    imagePicker.allowsEditing = YES;
    //显示相册
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)readImageFromCamera {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        //允许用户编辑
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    } else {
        
        //弹出窗口响应点击事件
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:@"未检测到摄像头" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }]];
        [self presentViewController:alert animated:YES completion:^{
        }];
    }
}

@end
