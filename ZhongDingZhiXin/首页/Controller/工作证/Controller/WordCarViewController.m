//
//  WordCarViewController.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/10/14.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "WordCarViewController.h"

@interface WordCarViewController ()
{
    NSMutableArray *_wordCarInfoArray;
    MBProgressHUD * mbHud;//提示
    NSDictionary *_resultDic;
    NSString *_str;
    NSArray *arr;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation WordCarViewController

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
    //加载数据
    [self loadData];
    

    
    //标准
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(standard) name:@"standard" object:nil];
    
    //清新
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clever) name:@"clever" object:nil];
}

//设置导航栏
-(void)setNavigationBar
{
    //设置导航栏的颜色
    NavBarType(@"工作证");
    
    //为导航栏添加左侧按钮
    leftButton;
    
    //为导航栏添加右侧按钮
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake([UIUtils getWindowWidth]-25, 0, 20, 20);
    [rightBtn setImage:[UIImage imageNamed:@"shezhi2"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(settingButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

-(void)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

//设置按钮
- (void)settingButton
{
    FDAlertView *alert = [[FDAlertView alloc] init];
    ContentView *contentView = [[NSBundle mainBundle] loadNibNamed:@"ContentView" owner:nil options:nil].lastObject;
    contentView.frame = CGRectMake(0, 0, 270, 180);
    alert.contentView = contentView;
    [alert show];
}

//切换成标准工作证
- (void)standard
{
    [self loadData2];
}

//切换成清新工作证
- (void)clever
{
    [self loadData];
}

//添加内容视图
-(void)addContentView
{
    AppShare;
    //数组内存放的是图片
     arr=[NSArray arrayWithObjects:@"gongzuoz",@"gongzuoz", nil];
    self.scrollView.frame=CGRectMake(0, 0, [UIUtils getWindowWidth], [UIUtils getWindowHeight]);
    self.scrollView.contentSize=CGSizeMake([UIUtils getWindowWidth]*arr.count, [UIUtils getWindowHeight]-64);
    self.scrollView.pagingEnabled=YES;
    for (int i=0; i<arr.count; i++) {
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake([UIUtils getWindowWidth]*i, 0, [UIUtils getWindowWidth], [UIUtils getWindowHeight]-64)];
        imageView.image=[UIImage imageNamed:arr[i]];
        [self.scrollView addSubview:imageView];
        if (i==0) {
            UIImageView *AImageView=[[UIImageView alloc]initWithFrame:CGRectMake(([UIUtils getWindowWidth]-150)/2, ([UIUtils getWindowHeight]-350)/2, 150, 150)];
            AImageView.backgroundColor=[UIColor blueColor];
            AImageView.layer.cornerRadius=75;
            AImageView.image=[UIImage imageNamed:@"touxiang"];
            [imageView addSubview:AImageView];
            
            UILabel *nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(([UIUtils getWindowWidth]-200)/2, CGRectGetMaxY(AImageView.frame)+10, 60, 20)];
            nameLabel.text=@"姓名：";
            nameLabel.textColor=[UIColor blueColor];
            [imageView addSubview:nameLabel];
            
            UILabel *NLabel=[[UILabel alloc]initWithFrame:CGRectMake(([UIUtils getWindowWidth]-200)/2, CGRectGetMaxY(nameLabel.frame), 60, 15)];
            NLabel.text=@"Name";
            NLabel.textColor=[UIColor blueColor];
            [imageView addSubview:NLabel];
            
            UILabel *XMLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame)+10, CGRectGetMaxY(AImageView.frame)+10, 100, 35)];
            NSString *strMark=[AESCrypt decrypt:_resultDic[@"jobphone"] password:app.loginKeycode];
            XMLabel.text=strMark;
            XMLabel.textColor=[UIColor blueColor];
            XMLabel.textAlignment=NSTextAlignmentCenter;
            [imageView addSubview:XMLabel];
            
            UILabel *line1=[[UILabel alloc]initWithFrame:CGRectMake(([UIUtils getWindowWidth]-200)/2, CGRectGetMaxY(NLabel.frame)+2, 200, 1)];
            line1.backgroundColor=[UIColor blueColor];
            [imageView addSubview:line1];
            
            UILabel *postLabel=[[UILabel alloc]initWithFrame:CGRectMake(([UIUtils getWindowWidth]-200)/2, CGRectGetMaxY(line1.frame)+10, 60, 20)];
            postLabel.text=@"职务：";
            postLabel.textColor=[UIColor blueColor];
            [imageView addSubview:postLabel];
            
            UILabel *PLabel=[[UILabel alloc]initWithFrame:CGRectMake(([UIUtils getWindowWidth]-200)/2, CGRectGetMaxY(postLabel.frame), 60, 15)];
            PLabel.text=@"Post";
            PLabel.textColor=[UIColor blueColor];
            [imageView addSubview:PLabel];
            
            UILabel *ZWLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(postLabel.frame)+10, CGRectGetMaxY(line1.frame)+10, 100, 35)];
            ZWLabel.text=@"营销经理";
            ZWLabel.textColor=[UIColor blueColor];
            ZWLabel.textAlignment=NSTextAlignmentCenter;
            [imageView addSubview:ZWLabel];

            
            UILabel *line2=[[UILabel alloc]initWithFrame:CGRectMake(([UIUtils getWindowWidth]-200)/2, CGRectGetMaxY(PLabel.frame)+2, 200, 1)];
            line2.backgroundColor=[UIColor blueColor];
            [imageView addSubview:line2];
            
            UILabel *noLabel=[[UILabel alloc]initWithFrame:CGRectMake(([UIUtils getWindowWidth]-200)/2, CGRectGetMaxY(line2.frame)+10, 60, 20)];
            noLabel.text=@"编号：";
            noLabel.textColor=[UIColor blueColor];
            [imageView addSubview:noLabel];
            
            UILabel *NoLabel=[[UILabel alloc]initWithFrame:CGRectMake(([UIUtils getWindowWidth]-200)/2, CGRectGetMaxY(noLabel.frame), 60, 20)];
            NoLabel.text=@"No.";
            NoLabel.textColor=[UIColor blueColor];
            [imageView addSubview:NoLabel];
            
            UILabel *BHLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(noLabel.frame)+10, CGRectGetMinY(noLabel.frame), 100, 35)];
            BHLabel.text=@"0322";
            BHLabel.textColor=[UIColor blueColor];
            BHLabel.textAlignment=NSTextAlignmentCenter;
            [imageView addSubview:BHLabel];
            
            UILabel *line3=[[UILabel alloc]initWithFrame:CGRectMake(([UIUtils getWindowWidth]-200)/2, CGRectGetMaxY(BHLabel.frame)+3, 200, 1)];
            line3.backgroundColor=[UIColor blueColor];
            [imageView addSubview:line3];

        }
        
        if (i==1) {
            UIImageView *photoImageView=[[UIImageView alloc]initWithFrame:CGRectMake(([UIUtils getWindowWidth]-200)/2, ([UIUtils getWindowHeight]-300)/2, 200, 200)];
            [imageView addSubview:photoImageView];
                        
            UIImage *qrcode = [self createNonInterpolatedUIImageFormCIImage:[self createQRForString:@"http://blog.yourtion.com"] withSize:250.0f];
            UIImage *customQrcode = [self imageBlackToTransparent:qrcode withRed:60.0f andGreen:74.0f andBlue:89.0f];
            photoImageView.image = customQrcode;
            // set shadow
            photoImageView.layer.shadowOffset = CGSizeMake(0, 2);
            photoImageView.layer.shadowRadius = 2;
            photoImageView.layer.shadowColor = [UIColor blackColor].CGColor;
            photoImageView.layer.shadowOpacity = 0.5;
        }
    }
    //滚动时是否水平显示滚动条
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    //分页显示
    [self.scrollView setPagingEnabled:YES];

}

