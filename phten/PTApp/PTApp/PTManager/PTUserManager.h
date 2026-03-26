//
//  PTUserManager.h
//  PTApp
//
//  Created by 刘巍 on 2024/7/19.
//

#import <Foundation/Foundation.h>
#import "PTBaseModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface PTUserModel : PTBaseModel
///是否是老用户
@property(nonatomic, assign) NSInteger  phtensiographicalNc;
@property(nonatomic, assign) NSInteger  hetenerochromaticNc;
///uid
@property(nonatomic, copy) NSString *batenmyNc;
///手机号码
@property(nonatomic, copy) NSString *sttenwardessNc;
@property(nonatomic, copy) NSString *edtenNc;
///token
@property(nonatomic, copy) NSString *tetentogenesisNc;
///sessionid
@property(nonatomic, copy) NSString *fitenfootedNc;
@property(nonatomic, assign) BOOL aotenNc;
@end

#define PTUser [PTUserManager sharedUser]
@interface PTUserManager : NSObject
@property(nonatomic, assign) NSInteger  isOld;
@property(nonatomic, assign) NSInteger  smsMaxId;
@property(nonatomic, copy) NSString *uid;
@property(nonatomic, copy) NSString *username;
@property(nonatomic, copy) NSString *realname;
@property(nonatomic, copy) NSString *token;
@property(nonatomic, copy) NSString *sessionid;
@property(nonatomic, assign) BOOL isaduit;
@property(nonatomic, copy) NSString *oder;

+ (PTUserManager *)sharedUser;

- (void)initwithUserModelDic:(NSDictionary*)dic;

/// 判断是否登录
- (BOOL)isLogin;

///退出登录
- (void)logoutServer;
@end

NS_ASSUME_NONNULL_END
