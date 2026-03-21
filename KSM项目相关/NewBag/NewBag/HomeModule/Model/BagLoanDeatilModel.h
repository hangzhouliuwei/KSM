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
@property(nonatomic, copy) NSString *regnfourteenNc;
///产品名称
@property(nonatomic, copy) NSString *moosfourteenyllabismNc;
///订单号
@property(nonatomic, copy) NSString *cokefourteentNc;
///订单id
@property(nonatomic, copy) NSString *sttefourteenhoodNc;
///金额
@property(nonatomic, copy) NSString *geerfourteenalitatNc;

@end
@interface BagVerifyItemModel : BagBaseModel
///标题
@property(nonatomic, copy) NSString *fldgfourteeneNc;
///是否已完成
@property(nonatomic, assign) BOOL frllfourteenyNc;
///logo
@property(nonatomic, copy) NSString *doabfourteenleNc;

@property(nonatomic, copy) NSString *noasfourteensessabilityNc;
///跳转url
@property(nonatomic, copy) NSString *relofourteenomNc;

@end

@interface BagNextStepModel : BagBaseModel
@property(nonatomic, copy) NSString *lensedF;//
@property(nonatomic, copy) NSString *relofourteenomNc;//地址
@property(nonatomic, assign) NSInteger itlifourteenanizeNc;
@property(nonatomic, copy) NSString *fldgfourteeneNc;//标题
@property(nonatomic, copy) NSString *excuse;
@end

@interface BagLoanDeatilModel : BagBaseModel
@property(nonatomic, copy) NSArray <BagVerifyItemModel*>*atesfourteeniaNc;
//下一步
@property(nonatomic, strong) BagNextStepModel *heisfourteentopNc;
//订单集合
@property(nonatomic, strong) BagProductDetailModel *leonfourteenishNc;
@end

NS_ASSUME_NONNULL_END