-(void)addContentView1
{
    AppShare;
    //数组内存放的是图片
    arr=[NSArray arrayWithObjects:@"gongzuoz2",@"gongzuoz2", nil];
    self.scrollView.frame=CGRectMake(0, 0, [UIUtils getWindowWidth], [UIUtils getWindowHeight]);
    self.scrollView.contentSize=CGSizeMake([UIUtils getWindowWidth]*arr.count, [UIUtils getWindowHeight]-64);
    self.scrollView.pagingEnabled=YES;
    for (int i=0; i<arr.count; i++) {
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake([UIUtils getWindowWidth]*i, 0, [UIUtils getWindowWidth], [UIUtils getWindowHeight]-64)];
        imageView.image=[UIImage imageNamed:arr[i]];
        [self.scrollView addSubview:imageView];
        if (i==0) {
            UIImageView *AImageView=[[UIImageView alloc]initWithFrame:CGRectMake(([UIUtils getWindowWidth]-150)/2, ([UIUtils getWindowHeight]-350)/2, 150, 150)];
            AImageView.backgroundColor=[UIColor blueColor];
            AImageView.layer.cornerRadius=75;
            AImageView.image=[UIImage imageNamed:@"touxiang"];
            [imageView addSubview:AImageView];
            
            UILabel *nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(([UIUtils getWindowWidth]-200)/2, CGRectGetMaxY(AImageView.frame)+10, 60, 20)];
            nameLabel.text=@"姓名：";
            nameLabel.textColor=[UIColor blueColor];
            [imageView addSubview:nameLabel];
            
            UILabel *NLabel=[[UILabel alloc]initWithFrame:CGRectMake(([UIUtils getWindowWidth]-200)/2, CGRectGetMaxY(nameLabel.frame), 60, 15)];
            NLabel.text=@"Name";
            NLabel.textColor=[UIColor blueColor];
            [imageView addSubview:NLabel];
            
            UILabel *XMLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame)+10, CGRectGetMaxY(AImageView.frame)+10, 100, 35)];
            NSString *strMark=[AESCrypt decrypt:_resultDic[@"jobphone"] password:app.loginKeycode];
            XMLabel.text=strMark;
            XMLabel.textColor=[UIColor blueColor];
            XMLabel.textAlignment=NSTextAlignmentCenter;
            [imageView addSubview:XMLabel];
            
            UILabel *line1=[[UILabel alloc]initWithFrame:CGRectMake(([UIUtils getWindowWidth]-200)/2, CGRectGetMaxY(NLabel.frame)+2, 200, 1)];
            line1.backgroundColor=[UIColor blueColor];
            [imageView addSubview:line1];
            
            UILabel *postLabel=[[UILabel alloc]initWithFrame:CGRectMake(([UIUtils getWindowWidth]-200)/2, CGRectGetMaxY(line1.frame)+10, 60, 20)];
            postLabel.text=@"职务：";
            postLabel.textColor=[UIColor blueColor];
            [imageView addSubview:postLabel];
            
            UILabel *PLabel=[[UILabel alloc]initWithFrame:CGRectMake(([UIUtils getWindowWidth]-200)/2, CGRectGetMaxY(postLabel.frame), 60, 15)];
            PLabel.text=@"Post";
            PLabel.textColor=[UIColor blueColor];
            [imageView addSubview:PLabel];
            
            UILabel *ZWLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(postLabel.frame)+10, CGRectGetMaxY(line1.frame)+10, 100, 35)];
            ZWLabel.text=@"营销经理";
            ZWLabel.textColor=[UIColor blueColor];
            ZWLabel.textAlignment=NSTextAlignmentCenter;
            [imageView addSubview:ZWLabel];
            
            
            UILabel *line2=[[UILabel alloc]initWithFrame:CGRectMake(([UIUtils getWindowWidth]-200)/2, CGRectGetMaxY(PLabel.frame)+2, 200, 1)];
            line2.backgroundColor=[UIColor blueColor];
            [imageView addSubview:line2];
            
            UILabel *noLabel=[[UILabel alloc]initWithFrame:CGRectMake(([UIUtils getWindowWidth]-200)/2, CGRectGetMaxY(line2.frame)+10, 60, 20)];
            noLabel.text=@"编号：";
            noLabel.textColor=[UIColor blueColor];
            [imageView addSubview:noLabel];
            
            UILabel *NoLabel=[[UILabel alloc]initWithFrame:CGRectMake(([UIUtils getWindowWidth]-200)/2, CGRectGetMaxY(noLabel.frame), 60, 20)];
            NoLabel.text=@"No.";
            NoLabel.textColor=[UIColor blueColor];
            [imageView addSubview:NoLabel];
            
            UILabel *BHLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(noLabel.frame)+10, CGRectGetMinY(noLabel.frame), 100, 35)];
            BHLabel.text=@"0322";
            BHLabel.textColor=[UIColor blueColor];
            BHLabel.textAlignment=NSTextAlignmentCenter;
            [imageView addSubview:BHLabel];
            
            UILabel *line3=[[UILabel alloc]initWithFrame:CGRectMake(([UIUtils getWindowWidth]-200)/2, CGRectGetMaxY(BHLabel.frame)+3, 200, 1)];
            line3.backgroundColor=[UIColor blueColor];
            [imageView addSubview:line3];
            
        }
        
        if (i==1) {
            UIImageView *photoImageView=[[UIImageView alloc]initWithFrame:CGRectMake(([UIUtils getWindowWidth]-200)/2, ([UIUtils getWindowHeight]-300)/2, 200, 200)];
            [imageView addSubview:photoImageView];
            
            UIImage *qrcode = [self createNonInterpolatedUIImageFormCIImage:[self createQRForString:@"http://blog.yourtion.com"] withSize:250.0f];
            UIImage *customQrcode = [self imageBlackToTransparent:qrcode withRed:60.0f andGreen:74.0f andBlue:89.0f];
            photoImageView.image = customQrcode;
            // set shadow
            photoImageView.layer.shadowOffset = CGSizeMake(0, 2);
            photoImageView.layer.shadowRadius = 2;
            photoImageView.layer.shadowColor = [UIColor blackColor].CGColor;
            photoImageView.layer.shadowOpacity = 0.5;
        }
    }
    //滚动时是否水平显示滚动条
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    //分页显示
    [self.scrollView setPagingEnabled:YES];
    
}

