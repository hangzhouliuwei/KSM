//
//  XTOrderModel.h
//  XTApp
//
//  Created by xia on 2024/9/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTOrderModel : NSObject

@property(nonatomic,copy) NSString *xt_orderId;
@property(nonatomic,copy) NSString *xt_productId;
@property(nonatomic,copy) NSString *xt_inside;
@property(nonatomic,copy) NSString *xt_productName;
@property(nonatomic,copy) NSString *xt_productLogo;

@property(nonatomic,copy) NSString *xt_orderStatus;
///订单状态展示字段
@property(nonatomic,copy) NSString *xt_orderStatusDesc;
@property(nonatomic,copy) NSString *xt_orderStatusColor;
///订单金额
@property(nonatomic,copy) NSString *xt_orderAmount;
///跳转地址
@property(nonatomic,copy) NSString *xt_loanDetailUrl;

///按钮文字展示，为空时不展示按钮
@property(nonatomic,copy) NSString *xt_buttonText;
@property(nonatomic,copy) NSString *xt_buttonBackground;
///到期时间，为空不展示
@property(nonatomic,copy) NSString *xt_repayTime;
///是否显示认证详情页 0 不显示，1显示
@property(nonatomic) BOOL xt_showVerification;

@end

NS_ASSUME_NONNULL_END
