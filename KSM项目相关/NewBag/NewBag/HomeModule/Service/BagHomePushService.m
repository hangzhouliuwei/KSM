//
//  BagHomePushService.m
//  NewBag
//
//  Created by Jacky on 2024/4/5.
//

#import "BagHomePushService.h"

@implementation BagHomePushService
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
    return @"fourteennv2/gce/push";
}
- (BOOL)isShowLoading
{
    return NO;
}
- (NSTimeInterval)requestTimeoutInterval
{
    return 30;
}
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
        @"spsmfourteenogenicNc":NotNull(_order_id),
        @"qunqfourteenuevalentNc":@"dddd",
        @"ditofourteenmeNc":@"houijhyus" // 干扰字段
    };
}
@end
