//
//  PTLocationManger.h
//  PTApp
//
//  Created by 刘巍 on 2024/7/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define PTLocation [PTLocationManger sharedPTLocationManger]

@interface PTLocationManger : NSObject
SINGLETON_H(PTLocationManger)
///纬度
@property(nonatomic,copy) NSString *latitude;
///经度
@property(nonatomic,copy) NSString *longitude;
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

@property (nonatomic, copy) void (^locationInfoBlock)(BOOL isSuccess);

///定位检查
- (void)checkLocationServicesWithCompletion:(void (^)(BOOL))completion;

///开始获取位置信息
- (void)startUpdatingLocation;
///检查一下定位权限
- (void)checkLocationStatus:(PTBoolBlock)status;

@end

NS_ASSUME_NONNULL_END
