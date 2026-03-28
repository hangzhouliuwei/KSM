//
//  BagLocationManager.h
//  NewBag
//
//  Created by Jacky on 2024/3/24.
//

#import <Foundation/Foundation.h>
#import "BagBaseRequest.h"
typedef void (^ReturnBoolBlock)(BOOL value);

@interface BagLocationService : BagBaseRequest

@end
NS_ASSUME_NONNULL_BEGIN



@interface BagLocationManager : NSObject
///纬度
@property (nonatomic, assign) CGFloat latitude;
///经度
@property (nonatomic, assign) CGFloat longitude;
///国家
@property (nonatomic, copy) NSString *country;
//国家编码
@property (nonatomic, copy) NSString *country_code;
//省
@property (nonatomic, copy) NSString *admin_area;
//市
@property (nonatomic, copy) NSString *locality;
//区
@property (nonatomic, copy) NSString *sub_admin_area;
//街道
@property (nonatomic, copy) NSString *feature_name;
//详细地址
@property (nonatomic, copy) NSString *adress;

@property(nonatomic, copy) ReturnBoolBlock isLocationSuccess;
@property (nonatomic, assign) BOOL isOpenPerssion;

+ (instancetype)shareInstance;
- (void)startLocation;
- (void)uploadLocation;
- (void)checkLocationStatus:(ReturnBoolBlock)status;
@end

NS_ASSUME_NONNULL_END
