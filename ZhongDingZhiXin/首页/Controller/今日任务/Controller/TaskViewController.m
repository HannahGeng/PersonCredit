//
//  TaskViewController.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/10/14.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "TaskViewController.h"//系统自带地图框架
#import "XMGAnno.h"

@interface TaskViewController ()<BMKMapViewDelegate,BMKPoiSearchDelegate,BMKLocationServiceDelegate>
{
    int curPage;
    TaskView *_taskView;
    NSString *_cityName;   // 检索城市名
    NSString *_keyWord;    // 检索关键字
    MBProgressHUD * mbHud;
    
    BMKGeoCodeSearch * _search;
    BMKLocationService * _locService;
    BMKUserLocation * _userLocation;
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
@property (strong, nonatomic) BMKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end

@implementation TaskViewController

//隐藏TabBar
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放

    self.tabBarController.tabBar.hidden=YES;
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    CLLocationCoordinate2D coor;

//     添加一个PointAnnotation
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    coor.latitude = _userLocation.location.coordinate.latitude;
    coor.longitude = _userLocation.location.coordinate.longitude;
    annotation.coordinate = coor;
    annotation.title = @"我的位置";
    [_mapView addAnnotation:annotation];
    
    CLLocationCoordinate2D center = coor;
    BMKCoordinateSpan span = BMKCoordinateSpanMake(0.038325, 0.028045);
    _mapView.limitMapRegion = BMKCoordinateRegionMake(center, span);////限制地图显示范围
    _mapView.rotateEnabled = NO;//禁用旋转手势
    
    //添加圆圈
    NSLog(@"\n坐标:%f,%f",coor.latitude,coor.longitude);
    
    BMKCircle* circle = [BMKCircle circleWithCenterCoordinate:coor radius:1000];
    
    [_mapView addOverlay:circle];

}

//我的位置标注
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mapView=[[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], 370)];
    
    [_mapView updateLocationData:_userLocation];
    
    [_backView addSubview:_mapView];
    
    //添加内容视图
    [self addContentView];
    
    //设置导航栏
    [self setNavigationBar];
    
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    
}

// 圆形
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay{
    
    if ([overlay isKindOfClass:[BMKCircle class]]){
        BMKCircleView* circleView = [[BMKCircleView alloc] initWithOverlay:overlay];
        circleView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:0.5];
        circleView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
        circleView.lineWidth = 5.0;
        
        return circleView;
    }
    return nil;
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

//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"\nheading is %@",userLocation.heading);
}

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"\ndidUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    _userLocation = userLocation;
}


//添加内容视图
-(void)addContentView
{

    [_mapView addSubview:_nearButton];
    [_mapView addSubview:_confirmButton];
    _mapView.showsUserLocation = YES;
    
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

- (IBAction)signButton:(UIButton *)sender {
    
    MBhud(@"签到成功");
}

- (IBAction)nearLoc {
    
    NSLog(@"附近坐标");
}

- (IBAction)confirmLoc {
    
}

@end
