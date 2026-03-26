//
//  PesoUserCenter.h
//  PesoApp
//
//  Created by Jacky on 2024/9/11.
//

#import <Foundation/Foundation.h>
#import "PesoBaseModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface PesoUserModel : PesoBaseModel
///老用户
@property(nonatomic, assign) NSInteger  phsithirteenographicalNc;
@property(nonatomic, assign) NSInteger  heerthirteenochromaticNc;
///uid
@property(nonatomic, copy) NSString *bamythirteenNc;
///手机号码
@property(nonatomic, copy) NSString *stwathirteenrdessNc;
@property(nonatomic, copy) NSString *edNcthirteen;
///token
@property(nonatomic, copy) NSString *tetothirteengenesisNc;
///sessionid
@property(nonatomic, copy) NSString *fifothirteenotedNc;
@property(nonatomic, assign) BOOL aoNcthirteen;
@end
@interface PesoUserCenter : NSObject
singleton_interface(PesoUserCenter)
@property(nonatomic, assign) NSInteger  isOld;
@property(nonatomic, assign) NSInteger  smsMaxId;
@property(nonatomic, copy) NSString *uid;
@property(nonatomic, copy) NSString *username;
@property(nonatomic, copy) NSString *realname;
@property(nonatomic, copy) NSString *token;
@property(nonatomic, copy) NSString *sessionid;
@property(nonatomic, assign) BOOL isaduit;
@property(nonatomic, copy) NSString *order;


- (void)initwithUserModelDic:(NSDictionary*)dic;

/// 判断是否登录
- (BOOL)isLogin;

///退出登录
- (void)logout;
@end

NS_ASSUME_NONNULL_END
