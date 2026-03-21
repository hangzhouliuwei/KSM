//
//  BagBankModel.h
//  NewBag
//
//  Created by Jacky on 2024/4/9.
//

#import "BagBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface BagBankValue : BagBaseModel
@property(nonatomic, assign) NSInteger blthfourteenelyNc;
@property(nonatomic, copy) NSString *ovrcfourteenutNc;
@end
@interface BagBankItemModel : BagBaseModel
@property(nonatomic, copy) NSString *uporfourteennNc;//name
@property(nonatomic, copy) NSString *ieNcfourteen;//图标
@property(nonatomic, assign) NSInteger regnfourteenNc;//编号
@end
@interface BagBankWalletModel : BagBaseModel
@property(nonatomic, copy) NSArray <BagBankItemModel*>*unrdfourteenerlyNc;
@property(nonatomic, strong) BagBankValue *koNcfourteen;
@end

@interface BagBankBankModel : BagBaseModel
@property(nonatomic, copy) NSArray <BagBankItemModel*>*unrdfourteenerlyNc;
@property(nonatomic, strong) BagBankValue *koNcfourteen;
@end

@interface BagBankModel : BagBaseModel
@property(nonatomic, assign) NSInteger paeofourteengrapherNc;//倒计时
@property(nonatomic, strong) BagBankWalletModel *abenfourteentlyNc;
@property(nonatomic, strong) BagBankBankModel *murafourteenyNc;
@end

NS_ASSUME_NONNULL_END
