//
//  XTOrderListApi.h
//  XTApp
//
//  Created by xia on 2024/9/13.
//

#import "XTBaseApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface XTOrderListApi : XTBaseApi

@property(nonatomic,copy) NSString *xt_order_type;
@property(nonatomic) NSInteger xt_page_num;
@property(nonatomic,readonly) NSInteger xt_page_size;

@end

NS_ASSUME_NONNULL_END
