//
//  XTUserModel.h
//  XTApp
//
//  Created by xia on 2024/7/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTUserModel : NSObject

@property(nonatomic,copy) NSString *xt_isOld;
@property(nonatomic,copy) NSString *xt_smsMaxId;
@property(nonatomic,copy) NSString *xt_userId;
@property(nonatomic,copy) NSString *xt_phone;
@property(nonatomic,copy) NSString *xt_realname;

@property(nonatomic,copy) NSString *xt_token;
@property(nonatomic,copy) NSString *xt_userSessionid;
//是否是审核账号
@property(nonatomic) BOOL xt_is_aduit;

@end

NS_ASSUME_NONNULL_END
