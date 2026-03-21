//
//  BagVerifyBasicService.m
//  NewBag
//
//  Created by Jacky on 2024/4/6.
//

#import "BagVerifyBasicService.h"

@implementation BagVerifyBasicService
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
    return @"fourteenca/person";
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
        @"lietfourteenusNc":NotNull(_product_id),
        @"bunafourteenbleNc":@"stauistill"//干扰
    };
}
@end
