//
//  PesoOrderPushAPI.m
//  PesoApp
//
//  Created by Jacky on 2024/9/11.
//

#import "PesoOrderPushAPI.h"

@implementation PesoOrderPushAPI
{
    NSString *_order_id;
}

- (instancetype)initWithOrderId:(NSString *)order_id
{
    if (self = [super init]) {
        _order_id = order_id;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"thirteennv2/gce/push";
}
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
- (BOOL)showLoading
{
    return YES;
}
- (id)requestArgument {
    return @{
        @"spsmthirteenogenicNc":NotNil(_order_id),
        @"qunqthirteenuevalentNc":@"dddd", // 期限类型
        @"ditothirteenmeNc":@"houijhyus" // 干扰字段
    };
}
@end
