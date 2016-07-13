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
@property (nonatomic,strong) NSString * workstyle;

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
    
    AppShare;
    
    //设置背景颜色
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage"]]];
    
    //设置导航栏
    [self setNavigationBar];
    
    //加载数据
    app.workStyle = [[NSUserDefaults standardUserDefaults] stringForKey:@"style"];
    
    if (app.workStyle == nil) {
        
        [self loadData2];
        
    }else if ([app.workStyle isEqualToString:@"1"]){
        
        [self loadData];
        
    }else{
        
        [self loadData2];
    }
    
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
    AppShare;
    app.workStyle = @"2";
    
    //标准样式
    [[NSUserDefaults standardUserDefaults] setObject:app.workStyle forKey:@"style"];
    
    [self loadData2];
}

//切换成清新工作证
- (void)clever
{
    AppShare;
    //清新样式
    app.workStyle = @"1";
    
    //标准样式
    [[NSUserDefaults standardUserDefaults] setObject:app.workStyle forKey:@"style"];
    
    [self loadData];
}

//加载数据
- (void)loadData2//标准模式
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
        
        _resultDic=responseObject[@"result"];
        app.request=responseObject[@"response"];
        
        //隐藏HUD
        hudHide;
        
        arr=[NSArray arrayWithObjects:@"gongzuoz2",@"gongzuoz2", nil];
            
        workType;
    }];
   
}

- (void)loadData//清新模式
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
        
        _resultDic=responseObject[@"result"];
        app.request=responseObject[@"response"];
        
        //隐藏HUD
        hudHide;
        
        arr=[NSArray arrayWithObjects:@"gongzuoz",@"gongzuoz", nil];
        
        workType;
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
