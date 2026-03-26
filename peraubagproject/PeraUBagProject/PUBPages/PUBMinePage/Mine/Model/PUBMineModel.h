//
//  PUBMineModel.h
//  PeraUBagProject
//
//  Created by Jacky on 2024/1/15.
//

#import "PUBBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface PUBMineListItemModel : PUBBaseModel
@property (nonatomic,copy) NSString *lobsterman_eg;//跳转 url
@property (nonatomic,copy) NSString *neanderthaloid_eg;//标题
@property (nonatomic,copy) NSString *unbuild_eg;//图标地址
@end

@interface PUBMineOrderModel : PUBBaseModel
@property (nonatomic,copy) NSString *mitteleuropean_eg;//产品名
@property (nonatomic,copy) NSString *darfur_eg;//订单号
@property (nonatomic,copy) NSString *ovalbumin_eg;//还款时间
@property (nonatomic,copy) NSString *unbuild_eg;//产品 logo
@property (nonatomic,copy) NSString *moot_eg;//金额
@property (nonatomic,copy) NSString *lobsterman_eg;//还款详情跳转 url
@end

@interface PUBMineModel : PUBBaseModel
@property (nonatomic, strong) NSArray <PUBMineListItemModel *> *cockateel_eg;
@property (nonatomic, strong) PUBMineOrderModel *owly_eg;//还款提醒
@end

NS_ASSUME_NONNULL_END
