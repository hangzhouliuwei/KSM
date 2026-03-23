//
//  XTRepaymentModel.m
//  XTApp
//
//  Created by xia on 2024/9/12.
//

#import "XTRepaymentModel.h"

@implementation XTRepaymentModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
        @"xt_order_no" : @"spsmsixogenicNc",
        @"xt_product_id" : @"lietsixusNc",
        @"xt_date" : @"acepsixtablyNc",
        @"xt_amount" : @"geersixalitatNc",
        @"xt_product_name" : @"harysixNc",
        @"xt_icon" : @"ieNcsix",
        @"xt_url" : @"relosixomNc",
    };
}

@end
