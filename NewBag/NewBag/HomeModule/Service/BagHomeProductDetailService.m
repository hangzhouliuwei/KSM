//
//  BagHomeProductDetailService.m
//  NewBag
//
//  Created by Jacky on 2024/3/27.
//

#import "BagHomeProductDetailService.h"

@implementation BagHomeProductDetailService
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
    return @"fee/detail";
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
        @"vachelF":NotNull(_product_id),
    };
}
@end
