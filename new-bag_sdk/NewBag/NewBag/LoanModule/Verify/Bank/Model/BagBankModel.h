//
//  BagBankModel.h
//  NewBag
//
//  Created by Jacky on 2024/4/9.
//

#import "BagBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface BagBankValue : BagBaseModel
@property(nonatomic, assign) NSInteger autoinfectionF;
@property(nonatomic, copy) NSString *fetoproteinF;
@end
@interface BagBankItemModel : BagBaseModel
@property(nonatomic, copy) NSString *antineoplastonF;//name
@property(nonatomic, copy) NSString *wholenessF;//图标
@property(nonatomic, assign) NSInteger franticF;//编号
@end
@interface BagBankWalletModel : BagBaseModel
@property(nonatomic, copy) NSArray <BagBankItemModel*>*heelF;
@property(nonatomic, strong) BagBankValue *incessantF;
@end

@interface BagBankBankModel : BagBaseModel
@property(nonatomic, copy) NSArray <BagBankItemModel*>*heelF;
@property(nonatomic, strong) BagBankValue *incessantF;
@end

@interface BagBankModel : BagBaseModel
@property(nonatomic, assign) NSInteger analectaF;//倒计时
@property(nonatomic, strong) BagBankWalletModel *fullnessF;
@property(nonatomic, strong) BagBankBankModel *begirdF;
@end

NS_ASSUME_NONNULL_END
