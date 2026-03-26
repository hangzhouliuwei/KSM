//
//  PUBLoanApplyModel.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/27.
//

#import "PUBBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PUBLoanApplyModel : PUBBaseModel
@property(nonatomic, copy) NSString *furnisher_eg;
@property(nonatomic, copy) NSString *bud_eg;
@property(nonatomic, copy) NSString *dressage_eg;
@property(nonatomic, copy) NSString *lobsterman_eg;
/// 0 不跳详情 1 跳转详情
@property(nonatomic, assign) BOOL exotropia_eg;
///advance accessKey
@property(nonatomic, copy) NSString *auris_eg;
///advance  secretKey
@property(nonatomic, copy) NSString *traumatropism_eg;
///0 不上报 1上报通讯录数据 2 上报设备数据和通讯录数据
@property(nonatomic, assign) NSInteger stalactite_eg;
///是否显示认证详情页 0 不显示，1显示
@property(nonatomic, assign) BOOL yyusnss_eg;
@end

NS_ASSUME_NONNULL_END
