//
//  PUBProductDetailModel.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/29.
//

#import "PUBBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PUBHexobioseEgModel : PUBBaseModel
///产品id
@property(nonatomic, copy) NSString *quilting_eg;
///产品名称
@property(nonatomic, copy) NSString *presenile_eg;
///订单号
@property(nonatomic, copy) NSString *checker_eg;
///订单id
@property(nonatomic, copy) NSString *hypokinesis_eg;
///金额
@property(nonatomic, copy) NSString *moot_eg;

@end
@interface PUBVerifyItemModel : PUBBaseModel
///标题
@property(nonatomic, copy) NSString *neanderthaloid_eg;
///是否已完成
@property(nonatomic, assign) BOOL vertebration_eg;
///logo
@property(nonatomic, copy) NSString *keten_eg;
///跳转页面
@property(nonatomic, copy) NSString *kumpit_eg;
@end

@interface PUBNextStepModel : PUBBaseModel
@property(nonatomic, copy) NSString *hindoo_eg;
@property(nonatomic, copy) NSString *lobsterman_eg;
@property(nonatomic, copy) NSString *vibronic_eg;
@property(nonatomic, copy) NSString *neanderthaloid_eg;
@property(nonatomic, copy) NSString *excuse;
@end

@interface PUBProductDetailModel : PUBBaseModel
@property(nonatomic, copy) NSArray <PUBVerifyItemModel*>*allochthonous_eg;
//下一步
@property(nonatomic, strong) PUBNextStepModel *specifiable_eg;
//订单集合
@property(nonatomic, strong) PUBHexobioseEgModel *hexobiose_eg;
@end

NS_ASSUME_NONNULL_END
