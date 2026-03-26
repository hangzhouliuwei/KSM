//
//  XTRepaymentModel.h
//  XTApp
//
//  Created by xia on 2024/9/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTRepaymentModel : NSObject

@property(nonatomic,copy) NSString *xt_order_no;
@property(nonatomic,copy) NSString *xt_product_id;
@property(nonatomic,copy) NSString *xt_date;
@property(nonatomic,copy) NSString *xt_amount;
@property(nonatomic,copy) NSString *xt_product_name;

@property(nonatomic,copy) NSString *xt_icon;
@property(nonatomic,copy) NSString *xt_url;
@end

NS_ASSUME_NONNULL_END
