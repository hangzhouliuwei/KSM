//
//  BagLocationManager.m
//  NewBag
//
//  Created by Jacky on 2024/3/24.
//

#import "BagLocationManager.h"
#import <CoreLocation/CoreLocation.h>

@implementation BagLocationService

{
    NSDictionary *_param;

}
- (instancetype)initWithDic:(NSDictionary *)param{
    if (self = [super init]) {
        _param = param ? : @{};
    }
    return self;
}

- (NSString *)requestUrl {
    return @"frcr/location";
}
- (BOOL)isShowLoading
{
    return NO;
}
- (NSTimeInterval)requestTimeoutInterval
{
    return 30;
}
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return _param;
}
@end

/**========================================================================**/

@interface BagLocationManager ()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
// 用作地理编码、反地理编码的工具类
@property (nonatomic, strong) CLGeocoder *geoC;
@property(nonatomic, copy) ReturnBoolBlock statusBlock;
@end
@implementation BagLocationManager
+ (instancetype)shareInstance{
    static BagLocationManager  *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[BagLocationManager alloc]init];
       
    });
    return sharedManager;
}

- (void)startLocation{

    //    请求前台授权
    [self.locationManager requestWhenInUseAuthorization];
    // 2.判断定位服务是否可用
    dispatch_queue_t queue = dispatch_queue_create("writeLoganQueue", DISPATCH_QUEUE_CONCURRENT);
       dispatch_async(queue, ^{
           BOOL iscanLocaation = [CLLocationManager locationServicesEnabled];
           if([CLLocationManager locationServicesEnabled])
           {
               [self.locationManager startUpdatingLocation];
           
           }else
           {
               NSLog(@"不能定位");
           }
       });
}

- (void)uploadLocation
{
    if(![BagUserManager shareInstance].isLogin)return;
    
    NSDictionary *param = @{
        @"holometabolismF":NotNull(self.admin_area),
        @"mousakaF":NotNull(self.country_code),
        @"neddyF":NotNull(self.country),
        @"floralizeF":NotNull(self.feature_name),
        @"reinhabitF":@(self.longitude),
        @"hateworthyF":@(self.latitude),
        @"aroundF":NotNull(self.locality),
        @"reputedF":NotNull(self.sub_admin_area),
    };
    BagLocationService *service = [[BagLocationService alloc] initWithDic:param];
    [service startWithCompletionBlockWithSuccess:^(__kindof BagBaseRequest * _Nonnull request) {
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (void)checkLocationStatus:(ReturnBoolBlock)status
{
    if(status){
        self.statusBlock = status;
    }
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location = locations.lastObject;
    self.latitude = location.coordinate.latitude;
    self.longitude = location.coordinate.longitude;
    self.isOpenPerssion = YES;
    if(self.statusBlock){
        self.statusBlock(YES);
        self.statusBlock = nil;
    }
    
    WEAKSELF
    [self.geoC reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * __nullable placemarks, NSError * __nullable error) {
        STRONGSELF;
        // 包含区，街道等信息的地标对象
        CLPlacemark *placemark = [placemarks firstObject];
        //国家 country
        strongSelf.country = placemark.country;
        //国家编码
        strongSelf.country_code = placemark.ISOcountryCode;
        //省
        strongSelf.admin_area =  placemark.administrativeArea ? : @"";
        // 城市名称
        strongSelf.locality =  placemark.locality ? : @"";
        //区
        strongSelf.sub_admin_area = placemark.subLocality ? : @"";
        // 街道名称
        NSString *address = [NSString stringWithFormat:@"%@%@",self.sub_admin_area,placemark.subThoroughfare];
        // 街道
        strongSelf.feature_name =  placemark.name;
        strongSelf.adress =address;
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [strongSelf uploadLocation];
        });
        if(strongSelf.longitude == 0 || strongSelf.latitude == 0){
            return;
        }
        [strongSelf.locationManager stopUpdatingLocation];
       }];
    
}
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status

{
    //这里，是对当前用户对定位是否授权的一个状态的判断
    switch (status) {
            
        case kCLAuthorizationStatusNotDetermined:
            
            NSLog(@"用户还没做出决定");
            
            break;
            
        case kCLAuthorizationStatusRestricted:
            
            NSLog(@"访问受限");
            
            break;
            
        case kCLAuthorizationStatusDenied:
            
            NSLog(@"用户选择了不允许");
            if (self.statusBlock) {
                self.statusBlock(NO);
                self.statusBlock = nil;
                self.isOpenPerssion = NO;
            }
            break;
            
        case kCLAuthorizationStatusAuthorizedAlways:
            
            NSLog(@"开启了Alway模式");
            if (self.statusBlock) {
                self.statusBlock(YES);
                self.statusBlock = nil;
                self.isOpenPerssion = YES;
            }
            break;
            
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            
            NSLog(@"开启了whenInUse状态");
            if (self.statusBlock) {
                self.statusBlock(YES);
                self.statusBlock = nil;
                self.isOpenPerssion = YES;
            }
            break;
    }
}


-(CLGeocoder *)geoC
{
    if (!_geoC) {
        _geoC = [[CLGeocoder alloc] init];
    }
    return _geoC;
}
-(CLLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc]init];
        // 设置定位距离过滤参数 （当上次定位和本次定位之间的距离 > 此值时，才会调用代理通知开发者）
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        // 设置定位精度 （精确度越高，越耗电，所以需要我们根据实际情况，设定对应的精度）
        //允许后台获取信息
//        _locationManager.allowsBackgroundLocationUpdates = YES;
        _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        _locationManager.delegate = self;
    }
    return _locationManager;
}
@end
