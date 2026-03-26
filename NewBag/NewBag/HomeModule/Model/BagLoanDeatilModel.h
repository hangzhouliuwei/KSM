//
//  BagLoanDeatilModel.h
//  NewBag
//
//  Created by Jacky on 2024/4/5.
//

#import "BagBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface BagProductDetailModel : BagBaseModel
///产品id
@property(nonatomic, copy) NSString *franticF;
///产品名称
@property(nonatomic, copy) NSString *shapelinessF;
///订单号
@property(nonatomic, copy) NSString *indifferentismF;
///订单id
@property(nonatomic, copy) NSString *antimonateF;
///金额
@property(nonatomic, copy) NSString *percurrentF;

@end
@interface BagVerifyItemModel : BagBaseModel
///标题
@property(nonatomic, copy) NSString *mudslingerF;
///是否已完成
@property(nonatomic, assign) BOOL thermionicF;
///logo
@property(nonatomic, copy) NSString *oroideF;

@property(nonatomic, copy) NSString *pulsationF;
///跳转url
@property(nonatomic, copy) NSString *nonvoterF;

@end

@interface BagNextStepModel : BagBaseModel
@property(nonatomic, copy) NSString *lensedF;//
@property(nonatomic, copy) NSString *nonvoterF;//地址
@property(nonatomic, assign) NSInteger nortriptylineF;
@property(nonatomic, copy) NSString *mudslingerF;//标题
@property(nonatomic, copy) NSString *excuse;
@end

@interface BagLoanDeatilModel : BagBaseModel
@property(nonatomic, copy) NSArray <BagVerifyItemModel*>*sportyF;
//下一步
@property(nonatomic, strong) BagNextStepModel *peacemongerF;
//订单集合
@property(nonatomic, strong) BagProductDetailModel *succussiveF;
@end

NS_ASSUME_NONNULL_END
