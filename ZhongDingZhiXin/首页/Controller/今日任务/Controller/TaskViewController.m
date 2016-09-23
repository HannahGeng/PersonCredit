//
//  TaskViewController.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/10/14.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "TaskViewController.h"//系统自带地图框架
#import "XMGAnno.h"

@interface TaskViewController ()<BMKMapViewDelegate,BMKPoiSearchDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource,MKMapViewDelegate>
{
    int curPage;
    TaskView *_taskView;
    NSString *_cityName;   // 检索城市名
    NSString *_keyWord;    // 检索关键字
    MBProgressHUD * mbHud;
    BMKGeoCodeSearch * _searcher;
    BMKLocationService * _locService;
    BMKPoiSearch * _poiSearch;
    double _latA;
    double _lonA;
}

@property (retain,nonatomic) NSMutableArray *poiResultArray;
@property (weak, nonatomic) IBOutlet UILabel *addressText;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailTimeLabel;
@property (nonatomic, strong) CLGeocoder *geoC;
@property (weak, nonatomic) IBOutlet UIButton *nearButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (strong, nonatomic) BMKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UITableView *nearTableView;
@property (nonatomic,strong) NSMutableArray * nearArray;
@property (weak, nonatomic) IBOutlet UIView *backListView;
@property (weak, nonatomic) IBOutlet UIView *backTableView;

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
    
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _searcher.delegate = self;
    _locService.delegate = self;
    
    self.tabBarController.tabBar.hidden=YES;
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    AppShare;

    //添加圆圈
    BMKCircle* circle = [BMKCircle circleWithCenterCoordinate:app.coordinate radius:1000];
    
    [_mapView addOverlay:circle];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _searcher.delegate = nil;
    _poiSearch.delegate = nil;
    _locService.delegate = nil;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    AppShare;
    
    //mapView尺寸
    if ([UIUtils getWindowWidth] == 375) {//6
       
        _mapView=[[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], 370)];
        
    }else if ([UIUtils getWindowWidth] == 414){//plus
        
        _mapView=[[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], 440)];
        
    }else{//5s
        
        _mapView=[[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], 320)];
        
    }
    
    //大头针背景图
    UIView * topView = [[UIView alloc] init];
    topView.frame = _mapView.frame;
    topView.backgroundColor = [UIColor whiteColor];
    topView.alpha = 0.05;
    [_mapView addSubview:topView];
    [_backView addSubview:_mapView];
    
    //添加内容视图
    [self addContentView];
    
    //设置导航栏
    [self setNavigationBar];
    
    //启动LocationService
    _locService = [[BMKLocationService alloc]init];
    [_locService startUserLocationService];
    self.backListView.hidden = YES;
    
    _mapView.logoPosition = BMKLogoPositionRightTop;
    
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    
    _mapView.zoomLevel=16;//地图级别
    BMKLocationViewDisplayParam *displayParam = [[BMKLocationViewDisplayParam alloc]init];
    displayParam.isAccuracyCircleShow = false;//精度圈是否显示
    
    //是否允许缩放
    _mapView.zoomEnabled = YES;
    
    //是否允许移动
    _mapView.scrollEnabled = YES;
    
    //是否允许旋转
    _mapView.rotateEnabled = NO;

    [_mapView updateLocationViewWithParam:displayParam];
    
    _addressText.text = app.address;
    
}

// 圆形
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay{
    
    if ([overlay isKindOfClass:[BMKCircle class]]){
        BMKCircleView* circleView = [[BMKCircleView alloc] initWithOverlay:overlay];
        circleView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
        circleView.lineWidth = 5.0;
        
        return circleView;
    }
    return nil;
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    AppShare;

    _latA=userLocation.location.coordinate.latitude;
    _lonA=userLocation.location.coordinate.longitude;
    
    app.coordinate = userLocation.location.coordinate;

    [_mapView updateLocationData:userLocation];
    
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
    if (self.backListView.hidden == NO) {
        
        [UIView animateWithDuration:0.25 animations:^{
            
            self.backListView.alpha = 0;
            self.backTableView.alpha = 0;
            
        } completion:^(BOOL finished) {
            
            self.backListView.hidden = YES;
            
        }];
        
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];

    }
}

