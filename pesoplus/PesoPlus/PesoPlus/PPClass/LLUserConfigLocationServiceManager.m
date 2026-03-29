//
//  LLUserConfigLocationServiceManager.m
// FIexiLend
//
//  Created by jacky on 2024/11/18.
//

#import "LLUserConfigLocationServiceManager.h"
#import <CoreLocation/CoreLocation.h>

@interface LLUserConfigLocationServiceManager () <CLLocationManagerDelegate>
@property (nonatomic,strong)CLLocationManager *locationManager;
@property (nonatomic, assign) BOOL didGot;
@end

@implementation LLUserConfigLocationServiceManager

- (void)ppGotoReqUserPhonesLoction {
    self.locationManager = [CLLocationManager new];
    [self.locationManager requestWhenInUseAuthorization];
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if (!self.didGot) {
        self.didGot = YES;
        CLAuthorizationStatus status = CLLocationManager.authorizationStatus;
        BOOL unknown = NO;
        switch (status) {
            case kCLAuthorizationStatusNotDetermined:
                unknown = YES;
                break;
            case kCLAuthorizationStatusRestricted:
                NSLog(@"无法使用位置信息");
                break;
            case kCLAuthorizationStatusDenied:
                NSLog(@"已拒绝位置权限");
                break;
            case kCLAuthorizationStatusAuthorizedAlways:
                NSLog(@"永久授权位置权限");
                break;
            case kCLAuthorizationStatusAuthorizedWhenInUse:
                NSLog(@"使用中授权位置权限");
                break;
            default:
                NSLog(@"未知的位置权限状态");
                break;
        }
        if (unknown) {
            return;
        }
        if (self.resultBlock) {
            self.resultBlock(NO);
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    NSLog(@"locations: %@", locations);
    CLLocation *currLocation = [locations lastObject];
    NSString * latitude = StrFormat(@"%f", currLocation.coordinate.latitude);
    NSString * longitude = StrFormat(@"%f", currLocation.coordinate.longitude);
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:currLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {
            if (self.resultBlock) {
                self.resultBlock(NO);
            }
            return;
        }
        if (placemarks.count > 0) {
            CLPlacemark *place = placemarks[0];
            NSDictionary *info = place.addressDictionary;
            NSString *province = info[@"Province"];
            NSString *locality = info[@"City"];
            NSString *street = info[@"Street"];
            NSString *code = info[@"CountryCode"];
            NSString *subLocality = info[@"SubLocality"];
            NSString *country = info[@"Country"];
            
            NSDictionary *dic = @{@"latitude":notNull(latitude), @"longitude":notNull(longitude), @"province":notNull(province), @"locality":notNull(locality), @"street":notNull(street), @"code":notNull(code), @"subLocality":notNull(subLocality), @"country":notNull(country)};
            User.latitude = notNull(latitude);
            User.longitude = notNull(longitude);
            User.loctionDic = dic;
            NSLog(@"lw======>经度%@=======>纬度%@",latitude,longitude);
            if (!self.didGot) {
                self.didGot = YES;
                if (self.resultBlock) {
                    self.resultBlock(YES);
                }
            }
        }
    }];
    [self.locationManager stopUpdatingLocation];
}


- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    
    if(status != kCLAuthorizationStatusNotDetermined){
        
        if(self.resultlocationBlock){
            self.resultlocationBlock();
        }
        
    }
    
    switch (status) {

        case kCLAuthorizationStatusNotDetermined:

            NSLog(@"用户还没做出决定");

            break;

        case kCLAuthorizationStatusRestricted:

            NSLog(@"访问受限");

            break;

        case kCLAuthorizationStatusDenied:

            NSLog(@"用户选择了不允许");
            
            break;

        case kCLAuthorizationStatusAuthorizedAlways:

            NSLog(@"开启了Alway模式");
            
            break;

        case kCLAuthorizationStatusAuthorizedWhenInUse:

            NSLog(@"开启了whenInUse状态");
        
            break;

    }
}
@end
