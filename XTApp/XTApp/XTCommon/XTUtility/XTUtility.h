//
//  XTUtility.h
//  XTApp
//
//  Created by xia on 2024/7/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTUtility : NSObject

+(instancetype)xt_share;

///显示菊花
+ (void)xt_showProgress:(UIView *)view message:(NSString *)msg;

///隐藏菊花
+ (void)xt_hideProgress:(UIView*)view;
+ (void)xt_atHideProgress:(UIView*)view;
/// 对象转为json格式String
+ (NSString *)xt_objectToJSONString:(id)obj;

+ (void)xt_showTips:(NSString *)str view:(UIView* _Nullable)view;

///删除文件
- (void)xt_removeFileWithPath:(NSString *)path;

+ (NSString *)xt_urlEncode:(NSString *)urlStr;

//当前时间戳
- (NSString *)xt_nowTimeStamp;

///保存图片
- (NSString *)xt_saveImg:(NSData *)imgData path:(NSString *)path;

/// 获取当前VC
+ (UIViewController *)xt_getCurrentVCInNav;

/// 相册权限
+ (void)xt_checkPhotoAuthorization:(void (^)(BOOL resultBool))successBlock;
/// 相机权限
+ (void)xt_checkAVCaptureAuthorization:(void (^)(BOOL resultBool))successBlock;

+ (id)xt_objectFromJSON:(id)json;

+ (void)xt_login:(XTBlock _Nullable)block;

@end

NS_ASSUME_NONNULL_END