//添加内容视图
-(void)addContentView
{
    AppShare;
    
    [_mapView addSubview:_nearButton];
    [_mapView addSubview:_confirmButton];
    
    //时间戳
    NSDate * senddate=[NSDate date];
    
    NSDateFormatter * dateformatter = [[NSDateFormatter alloc] init];
    NSDateFormatter * dateformatter2 = [[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY/MM/dd"];
    [dateformatter2 setDateFormat:@"HH:mm"];
    
    NSString * detailStr = [dateformatter2 stringFromDate:senddate];
    NSString * timeStr = [dateformatter stringFromDate:senddate];
    
    self.timeLabel.text = timeStr;
    self.detailTimeLabel.text = detailStr;
    
    app.timeStr = [NSString stringWithFormat:@"%@ %@",timeStr,detailStr];

}

#pragma mark - 签到按钮
- (IBAction)signButton:(UIButton *)sender {
    
    AppShare;
    
    NSDictionary * pdic = [NSDictionary dictionaryWithObjectsAndKeys:app.uid,@"uid",app.request,@"request",[AESCrypt encrypt:app.name password:app.loginKeycode],@"client",[AESCrypt encrypt:@"暂无" password:app.loginKeycode],@"contact",app.mobilephone,@"contacttel",[AESCrypt encrypt:app.timeStr password:app.loginKeycode],@"locatime",[AESCrypt encrypt:app.address password:app.loginKeycode],@"location",[AESCrypt encrypt:[NSString stringWithFormat:@"%f:%f",app.coordinate.latitude,app.coordinate.longitude] password:app.loginKeycode],@"coordinate", nil];
    
    NSLog(@"参数字典:%@",pdic);
    
    NSLog(@"地址:%@",app.address);
    
    [[HTTPSessionManager sharedManager] POST:JIANDAO_URL parameters:pdic result:^(id responseObject, NSError *error) {
        
        NSLog(@"签到记录:%@",responseObject);
        app.request = responseObject[@"response"];
    }];
    
        MBhud(@"签到成功");
    
}

#pragma mark - 附近的坐标点击事件
- (IBAction)nearLoc {
    
    mbHUDinit;
    
    AppShare;
    AFNetworkReachabilityManager * mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr startMonitoring];
    
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status != 0) {
            
            //初始化检索对象
            _poiSearch =[[BMKPoiSearch alloc]init];
            _poiSearch.delegate = self;
            
            //发起检索
            BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
            option.pageIndex = curPage;
            option.pageCapacity = 6;
            option.location = app.coordinate;
            option.keyword = @"酒店";
            BOOL flag = [_poiSearch poiSearchNearBy:option];
            
            if(flag)
            {
                NSLog(@"周边检索发送成功");
            }else
            {
                MBhud(@"周边检索发送失败");
                hudHide;
            }
            
        }else
        {
            hudHide;
            noWebhud;
        }
        
    }];
    
}

