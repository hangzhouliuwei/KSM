//
//  PTBankModel.h
//  PTApp
//
//  Created by Jacky on 2024/8/21.
//

#import "PTBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTBankValue : PTBaseModel
@property(nonatomic, assign) NSInteger bltenthelyNc;//卡编号
@property(nonatomic, copy) NSString *ovtenrcutNc;//卡号
@end
@interface PTBankItemModel : PTBaseModel
@property(nonatomic, copy) NSString *uptenornNc;//name
@property(nonatomic, assign) NSInteger retengnNc;//编号
@property(nonatomic, copy) NSString *ietenNc;//icon 
@end
@interface PTBankWalletModel : PTBaseModel
@property(nonatomic, copy) NSArray <PTBankItemModel*>*untenrderlyNc;
@property(nonatomic, strong) PTBankValue *kotenNc;
@end

@interface PTBankBankModel : PTBaseModel
@property(nonatomic, copy) NSArray <PTBankItemModel*>*untenrderlyNc;
@property(nonatomic, strong) PTBankValue *kotenNc;
@end

@interface PTBankModel : PTBaseModel
@property(nonatomic, assign) NSInteger pateneographerNc;//倒计时
@property(nonatomic, strong) PTBankWalletModel *abtenentlyNc;
@property(nonatomic, strong) PTBankBankModel *mutenrayNc;
@end

NS_ASSUME_NONNULL_END
