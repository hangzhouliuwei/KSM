//
//  PTBasicVerifyService.m
//  PTApp
//
//  Created by Jacky on 2024/8/21.
//

#import "PTBasicVerifyService.h"

@implementation PTBasicVerifyService
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
    return PTInitBasic;
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
        @"litenetusNc":_product_id ? : @"",
        @"butennableNc":@"stauistill"//干扰
    };
}
@end
