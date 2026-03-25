//
//  PTHomeFeeDetailService.m
//  PTApp
//
//  Created by Jacky on 2024/8/23.
//

#import "PTHomeGCeDetailService.h"

@implementation PTHomeGCeDetailService
{
    NSString *_product_id;
}

- (instancetype)initWithProductId:(NSString *)product_id
{
    if (self = [super init]) {
        _product_id = product_id;
    }
    return self;
}

- (NSString *)requestUrl {
    return PTHomeDetail;
}
- (BOOL)isShowLoading
{
    return YES;
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
        @"litenetusNc":PTNotNull(_product_id),
    };
}
@end
