//
//  LocationManager.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/27.
//

#import "PLPLocationManager.h"

@implementation PLPLocationManager
+ (instancetype)sharedManager {
    static PLPLocationManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        // 请求定位权限
        [_locationManager requestWhenInUseAuthorization];
    }
    return self;
}
-(void)requestLocactionInfo:(void (^)(BOOL, id _Nonnull))infoBlk
{
    self.infoBlk = infoBlk;
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestWhenInUseAuthorization];
    }else if (status == kCLAuthorizationStatusRestricted || status == kCLAuthorizationStatusDenied) {
        if (self.infoBlk) {
            self.infoBlk(false, nil);
        }
    }else
    {
        [self.locationManager startUpdatingLocation];
    }
}
- (void)startUpdatingLocation {
    [_locationManager startUpdatingLocation];
}

-(NSString *)getCurrentLatitude {
    return [NSString stringWithFormat:@"%.6f",self.currentLocation.coordinate.latitude];
}

-(NSString *)getCurrentLongitude {
    return [NSString stringWithFormat:@"%.6f",self.currentLocation.coordinate.longitude];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    _currentLocation = [locations lastObject];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    CLLocation *location = [locations lastObject];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {
            return;
        }
        if (placemarks.count > 0) {
            CLPlacemark *placemark = [placemarks firstObject];
            self.province = placemark.administrativeArea;
            self.countryCode = placemark.ISOcountryCode;
            self.country = placemark.country;
            self.city = placemark.locality;
            self.area = placemark.subLocality;
            self.street = placemark.thoroughfare;
            if (self.infoBlk) {
                self.infoBlk(true, nil);
                self.infoBlk = nil;
            }
        } else {

        }
    }];
    [_locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
//    NSLog(@"Failed to get location: %@", error.localizedDescription);
}

@end
