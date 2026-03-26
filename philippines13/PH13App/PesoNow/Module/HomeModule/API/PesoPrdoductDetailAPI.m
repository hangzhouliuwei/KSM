//
//  PesoDetailAPI.m
//  PesoApp
//
//  Created by Jacky on 2024/9/11.
//

#import "PesoPrdoductDetailAPI.h"

@implementation PesoPrdoductDetailAPI
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
    return @"thirteennv2/gce/detail";
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
        @"lietthirteenusNc":NotNil(_product_id),
    };
}
@end
