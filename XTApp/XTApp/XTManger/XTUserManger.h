//
//  XTUserManger.h
//  XTApp
//
//  Created by xia on 2024/7/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTUserManger : NSObject

@property(nonatomic,strong) XTUserModel * __nullable xt_user;

+ (instancetype)xt_share;

+ (BOOL)xt_isLogin;

/**
 *  Custom 保存登录后的数据
 *
 *  @param dic         登录信息
 *
 */
- (void)xt_saveUserDic:(NSDictionary *)dic;
//退出登录
-(void)xt_loginOut;

@end

NS_ASSUME_NONNULL_END
