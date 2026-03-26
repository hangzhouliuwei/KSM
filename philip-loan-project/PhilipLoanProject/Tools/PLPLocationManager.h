//
//  LocationManager.h
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/27.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
NS_ASSUME_NONNULL_BEGIN

@interface PLPLocationManager : NSObject<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocation *currentLocation;
@property (nonatomic, strong) CLLocationManager *locationManager;

@property(nonatomic,strong)NSString *province;
@property(nonatomic,strong)NSString *city;
@property(nonatomic,strong)NSString *country;
@property(nonatomic,strong)NSString *countryCode;
@property(nonatomic,strong)NSString *area;
@property(nonatomic,strong)NSString *street;

@property(nonatomic,copy)void(^infoBlk)(BOOL hasPermission, id info);
+ (instancetype)sharedManager;

- (void)startUpdatingLocation;
- (NSString *)getCurrentLatitude;
- (NSString *)getCurrentLongitude;

-(void)requestLocactionInfo:(void(^)(BOOL hasPermission, id info))infoBlk;


@end

NS_ASSUME_NONNULL_END
