//
//  PesoBankModel.h
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import "PesoBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface PesoBankValue : PesoBaseModel
@property(nonatomic, assign) NSInteger blththirteenelyNc;//卡编号
@property(nonatomic, copy) NSString *ovrcthirteenutNc;//卡号
@end
@interface PesoBankItemModel : PesoBaseModel
@property(nonatomic, copy) NSString *uporthirteennNc;//name
@property(nonatomic, assign) NSInteger regnthirteenNc;//编号
@property(nonatomic, copy) NSString *ieNcthirteen;//icon
@end
@interface PesoBankWalletModel : PesoBaseModel
@property(nonatomic, copy) NSArray <PesoBankItemModel*>*unrdthirteenerlyNc;
@property(nonatomic, strong) PesoBankValue *koNcthirteen;
@end

@interface PesoBankBankModel : PesoBaseModel
@property(nonatomic, copy) NSArray <PesoBankItemModel*>*unrdthirteenerlyNc;
@property(nonatomic, strong) PesoBankValue *koNcthirteen;
@end

@interface PesoBankModel : PesoBaseModel
@property(nonatomic, assign) NSInteger pateneographerNc;//倒计时
@property(nonatomic, strong) PesoBankWalletModel *abenthirteentlyNc;
@property(nonatomic, strong) PesoBankBankModel *murathirteenyNc;
@end

NS_ASSUME_NONNULL_END
