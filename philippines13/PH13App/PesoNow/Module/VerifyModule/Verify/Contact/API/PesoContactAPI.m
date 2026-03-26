//
//  PesoContactAPI.m
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import "PesoContactAPI.h"

@implementation PesoContactAPI
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
    return @"thirteenca/contact";
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
        @"seisthirteenacredNc": @"blaalleynk" // 干扰字
    };
}
@end
