//
//  PUBUserManager.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/23.
//

#import <Foundation/Foundation.h>
#import "PUBBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface PUBUserModel : PUBBaseModel
///是否是老用户
@property(nonatomic, assign) BOOL uniface_eg;
@property(nonatomic, assign) BOOL altruism_eg;
///用户ID
@property(nonatomic, assign) NSInteger sofa_eg;
///用户名
@property(nonatomic, copy) NSString *electrologist_eg;
///用户昵称
@property(nonatomic, copy) NSString *clx_eg;
///用户令牌(token)
@property(nonatomic, copy) NSString *hairsbreadth_eg;
///用户sessionid
@property(nonatomic, copy) NSString *quizzicality_eg;

@property(nonatomic, assign) BOOL chloe_eg;
@end

#define User [PUBUserManager sharedUser]
@interface PUBUserManager : NSObject
@property(nonatomic, assign) BOOL isOld;
@property(nonatomic, assign) BOOL smsMaxId;
@property(nonatomic, assign) NSInteger uid;
@property(nonatomic, copy) NSString *username;
@property(nonatomic, copy) NSString *realname;
@property(nonatomic, copy) NSString *token;
@property(nonatomic, copy) NSString *sessionid;
@property(nonatomic, assign) BOOL is_aduit;

+ (PUBUserManager *)sharedUser;
//缓存里获取用户信息
- (void)initUser;
// 判断是否登录
- (BOOL)isLogin;
//退出登录
- (void)logoutCallServer;

@end

NS_ASSUME_NONNULL_END