#pragma mark - PoiSearchDeleage
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error
{
    AppShare;
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        NSArray * resultArr = poiResultList.poiInfoList;
        NSMutableArray * dicNearArray = [NSMutableArray array];
        
        for (int i = 0; i < resultArr.count; i++) {
            
            BMKPoiInfo * infoArr = poiResultList.poiInfoList[i];
            
            NSDictionary * neardic = [NSDictionary dictionaryWithObjectsAndKeys:infoArr.name,@"name",infoArr.address,@"address", nil];
            
            [dicNearArray addObject:neardic];
            
        }
        
        app.dicNearArray = dicNearArray;
        
        NSMutableArray * nearA = [NSMutableArray array];
        
        for (NSDictionary * dic in app.dicNearArray) {
            
            NearModel * near = [NearModel nearWithDic:dic];
            
            [nearA addObject:near];
        }
        
        app.nearArray = nearA;
        
        self.nearArray = nearA;
        
        self.backTableView.layer.masksToBounds = YES;
        self.backTableView.layer.cornerRadius = 25;
        
        [self.nearTableView reloadData];
        
        if (self.nearArray.count != 0) {
            
            hudHide;
            
            [UIView animateWithDuration:0.25 animations:^{
                
                self.backListView.hidden = NO;
                self.backListView.alpha = 1;
                self.backTableView.alpha = 1;
            }];
            
            
        }else{
            
            hudHide;
            MBhud(@"检索发送失败，请重试");
        }
        
    }
    else if (error == BMK_SEARCH_AMBIGUOUS_KEYWORD){
        
        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
        // result.cityList;
        NSLog(@"起始点有歧义");
        
    } else {
        
        NSLog(@"抱歉，未找到结果");
    }
    
}

- (IBAction)confirmLoc {
    
    AppShare;
        
    _addressText.text = app.address;
}

#pragma mark - 添加大头针
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    AppShare;
        
    CGPoint point = [[touches anyObject] locationInView:self.mapView];
    
    CLLocationCoordinate2D pt = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
    
    BMKMapPoint point1 = BMKMapPointForCoordinate(pt);
    BMKMapPoint point2 = BMKMapPointForCoordinate(app.coordinate);
    
    if (self.backListView.hidden == YES) {
        
        CLLocationDistance distance = BMKMetersBetweenMapPoints(point1,point2);
        
        if (distance > 1000) {
            
            MBhud(@"超出范围");
            
        }else{
            
            NSArray *annos = self.mapView.annotations;
            
            if (annos.count > 0) {
                
                [self.mapView removeAnnotations:annos];
                
                [self addAnnoWithPT:pt];
                
            }else{
                
                // 3. 添加大头针
                [self addAnnoWithPT:pt];
            }
        }
        
    }else if(self.backListView.hidden == NO){
        
        [UIView animateWithDuration:0.25 animations:^{
            
            self.backListView.alpha = 0;
            self.backTableView.alpha = 0;

        } completion:^(BOOL finished) {
            
            self.backListView.hidden = YES;

        }];
    }
    
    
}

- (void)addAnnoWithPT:(CLLocationCoordinate2D)pt
{
    AppShare;
    XMGAnno *anno = [[XMGAnno alloc] init];
    
    anno.coordinate = pt;
    
    [self.mapView addAnnotation:anno];
    
    //反地理编码
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:anno.coordinate.latitude longitude:anno.coordinate.longitude];
    [self.geoC reverseGeocodeLocation:loc completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        CLPlacemark *pl = [placemarks firstObject];
       
        NSString * placeName = [NSString stringWithFormat:@"%@%@%@%@",pl.administrativeArea,pl.locality,pl.subLocality,pl.thoroughfare];
        
        if (pl.administrativeArea.length == 0 || pl.locality.length == 0 || pl.subLocality.length == 0 || pl.thoroughfare.length == 0) {
            
            MBhud(@"请重新选择");
            
        }else{
            
            MBhud(placeName);
        }
        
        app.address = [NSString stringWithFormat:@"%@%@%@%@",pl.administrativeArea,pl.locality,pl.subLocality,pl.thoroughfare];
    }];
    
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    AppShare;
    return app.nearArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppShare;
    
    NearCell * cell = [NearCell cellWithTableView:tableView];
    cell.nearmodel = app.nearArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.numView.image = [UIImage imageNamed:[NSString stringWithFormat:@"jrrwdizhi%ld",indexPath.row + 1]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppShare;
    
    NSString * addressL = app.dicNearArray[indexPath.row][@"address"];
    
    self.backListView.hidden = YES;
    
    self.addressText.text = addressL;
}

@end