//加载数据
- (void)loadData
{
    //显示提示
    mbHUDinit;
    
    AppShare;
    //初始化_noticeInfoArray
    if (!_wordCarInfoArray) {
        _wordCarInfoArray = [[NSMutableArray alloc] init];
    }
    
    //初始化请求（同时也创建了一个线程）
    [[HTTPSessionManager sharedManager] POST:ZUOZHENG_URL parameters:Dic result:^(id responseObject, NSError *error) {
        
        NSLog(@"\n工作证请求信息:%@",responseObject);
        _resultDic=responseObject[@"result"];
        app.request=responseObject[@"response"];
        
        //隐藏HUD
        hudHide;
        
        //添加内容视图
        [self addContentView];

    }];
   
}

- (void)loadData2
{
    //显示提示
    mbHUDinit;
    
    AppShare;
    //初始化_noticeInfoArray
    if (!_wordCarInfoArray) {
        _wordCarInfoArray = [[NSMutableArray alloc] init];
    }
    
    //初始化请求（同时也创建了一个线程）
    [[HTTPSessionManager sharedManager] POST:ZUOZHENG_URL parameters:Dic result:^(id responseObject, NSError *error) {
        
        NSLog(@"\n工作证请求信息:%@",responseObject);
        _resultDic=responseObject[@"result"];
        app.request=responseObject[@"response"];
        
        //隐藏HUD
        hudHide;
        
        //添加内容视图
        [self addContentView1];
        
    }];
    
}

#pragma mark - InterpolatedUIImage
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    //创建图片
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);

    //保存图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

#pragma mark - QRCodeGenerator
- (CIImage *)createQRForString:(NSString *)qrString {
   
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    
    return qrFilter.outputImage;
}

#pragma mark - imageToTransparent
void ProviderReleaseData (void *info, const void *data, size_t size){
    free((void*)data);
}
- (UIImage*)imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue{
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t      bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    // create context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    // traverse pixe
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++){
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900){
            // change color
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red; //0~255
            ptr[2] = green;
            ptr[1] = blue;
        }else{
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    // context to image
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    // release
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return resultUIImage;
}

@end
