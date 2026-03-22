//
//  XTLocationManger.h
//  XTApp
//
//  Created by xia on 2024/9/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//国家
static const NSString * _Nonnull XTCountry = @"XTCountry";
//国家 code
static const NSString * _Nonnull XTCountryCode = @"XTCountryCode";
//省
static const NSString * _Nonnull XTProvince = @"XTProvince";
//市
static const NSString * _Nonnull XTCity = @"XTCity";
//区县
static const NSString * _Nonnull XTRegion = @"XTRegion";
//街道
static const NSString * _Nonnull XTStreet = @"XTStreet";
//维度
static const NSString * _Nonnull XTLatitude = @"XTLatitude";
//经度
static const NSString * _Nonnull XTLongitude = @"XTLongitude";

@interface XTLocationManger : NSObject

///维度
@property(nonatomic,copy) NSString *xt_latitude;
///经度
@property(nonatomic,copy) NSString *xt_longitude;

@property (nonatomic, copy) void (^LBSBlock)(void);
@property (nonatomic, copy) void (^LBSInfoBlock)(NSDictionary *infoDic,BOOL isSuccess);


+ (instancetype)xt_share;

//是否可以使用位置服务
- (BOOL)xt_canLocation;
//开始获取位置信息
- (BOOL)xt_startLocation;


@end

NS_ASSUME_NONNULL_END
