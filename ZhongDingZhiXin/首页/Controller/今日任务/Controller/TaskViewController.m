//
//  TaskViewController.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/10/14.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "TaskViewController.h"//系统自带地图框架
#import "XMGAnno.h"

@interface TaskViewController ()<MKMapViewDelegate, CLLocationManagerDelegate,MKAnnotation>
{
    //地图View
    MKMapView * _mapView;
    //定位管理器
    CLLocationManager *manager;
    CLLocationCoordinate2D coordinate;
    int curPage;
    TaskView *_taskView;
    NSString *_cityName;   // 检索城市名
    NSString *_keyWord;    // 检索关键字
    int currentPage;       //  当前页
    MBProgressHUD * mbHud;
    CLPlacemark * placemark;
}
//poi结果信息集合
@property (retain,nonatomic) NSMutableArray *poiResultArray;
@property (weak, nonatomic) IBOutlet UILabel *addressText;
//年月日
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
//时分
@property (weak, nonatomic) IBOutlet UILabel *detailTimeLabel;
@property (nonatomic, strong) CLGeocoder *geoC;
@property (weak, nonatomic) IBOutlet UIButton *nearButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@end

@implementation TaskViewController
- (CLGeocoder *)geoC
{
    if (!_geoC) {
        _geoC = [[CLGeocoder alloc] init];
    }
    return _geoC;
}

//隐藏TabBar
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //地图View
    _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], 370)];
    [self.view addSubview:_mapView];
    
    //设置代理
    _mapView.delegate = self;
    
    //设置地图类型
    _mapView.mapType = MKMapTypeStandard;
    
    //设置中心坐标
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(22.552377, 114.082450) animated:YES];
    
    //是否允许缩放
    _mapView.zoomEnabled = YES;
    
    //是否允许移动
    _mapView.scrollEnabled = YES;
    
    //是否允许旋转
    _mapView.rotateEnabled = NO;
    
    //是否显示建筑物
    _mapView.showsBuildings = YES;
    
    //设置是否允许显示用户位置
    _mapView.showsUserLocation = YES;
    
    //创建定位管理器
    manager = [[CLLocationManager alloc] init];
    
    //iOS8定位,需要加上以下代码
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        [manager requestAlwaysAuthorization]; //总是定位
        [manager requestWhenInUseAuthorization]; //在使用期间定位
    }
    
    //设置代理, 通过代理方法接收坐标
    manager.delegate = self;
    
    //开启定位
    [manager startUpdatingLocation];
    
    //设置背景颜色
    [self.view setBackgroundColor:[UIColor whiteColor]];
    //设置导航栏
    [self setNavigationBar];
    
    //添加内容视图
    [self addContentView];
    
}
//设置导航栏
-(void)setNavigationBar
{
    //设置导航栏的颜色
    NavBarType(@"今日任务");
    
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
    [_mapView addSubview:_nearButton];
    [_mapView addSubview:_confirmButton];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(addName:)
                                                 name:@"add_name" object:nil];
    
    //时间戳
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter = [[NSDateFormatter alloc] init];
    NSDateFormatter  *dateformatter2 = [[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY/MM/dd"];
    [dateformatter2 setDateFormat:@"hh:mm"];
    
    NSString * detailStr = [dateformatter2 stringFromDate:senddate];
    NSString * timeStr = [dateformatter stringFromDate:senddate];
    
    self.timeLabel.text = timeStr;
    self.detailTimeLabel.text = detailStr;

}

//定位成功
-(void)locationManager:(CLLocationManager *)manager1 didUpdateLocations:(NSArray *)locations
{
    NSLog(@"定位成功!");
    
    //位置信息
    CLLocation *location = [locations firstObject];
    
    //定位到的坐标
    coordinate = location.coordinate;
    NSLog(@"(%lf, %lf)", coordinate.latitude, coordinate.longitude);
    
    //    设置缩放
    MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.03);
    
    //    b) 设置区域
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);
    
    //    c) 显示区域
    _mapView.region = region;

    //反地理编码(逆地理编码) : 把位置信息转换成地址信息
    //地理编码 : 把地址信息转换成位置信息
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //反地理编码
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error) {
            NSLog(@"反地理编码失败!");
            return ;
        }
        
        //地址信息
        placemark = [placemarks firstObject];
        
        self.addressText.text = [NSString stringWithFormat:@"%@ %@ %@, %@", placemark.country, placemark.administrativeArea,placemark.locality,placemark.name];
//        self.addressText.text = placemark.name;
        
        NSLog(@"我的地址:%@", placemark.name);
        
    }];
    
    //停止定位
    [manager stopUpdatingLocation];
}

//定位失败
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"定位失败:%@", error);
}

- (IBAction)signButton:(UIButton *)sender {
    
    MBhud(@"签到成功");
}

- (IBAction)nearLoc {
    
    NSLog(@"附近坐标");
}

- (IBAction)confirmLoc {
    
    MBhud(placemark.thoroughfare);
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    // 1. 获取当前触摸点
    CGPoint point = [[touches anyObject] locationInView:_mapView];
    
    
    // 2. 转换成经纬度
    CLLocationCoordinate2D pt = [_mapView convertPoint:point toCoordinateFromView:_mapView];
    
    CLLocation * loc = [[CLLocation alloc] initWithLatitude:pt.latitude longitude:pt.longitude];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    //反地理编码
    [geocoder reverseGeocodeLocation:loc completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
       
        if (error) {
            NSLog(@"反地理编码失败!");
            return ;
        }
        
        //地址信息
        placemark = [placemarks firstObject];
        
        self.addressText.text = [NSString stringWithFormat:@"%@",placemark.name];
        
        NSLog(@"\n当前触发地址:%@", placemark.name);
        
    }];
    
    // 3. 添加大头针
    [self addAnnoWithPT:pt];
}

- (void)addAnnoWithPT:(CLLocationCoordinate2D)pt
{
    __block XMGAnno *anno = [[XMGAnno alloc] init];
    anno.coordinate = pt;
    [_mapView addAnnotation:anno];
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:anno.coordinate.latitude longitude:anno.coordinate.longitude];
    [self.geoC reverseGeocodeLocation:loc completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *pl = [placemarks firstObject];
        anno.title = pl.locality;
        anno.subtitle = pl.thoroughfare;
        
    }];
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 移除大头针(模型)
    NSArray *annos = _mapView.annotations;
    [_mapView removeAnnotations:annos];
}

@end
