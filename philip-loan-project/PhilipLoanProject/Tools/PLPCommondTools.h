//
//  Tools.h
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/26.
//

#import <Foundation/Foundation.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>

NS_ASSUME_NONNULL_BEGIN

@interface PLPCommondTools : NSObject


+(void)tapItemWithProductID:(NSString *)productID;

+(void)requestInfoWithProductId:(NSString *)productID;

+(void)resetKeyWindowRootViewController:(id)viewConttoller;

+(void)queryURLWithOrderNo:(NSString *)orderNo;
+(void)pushToPage:(NSString *)pageName productID:(NSString *)productID;
+(void)uploadContactInfo;
+(void)uploadDeviceInfo;

+(void)clearCurrentNavigationStack:(UIViewController *)vc;

+(NSString *)getDeviceIDFV;
+(NSString *)getDeviceUUID;

+(NSString *)getCurrentTimeStamp;

+(NSString *)formatterUnitValue:(NSString *)value;
+(NSString *)generateRandomString;
+(NSString *)formatterValue:(NSString *)value;


+(NSString *)fetchShortVersion;
+(NSString *)fetchBuildVersion;

+(NSString *)getDeviceModelName;
+(void)fetchIDFASuccess:(void(^)(NSString *idfa))success;

/// 修复首次获取idfa错误
+ (void)phFixTrackingAuthorizationWithCompletion:(void (^)(ATTrackingManagerAuthorizationStatus status))completion API_AVAILABLE(ios(14));

+(NSDictionary*)parameFromURL:(NSURL *)url;

+ (NSString *)urlZhEncode:(NSString *)urlStr;

//请求相机权限
+(void)requestCameraAuthority:(void (^)(BOOL granted))success;
//请求相册权限
+(void)requestAlbumAuthority:(void (^)(BOOL granted))success;

@end

NS_ASSUME_NONNULL_END
