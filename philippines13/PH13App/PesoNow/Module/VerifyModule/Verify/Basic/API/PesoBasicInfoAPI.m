//
//  PesoBasicInfoAPI.m
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import "PesoBasicInfoAPI.h"

@implementation PesoBasicInfoAPI
{
    NSString *_product_id;
}
- (instancetype)initWithData:(NSString *)data
{
    if (self = [super init]) {
        _product_id = data;
    }
    return self;
}
- (NSString *)requestUrl {
    return @"thirteenca/person";
}
- (BOOL)showLoading
{
    return YES;
}
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
        @"lietthirteenusNc":_product_id ? : @"",
        @"bunathirteenbleNc":@"stauistill"//干扰
    };
}
@end
