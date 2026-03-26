//
//  PesoMineModel.h
//  PesoApp
//
//  Created by Jacky on 2024/9/18.
//

#import "PesoBaseModel.h"
#import "PesoHomeBaseModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface PesoMineRepayModel : PesoHomeBaseModel
///订单id
@property(nonatomic, copy) NSString *spsmthirteenogenicNc;
///产品id
@property(nonatomic, copy) NSString *lietthirteenusNc;
///到期日期
@property(nonatomic, copy) NSString *acepthirteentablyNc;
///金额
@property(nonatomic, copy) NSString *geerthirteenalitatNc;
///产品名称
@property(nonatomic, copy) NSString *harythirteenNc;
///产品图标
@property(nonatomic, copy) NSString *ieNcthirteen;
///还款详情页
@property(nonatomic, copy) NSString *relothirteenomNc;
@end
@interface PesoMineItemModel : PesoHomeBaseModel
///标题
@property(nonatomic, copy) NSString *fldgthirteeneNc;
///图标
@property(nonatomic, copy) NSString *ieNcthirteen;
///跳转地址
@property(nonatomic, copy) NSString *relothirteenomNc;
@end
@interface PesoMineModel : PesoBaseModel
///会员图标
@property(nonatomic, copy) NSString *deenthirteensiveNc;
@property(nonatomic, copy) NSArray <PesoMineItemModel*>*getithirteencNc;
///逾期提醒
@property(nonatomic, strong) PesoMineRepayModel *unquthirteenalizeNc;
@end

NS_ASSUME_NONNULL_END
