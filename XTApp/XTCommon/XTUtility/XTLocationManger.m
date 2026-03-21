//
//  XTLocationManger.m
//  XTApp
//
//  Created by xia on 2024/9/5.
//

#import "XTLocationManger.h"
#import <CoreLocation/CoreLocation.h>

@interface XTLocationManger()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager* manager;//用户位置服务

@end

@implementation XTLocationManger

+(instancetype)xt_share {
    static XTLocationManger *shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc]init];
    });
    return shareInstance;
}

///是否可以使用位置服务
-(BOOL)xt_canLocation {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    //确定用户的位置服务启用
    BOOL can = [CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied;
#pragma clang diagnostic pop
    if (can){
        return NO;
    }
    return YES;
}

///开始获取位置信息
- (BOOL)xt_startLocation {
    if(![self xt_canLocation]){
        return NO;
    }
    /** 由于IOS8中定位的授权机制改变 需要进行手动授权
        * 获取授权认证，两个方法：
        * [self.locationManager requestWhenInUseAuthorization];
        * [self.locationManager requestAlwaysAuthorization];
        */
   if ([self.manager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
       XTLog(@"requestAlwaysAuthorization");
       [self.manager requestAlwaysAuthorization];
   }
   if ([self.manager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
       XTLog(@"requestAlwaysAuthorization");
       [self.manager requestWhenInUseAuthorization];
   }
   //开始定位，不断调用其代理方法
   [self.manager startUpdatingLocation];
    return YES;
}
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    //停止定位
    [self.manager stopUpdatingLocation];
    self.manager.delegate = nil;
    self.manager = nil;
    
    // 1.获取用户位置的对象
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    self.xt_latitude = [NSString stringWithFormat:@"%f",coordinate.latitude];
    self.xt_longitude = [NSString stringWithFormat:@"%f",coordinate.longitude];
    if(self.LBSBlock) {
        self.LBSBlock();
    }
    if(self.LBSInfoBlock){
        CLGeocoder *geocoder=[[CLGeocoder alloc]init];
        @weakify(self)
        [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks,NSError *error) {
            @strongify(self)
             for(CLPlacemark *placemark in placemarks) {
                 //省
                 NSString *province = XT_Object_To_Stirng(placemark.administrativeArea);
                 //市
                 NSString *city = XT_Object_To_Stirng(placemark.locality);
                 NSDictionary *dic = @{
                     XTCountry:XT_Object_To_Stirng(placemark.country),
                     XTCountryCode:XT_Object_To_Stirng(placemark.ISOcountryCode),
                     XTProvince:province.length > 0 ? province : city,
                     XTCity:city.length > 0 ? city : province,
                     XTRegion:XT_Object_To_Stirng(placemark.subLocality),
                     XTStreet:XT_Object_To_Stirng(placemark.name),
                     XTLatitude:XT_Object_To_Stirng(self.xt_latitude),
                     XTLongitude:XT_Object_To_Stirng(self.xt_longitude),
                 };
                 if(self.LBSInfoBlock){
                     self.LBSInfoBlock(dic, YES);
                 }
                 return;
                 
             }
            if(self.LBSInfoBlock){
                self.LBSInfoBlock(@{}, NO);
            }
         }];
    }
    
    
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if(self.LBSBlock){
        self.LBSBlock();
    }
    if(self.LBSInfoBlock){
        self.LBSInfoBlock(@{},NO);
    }
}

- (CLLocationManager *)manager{
    if(!_manager){
        _manager = [[CLLocationManager alloc] init];
        _manager.delegate = self;
        _manager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    return _manager;
}

@end
