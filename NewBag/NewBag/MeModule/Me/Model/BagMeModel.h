//
//  BagMeModel.h
//  NewBag
//
//  Created by Jacky on 2024/3/29.
//

#import "BagBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BagMeRepayModel : BagBaseModel
@property (nonatomic, copy) NSString *hippomobileF;//order_no
@property (nonatomic, copy) NSString *alchemicalF;//date
@property (nonatomic, copy) NSString *percurrentF;//amount
@property (nonatomic, copy) NSString *insolvableF;//product_name
@property (nonatomic, copy) NSString *wholenessF;//icon
@property (nonatomic, copy) NSString *nonvoterF;//还款详情页
@end

@interface BagMeListItemModel : BagBaseModel
@property (nonatomic, copy) NSString *mudslingerF;//标题
@property (nonatomic, copy) NSString *wholenessF;//图标url
@property (nonatomic, copy) NSString *nonvoterF;//跳转 url
@property (nonatomic, copy) NSString *kielbasaF;//key
@end

@interface BagMeModel : BagBaseModel
@property (nonatomic, strong) BagMeRepayModel *careermanF;//逾期 model
@property (nonatomic, copy) NSArray <BagMeListItemModel *>*antidiphtheriticF;//list

@end

NS_ASSUME_NONNULL_END
