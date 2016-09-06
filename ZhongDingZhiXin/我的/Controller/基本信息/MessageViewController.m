//
//  MessageViewController.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/10/26.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()<UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UITableViewDelegate,UINavigationControllerDelegate>
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
    
    MBProgressHUD * mbHud;
}

@property (weak, nonatomic) IBOutlet UIView *noneView;

@property (weak, nonatomic) IBOutlet UITableView *messageTableView;

@end

@implementation MessageViewController

//隐藏TabBar
-(void)viewWillAppear:(BOOL)animated{
    
//    NSString *string=APP_Font;
//    _fontLabel1.font=[UIFont systemFontOfSize:15*[string floatValue]];
//    _fontLabel2.font=[UIFont systemFontOfSize:15*[string floatValue]];
//    _fontLabel3.font=[UIFont systemFontOfSize:15*[string floatValue]];
//    _fontLabel4.font=[UIFont systemFontOfSize:15*[string floatValue]];
//    _fontLabel5.font=[UIFont systemFontOfSize:15*[string floatValue]];
//    _cell.detailTextLabel.font=[UIFont systemFontOfSize:15*[string floatValue]];
    
    self.tabBarController.tabBar.hidden=YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppShare;
    
    //设置背景颜色
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage"]]];
    
    //设置导航栏
    [self setNavigationBar];
    
    //添加视图
    [self addContentView];
    
    //初始化_noticeInfoArray
    if (!_messageArray) {
        _messageArray = [[NSMutableArray alloc] init];
    }
    
    _messageArray = app.messages;
    
    [self.messageTableView reloadData];

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
//    NSString *str=APP_Font;
//    if (!str){
//        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"change_font"];
//        [[NSUserDefaults standardUserDefaults]synchronize];
//    }

    self.messageTableView.backgroundColor=[UIColor clearColor];
    self.messageTableView.scrollEnabled =NO; //设置tableview 不能滚动
    self.messageTableView.tableFooterView=[[UIView alloc]init];//影藏多余的分割线
    
    _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 20, 50, 50)];
    _imageView.backgroundColor=[UIColor lightGrayColor];
    _imageView.layer.masksToBounds = YES;
    _imageView.layer.cornerRadius=25;
    
    NSData *data=[[NSUserDefaults standardUserDefaults]objectForKey:@"image"];
    
    if (!data) {
        _imageView.image=[UIImage imageNamed:@"touxiang.png"];
    }else{
        _imageView.image=[UIImage imageWithData:data];
    }

    [self.messageTableView addSubview:_imageView];
    
    //发送通知
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"image" object:nil];
    
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
    AppShare;
    static NSString *cellIdentifier=@"cellIdentifier";
        
    _cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!_cell) {
        
        _cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        _cell.selectionStyle = UITableViewCellSelectionStyleNone;

        if (indexPath.section==0) {
            
            if (indexPath.row==0) {
                _cell.detailTextLabel.font=[UIFont systemFontOfSize:15];
                _cell.detailTextLabel.text=@"设置头像";
                
            }else if (indexPath.row==1){
                _cell.detailTextLabel.font=[UIFont systemFontOfSize:15];
                _cell.detailTextLabel.text=app.name;
                
            }else if (indexPath.row==2){
                
                _cell.detailTextLabel.font=[UIFont systemFontOfSize:15];
                NSString * change = [app.mobilephone stringByReplacingCharactersInRange:NSMakeRange(3, 5) withString:@"*****"];
                _cell.detailTextLabel.text = change;
                
            }else{
                
                _cell.detailTextLabel.font=[UIFont systemFontOfSize:15];
                _cell.detailTextLabel.text=@"修改";
            }
        }
        if (indexPath.section==1) {
            
            if (indexPath.row==0) {
                
                _cell.detailTextLabel.font=[UIFont systemFontOfSize:15];
                _cell.detailTextLabel.text=app.sex;

            }else{
                
                _cell.detailTextLabel.font=[UIFont systemFontOfSize:15];
                _cell.detailTextLabel.text=app.from;
            }
        }
    }
    _cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    _cell.detailTextLabel.textColor=PASS_COLOR;
    _cell.detailTextLabel.font=[UIFont systemFontOfSize:13];
    return _cell;
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
    
    _imageView.image=[UIImage imageWithData:data];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            //创建对象
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择",@"拍照", nil];
            
            //在视图上展示
            [actionSheet showInView:self.view];
        }
        if (indexPath.row == 3) {
            
            PasswordViewController * pass = [[PasswordViewController alloc] init];
            
            [self.navigationController pushViewController:pass animated:YES];
        }
    }
    
}

@end
