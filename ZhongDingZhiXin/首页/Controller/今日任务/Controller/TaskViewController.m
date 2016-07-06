//
//  TaskViewController.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/10/14.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "TaskViewController.h"

@interface TaskViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKPoiSearchDelegate,BMKPoiSearchDelegate,BMKGeoCodeSearchDelegate>
{
    BMKMapView *_mapView;
    BMKLocationService *_locService;
    CLLocationManager *locationManager;
    BMKPoiSearch *_poisearch;
    int curPage;
    
    TaskView *_taskView;
    NSString *_cityName;   // 检索城市名
    NSString *_keyWord;    // 检索关键字
    int currentPage;       //  当前页
    BMKPointAnnotation *_pointAnnotation;
    BMKPinAnnotationView *_newPinAnnotation;
    BMKGeoCodeSearch *_searcher;
}
//poi结果信息集合
@property (retain,nonatomic) NSMutableArray *poiResultArray;
@property (weak, nonatomic) IBOutlet UILabel *addressText;

@end

@implementation TaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//隐藏TabBar
-(void)viewWillAppear:(BOOL)animated{

    self.tabBarController.tabBar.hidden=YES;
    
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
    _poisearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _searcher.delegate=self;
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    _poisearch.delegate = nil; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _searcher.delegate=nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置背景颜色
    [self.view setBackgroundColor:[UIColor whiteColor]];
    //设置导航栏
    [self setNavigationBar];
    
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    _locService = [[BMKLocationService alloc]init];
    [_locService startUserLocationService];
    
    _mapView=[[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], 370)];
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    _mapView.zoomLevel=17;//地图级别
    [self.view addSubview:_mapView];
    
    //添加内容视图
    [self addContentView];
    
}
//设置导航栏
-(void)setNavigationBar
{
    //设置导航栏的颜色
    self.navigationController.navigationBar.barTintColor=LIGHT_WHITE_COLOR;
    self.title=@"今日任务";
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
    UIView *locationView=[[UIView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_mapView.frame)-55, 100, 30)];
    locationView.backgroundColor=[UIColor whiteColor];
    locationView.layer.cornerRadius=5;
    [_mapView addSubview:locationView];
    
    UIButton *locationButton=[UIButton buttonWithType:UIButtonTypeCustom];
    locationButton.frame=CGRectMake(5, 5, 20, 20);
    [locationButton setBackgroundImage:[UIImage imageNamed:@"jrrwxq"] forState:UIControlStateNormal];
    [locationButton addTarget:self action:@selector(locationButton) forControlEvents:UIControlEventTouchUpInside];
    [locationView addSubview:locationButton];
    
    UILabel *nearbyLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(locationButton.frame)+5, 0, 70, 30)];
    nearbyLabel.text=@"附近坐标";
    nearbyLabel.font=[UIFont systemFontOfSize:15];
    [locationView addSubview:nearbyLabel];
    
    UIView *notarizeView=[[UIView alloc]initWithFrame:CGRectMake([UIUtils getWindowWidth]-120, CGRectGetMaxY(_mapView.frame)-55, 100, 30)];
    notarizeView.backgroundColor=[UIColor whiteColor];
    notarizeView.layer.cornerRadius=5;
    [_mapView addSubview:notarizeView];
    
    UIButton *notarizeButton=[UIButton buttonWithType:UIButtonTypeCustom];
    notarizeButton.frame=CGRectMake(5, 5, 20, 20);
    [notarizeButton setBackgroundImage:[UIImage imageNamed:@"jrrwqd"] forState:UIControlStateNormal];
    [notarizeView addSubview:notarizeButton];
    
    UILabel *notarizeLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(notarizeButton.frame)+5, 0, 70, 30)];
    notarizeLabel.text=@"确认坐标";
    notarizeLabel.font=[UIFont systemFontOfSize:15];
    [notarizeView addSubview:notarizeLabel];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(addName:)
                                                 name:@"add_name" object:nil];
}

-(void)addName:(NSNotification *)noti{

    [_taskView removeFromSuperview];
    
    int num=[noti.object intValue];
    
     NSDictionary *dic = _poiResultArray[num];
    
    self.addressText.text=[NSString stringWithFormat:@"%@ %@",dic[@"address"],dic[@"name"]];
    
    
    NSLog(@"%@",noti);

}

-(void)locationButton
{
    if (!_taskView) {
        _taskView = [[TaskView alloc] initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], [UIUtils getWindowHeight]) andArray:_poiResultArray];
    }
    [_taskView showInView:self.navigationController.view];
}

