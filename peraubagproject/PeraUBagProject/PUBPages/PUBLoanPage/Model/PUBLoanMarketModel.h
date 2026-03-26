//
//  PUBLoanMarketModel.h
//  PeraUBagProject
//  贷超Model
//  Created by 刘巍 on 2023/12/25.
//

#import "PUBLoanBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PUBLoanMarketItemModel : PUBLoanBaseModel
///产品id
@property(nonatomic, copy) NSString *quilting_eg;
///产品名称
@property(nonatomic, copy) NSString *presenile_eg;
///产品logo
@property(nonatomic, copy) NSString *treasure_eg;
///申请按钮文字
@property(nonatomic, copy) NSString *flinders_eg;
///申请按钮颜色
@property(nonatomic, copy) NSString *principled_eg;
///产品额度
@property(nonatomic, copy) NSString *oolitic_eg;
///产品tag
@property(nonatomic, copy) NSArray <NSString*>*sappy_eg;
///产品描述
@property(nonatomic, copy) NSString *momentary_eg;
///产品名下面描述文字
@property(nonatomic, copy) NSString *indefensibly_eg;
///产品期限
@property(nonatomic, copy) NSString *telesale_eg;
///产品期限标题
@property(nonatomic, copy) NSString *pdd_eg;
///产品利率
@property(nonatomic, copy) NSString *extensive_eg;
///产品利率标题
@property(nonatomic, copy) NSString *hadrosaurus_eg;
///产品状态
@property(nonatomic, assign) NSInteger wireless_eg;
///产品类型 1 API 2 H5
@property(nonatomic, assign) NSInteger harmfulness_eg;
///今天是否点击 0否 1是
@property(nonatomic, assign) BOOL blaw_eg;
///最大额度
@property(nonatomic, copy) NSString *rashly_eg;
///产品利率
@property(nonatomic, copy) NSString *pinon_eg;
///期限logo
@property(nonatomic, copy) NSString *jalor_eg;
///利率logo
@property(nonatomic, copy) NSString *deadhouse_eg;
///右上角角标
@property(nonatomic, copy) NSString *homolysis_eg;
///是否显示进度条
@property(nonatomic, assign) BOOL saluki_eg;
///是否可点击
@property(nonatomic, assign) BOOL glaciated_eg;
@end

@interface PUBLoanMarketModel : PUBLoanBaseModel
@property(nonatomic, copy) NSString *vibronic_eg;
@property(nonatomic, copy) NSArray <PUBLoanMarketItemModel*>*obliterate_eg;
@end

NS_ASSUME_NONNULL_END
