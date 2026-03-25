//
//  PesoLiveLimitAPI.m
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import "PesoLiveLimitAPI.h"

@implementation PesoLiveLimitAPI
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
    return @"thirteenca/limit";
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
        @"lietthirteenusNc":(_product_id),
    };
}
@end