#pragma mark --BMKPoiSearchDelegate
/**
 *返回POI搜索结果
 *@param searcher 搜索对象
 *@param poiResult 搜索结果列表
 *@param errorCode 错误号，@see BMKSearchErrorCode
 */
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResult errorCode:(BMKSearchErrorCode)errorCode
{
    
    if (!_poiResultArray) {
        _poiResultArray=[[NSMutableArray alloc] init];
    }
    
    if (errorCode == BMK_SEARCH_NO_ERROR)
    {
        for (int i = 0; i < poiResult.poiInfoList.count; i++)
        {
            // BMKPoiInfo就是检索出来的poi信息
            BMKPoiInfo* poi = [poiResult.poiInfoList objectAtIndex:i];
            NSLog(@"%@%@",poi.address,poi.name);
            
            NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:poi.address,@"address",poi.name,@"name", nil];
            
            [_poiResultArray addObject:dic];
         }
    }else if (errorCode == BMK_SEARCH_AMBIGUOUS_KEYWORD)
    {
        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
        // result.cityList;
        NSLog(@"起始点有歧义");
    } else {
        NSLog(@"抱歉，未找到结果");
    }
}

/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    _mapView.centerCoordinate = userLocation.location.coordinate;
    [_mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);

}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
    
    //poi搜索
    _poisearch = [[BMKPoiSearch alloc]init];
    _poisearch.delegate = self;
    currentPage = 0;
    //附近云检索，其他检索方式见详细api
    BMKNearbySearchOption *nearBySearchOption = [[BMKNearbySearchOption alloc]init];
    nearBySearchOption.pageIndex = currentPage; //第几页
    nearBySearchOption.pageCapacity = 10;  //最多几页
    nearBySearchOption.keyword = @"广场";   //检索关键字
    nearBySearchOption.location=CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);// poi检索点
    nearBySearchOption.radius = 1000; //检索范围 m
    BOOL flag = [_poisearch poiSearchNearBy:nearBySearchOption];
    if(flag)
    {
        NSLog(@"城市内检索发送成功");
        [_locService stopUserLocationService];
    }
    else
    {
        NSLog(@"城市内检索发送失败");
    }
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}

#pragma mark 底图手势操作
/**
 *点中底图空白处会回调此接口
 *@param mapview 地图View
 *@param coordinate 空白处坐标点的经纬度
 */
- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate
{
    NSLog(@"onClickedMapBlank-latitude==%f,longitude==%f",coordinate.latitude,coordinate.longitude);
    NSString* showmeg = [NSString stringWithFormat:@"您点击了地图空白处(blank click).\r\n当前经度:%f,当前纬度:%f,\r\nZoomLevel=%d;RotateAngle=%d;OverlookAngle=%d", coordinate.longitude,coordinate.latitude,
                         (int)_mapView.zoomLevel,_mapView.rotation,_mapView.overlooking];
    NSLog(@"%@",showmeg);
    
    //添加标注
    _pointAnnotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = coordinate.latitude;
    coor.longitude = coordinate.longitude;
    _pointAnnotation.coordinate = coor;
    [_mapView addAnnotation:_pointAnnotation];
    
    
    //初始化检索对象
    _searcher =[[BMKGeoCodeSearch alloc]init];
    _searcher.delegate = self;
//    NSString *coordinate=coor.latitude;
    
    //发起反向地理编码检索
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){coordinate.longitude, coordinate.latitude};
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_searcher reverseGeoCode:reverseGeoCodeSearchOption];
    if(flag)
    {
      NSLog(@"反geo检索发送成功");
    }
    else
    {
      NSLog(@"反geo检索发送失败");
    }
}
#pragma mark MapViewDelegate
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    NSString *AnnotationViewID = @"renameMark";
    // 检查是否有重用的缓存
//    BMKAnnotationView* newAnnotation = [mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    if (_newPinAnnotation == nil) {
        _newPinAnnotation = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        // 设置颜色
        ((BMKPinAnnotationView*)_newPinAnnotation).pinColor = BMKPinAnnotationColorPurple;
        // 从天上掉下效果
        ((BMKPinAnnotationView*)_newPinAnnotation).animatesDrop = YES;
        // 设置可拖拽
        ((BMKPinAnnotationView*)_newPinAnnotation).draggable = NO;
    }
    return _newPinAnnotation;
}
#pragma mark BMKGeoCodeSearchDelegate
//接收反向地理编码结果
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:
(BMKReverseGeoCodeResult *)result
errorCode:(BMKSearchErrorCode)error{
  if (error == BMK_SEARCH_NO_ERROR) {
      //在此处理正常结果
      NSLog(@"成功");
//      BMKPointAnnotation *itme=[[BMKPointAnnotation alloc]init];
//      itme.coordinate = result.location;
//      itme.title = result.address;
//      [_mapView addAnnotation:itme];
//      _mapView.centerCoordinate = result.location;
//      
//      NSString *string=[NSString stringWithFormat:@"%@",itme.title];
//      NSLog(@"%@",string);
      
  }
  else {
      NSLog(@"抱歉，未找到结果");
  }
}

- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}

- (IBAction)signButton:(UIButton *)sender {
    
    NSLog(@"签到");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark TaskViewDelegate

-(void)backName:(NSString *)name{

    self.addressText.text=name;
    
}


@end
