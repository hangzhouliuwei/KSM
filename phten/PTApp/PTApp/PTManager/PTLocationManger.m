//
//  PTLocationManger.m
//  PTApp
//
//  Created by 刘巍 on 2024/7/17.
//

#import "PTLocationManger.h"
#import <CoreLocation/CoreLocation.h>
#import "PTLocationService.h"

@interface PTLocationManger()<CLLocationManagerDelegate>
// 用户位置服务
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, copy) void (^authorizationCompletion)(BOOL granted);
@property(nonatomic, copy) PTBoolBlock statusBlock;
@end

@implementation PTLocationManger
SINGLETON_M(PTLocationManger)

- (void)checkLocationServicesWithCompletion:(void (^)(BOOL))completion 
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BOOL locationServicesEnabled = [CLLocationManager locationServicesEnabled];
        CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            BOOL canUseLocationServices = locationServicesEnabled && (authorizationStatus != kCLAuthorizationStatusDenied);
            completion(canUseLocationServices);
        });
    });
}

- (void)canUserLocationServerWithCompletion:(void (^)(BOOL))completion 
{
    [self checkLocationServicesWithCompletion:^(BOOL canUseLocationServices) {
        completion(canUseLocationServices);
    }];
}

- (void)checkLocationStatus:(PTBoolBlock)status
{
    if(status){
        self.statusBlock = status;
    }
}
/// 开始获取位置信息
- (void)startUpdatingLocation 
{
    WEAKSELF
    [self canUserLocationServerWithCompletion:^(BOOL canUseLocationServices) {
        if (!canUseLocationServices) {
            return;
        }
        CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
        
        if (status == kCLAuthorizationStatusNotDetermined) {
            weakSelf.authorizationCompletion = ^(BOOL granted) {
                if (granted) {
                    [weakSelf.locationManager startUpdatingLocation];
                }
            };
            if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                NSLog(@"requestAlwaysAuthorization");
                [self.locationManager requestAlwaysAuthorization];
                [weakSelf.locationManager startUpdatingLocation];
            }
            
            if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
                NSLog(@"requestWhenInUseAuthorization");
                [weakSelf.locationManager requestWhenInUseAuthorization];
                [weakSelf.locationManager startUpdatingLocation];
            }
        } else if (status == kCLAuthorizationStatusAuthorizedWhenInUse ||
                   status == kCLAuthorizationStatusAuthorizedAlways) {
            [weakSelf.locationManager startUpdatingLocation];
        }
    }];
}

- (void)locationManagerDidChangeAuthorization:(CLLocationManager *)manager {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (self.authorizationCompletion) {
        BOOL granted = (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusAuthorizedAlways);
        self.authorizationCompletion(granted);
        self.authorizationCompletion = nil;
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    // 停止定位
    [self.locationManager stopUpdatingLocation];
//    self.locationManager.delegate = nil;
//    self.locationManager = nil;
    
    // 获取用户位置的对象
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    self.latitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
    self.longitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
    NSLog(@"lw========>经度%@纬度%@",self.latitude,self.longitude);
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    __weak typeof(self) weakSelf = self;
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> *placemarks, NSError *error) {
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            if (placemarks.count > 0) {
                CLPlacemark *placemark = [placemarks firstObject];
                // 国家 country
                strongSelf.country = placemark.country;
                // 国家编码
                strongSelf.country_code = placemark.ISOcountryCode;
                // 省
                strongSelf.admin_area =  placemark.administrativeArea ? : @"";
                // 城市名称
                strongSelf.locality =  placemark.locality ? : @"";
                // 区
                strongSelf.sub_admin_area = placemark.subLocality ? : @"";
                // 街道名称
                NSString *address = [NSString stringWithFormat:@"%@%@", strongSelf.sub_admin_area, placemark.subThoroughfare];
                // 街道
                strongSelf.feature_name =  placemark.name;
                strongSelf.adress = address;
                [strongSelf uploadLocation];
                if (strongSelf.locationInfoBlock) {
                    strongSelf.locationInfoBlock(YES);
                }
            } else {
                if (strongSelf.locationInfoBlock) {
                    strongSelf.locationInfoBlock(NO);
                }
            }
        }
    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if (self.locationInfoBlock) {
        self.locationInfoBlock(NO);
    }
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


- (void)uploadLocation
{
    if(![PTUser isLogin]) return;
    
    NSDictionary *dic = @{
                         @"metenonymNc":PTNotNull(self.admin_area),
                         @"prtengenitureNc":PTNotNull(self.country_code),
                         @"emtenlumentNc":PTNotNull(self.country),
                         @"metenadaltonNc":PTNotNull(self.feature_name),
                         @"botenomofoNc":PTNotNull(self.latitude),
                         @"untenevoutNc":PTNotNull(self.longitude),
                         @"gotenogenesisNc":PTNotNull(self.locality),
                         @"amtenitiouslyNc":PTNotNull(self.sub_admin_area),
                         };
    PTLocationService *service = [[PTLocationService alloc] initWithData:dic];
    [service startWithCompletionBlockWithSuccess:^(__kindof PTBaseRequest * _Nonnull request) {
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
    }];
    
}

- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _locationManager = [[CLLocationManager alloc] init];
            _locationManager.delegate = self;
            _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        });
    }
    return _locationManager;
}

@end

