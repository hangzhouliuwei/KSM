//
//  BagUserManager.h
//  NewBag
//
//  Created by Jacky on 2024/3/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BagUserModel : BagBaseModel
@property (nonatomic, assign) NSInteger phsifourteenographicalNc;//是否是 老用户
@property (nonatomic, assign) NSInteger heerfourteenochromaticNc;//

@property (nonatomic, assign) NSInteger bamyfourteenNc;//uid
@property (nonatomic, copy) NSString *stwafourteenrdessNc;//手机号
@property (nonatomic, assign) BOOL aoNcfourteen;//是否审核账号 true false
@property (nonatomic, copy) NSString  *tetofourteengenesisNc;//token
@property (nonatomic, copy) NSString  *fifofourteenotedNc;//sessionid
@end

@interface BagUserManager : NSObject
@property (nonatomic, strong) BagUserModel *model;
@property (nonatomic, assign) NSInteger chromatogramF;//是否是 老用户
@property (nonatomic, assign) NSInteger smsMaxId;//
@property (nonatomic, assign) NSInteger uid;//uid
@property (nonatomic, copy) NSString *username;//手机号
@property (nonatomic, assign) BOOL is_aduit;//是否审核账号 true false
@property (nonatomic, copy) NSString  *token;//token
@property (nonatomic, copy) NSString  *__nullable sessionid;//sessionid

@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, copy) NSString *order_numer;//临时用


+ (instancetype)shareInstance;

- (void)logout;
/**初始化用户数据**/
- (void)updateUserModelWithDic:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
