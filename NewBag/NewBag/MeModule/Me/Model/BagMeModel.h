//
//  BagMeModel.h
//  NewBag
//
//  Created by Jacky on 2024/3/29.
//

#import "BagBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BagMeRepayModel : BagBaseModel
@property (nonatomic, copy) NSString *spsmfourteenogenicNc;//order_no
@property (nonatomic, copy) NSString *acepfourteentablyNc;//date
@property (nonatomic, copy) NSString *geerfourteenalitatNc;//amount
@property (nonatomic, copy) NSString *haryfourteenNc;//product_name
@property (nonatomic, copy) NSString *ieNcfourteen;//icon
@property (nonatomic, copy) NSString *relofourteenomNc;//还款详情页
@end

@interface BagMeListItemModel : BagBaseModel
@property (nonatomic, copy) NSString *fldgfourteeneNc;//标题
@property (nonatomic, copy) NSString *ieNcfourteen;//图标url
@property (nonatomic, copy) NSString *relofourteenomNc;//跳转 url
@property (nonatomic, copy) NSString *emttfourteenerNc;//key
@end

@interface BagMeModel : BagBaseModel
@property (nonatomic, strong) BagMeRepayModel *unqufourteenalizeNc;//逾期 model
@property (nonatomic, copy) NSArray <BagMeListItemModel *>*mehafourteenemoglobinNc;//list

@end

NS_ASSUME_NONNULL_END
