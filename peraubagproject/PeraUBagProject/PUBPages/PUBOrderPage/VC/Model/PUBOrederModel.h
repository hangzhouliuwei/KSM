//
//  PUBOrederModel.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/15.
//

#import "PUBBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface PUBOrederItemModel : PUBBaseModel
@property(nonatomic, assign) NSInteger  hypokinesis_eg;
///productId
@property(nonatomic, copy) NSString  *grouse_eg;
@property(nonatomic, assign) NSInteger  incogitable_eg;
@property(nonatomic, copy) NSString *presenile_eg;
@property(nonatomic, copy) NSString *treasure_eg;
@property(nonatomic, copy) NSString *croquignole_eg;
///订单状态展示字段
@property(nonatomic, copy) NSString *parvus_eg;
///订单状态字体颜色
@property(nonatomic, copy) NSString *diphenylketone_eg;
///订单金额
@property(nonatomic, copy) NSString *proconsulate_eg;
///跳转地址
@property(nonatomic, copy) NSString *bale_eg;
///按钮文字展示，为空时不展示按钮
@property(nonatomic, copy) NSString *flinders_eg;
///按钮背景色
@property(nonatomic, copy) NSString *ninogan_eg;
///到期时间，为空不展示
@property(nonatomic, copy) NSString *pinxit_eg;
///是否显示认证详情页 0 不显示，1显示
@property(nonatomic, assign) BOOL yyusnss_eg;

@property(nonatomic, assign) NSInteger cellHeght;
@end
@interface PUBOrederModel : PUBBaseModel
@property(nonatomic, copy) NSString *isogamous_eg;
@property(nonatomic, copy) NSArray <PUBOrederItemModel*>*somesuch_eg;
@end

NS_ASSUME_NONNULL_END
