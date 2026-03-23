//
//  PTMineNcModel.h
//  PTApp
//
//  Created by 刘巍 on 2024/8/12.
//

#import "PTHomeBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTMineNcModel : PTHomeBaseModel
///订单id
@property(nonatomic, copy) NSString *sptensmogenicNc;
///产品id
@property(nonatomic, copy) NSString *lielevenetusNc;
///到期日期
@property(nonatomic, copy) NSString *acteneptablyNc;
///金额
@property(nonatomic, copy) NSString *geteneralitatNc;
///产品名称
@property(nonatomic, copy) NSString *hatenryNc;
///产品图标
@property(nonatomic, copy) NSString *ietenNc;
///还款详情页
@property(nonatomic, copy) NSString *retenloomNc;
@end

NS_ASSUME_NONNULL_END
