//
//  XTOrderListApi.m
//  XTApp
//
//  Created by xia on 2024/9/13.
//

#import "XTOrderListApi.h"

@interface XTOrderListApi()



@end

@implementation XTOrderListApi

- (instancetype)init{
    self = [super init];
    if(self) {
        self.xt_page_num = 1;
        _xt_page_size = 20;
    }
    return self;
}

- (NSString *)requestUrlToBeAddQueryParameter {
    return [self urlAppendQueryParameterToUrl:@"ph/loan/order-list"];;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument{
    return @{
        @"hafbsixackNc":XT_Object_To_Stirng(self.xt_order_type),
        @"leitsiximismNc":[NSString stringWithFormat:@"%ld",self.xt_page_num],
        @"catosixnizationNc":[NSString stringWithFormat:@"%ld",self.xt_page_size],
    };
}


@end
