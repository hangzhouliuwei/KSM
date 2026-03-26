//
//  PUBLocationManager.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/18.
//

#import "PUBLocationManager.h"
#import <CoreLocation/CoreLocation.h>
@interface PUBLocationManager()<CLLocationManagerDelegate> 
@property (nonatomic, strong) CLLocationManager *locationManager;
// 用作地理编码、反地理编码的工具类
@property (nonatomic, strong) CLGeocoder *geoC;
@property(nonatomic, copy) ReturnBoolBlock statusBlock;
@end
@implementation PUBLocationManager
SINGLETON_M(PUBLocationManager)

- (void)startLocation{
//    if (!LocalStorage.share.isLogin) {
//        return;
//    }
    //请求前后台定位授权
    //[self.locationManager requestAlwaysAuthorization];
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
    if(!User.isLogin)return;
    
    NSDictionary *addressInfoDic = @{
        @"marietta_eg":NotNull(self.admin_area),
        @"linguiform_eg":NotNull(self.country_code),
        @"dolmen_eg":NotNull(self.country),
        @"tutenague_eg":NotNull(self.feature_name),
        @"nonrecurring_eg":@(self.longitude),
        @"neuroleptic_eg":@(self.latitude),
        @"bargainee_eg":NotNull(self.locality),
        @"indelible_eg":NotNull(self.sub_admin_area),
    };
    
    [HttPPUBRequest postWithPath:UploadLocatio params:addressInfoDic success:^(NSDictionary * _Nonnull responseDataDic, PUBBaseResponseModel * _Nonnull mode) {
        
        NSLog(@"上传位置接口成功");
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"上传位置接口失败");
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
            }
            break;

        case kCLAuthorizationStatusAuthorizedAlways:

            NSLog(@"开启了Alway模式");
            if (self.statusBlock) {
                self.statusBlock(YES);
                self.statusBlock = nil;
            }
            break;

        case kCLAuthorizationStatusAuthorizedWhenInUse:

            NSLog(@"开启了whenInUse状态");
            if (self.statusBlock) {
                self.statusBlock(YES);
                self.statusBlock = nil;
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
