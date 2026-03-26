//
//  PTHomeGCePushService.m
//  PTApp
//
//  Created by Jacky on 2024/8/23.
//

#import "PTHomeGCePushService.h"

@implementation PTHomeGCePushService
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
    return @"tennv2/gce/push";
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
        @"sptensmogenicNc":PTNotNull(_order_id),
        @"qutennquevalentNc":@"dddd", // 期限类型
        @"ditentomeNc":@"houijhyus" // 干扰字段
    };
}
@end
