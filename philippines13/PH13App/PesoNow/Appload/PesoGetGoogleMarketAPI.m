//
//  PesoGetGoogleMarketAPI.m
//  PesoApp
//
//  Created by Jacky on 2024/9/10.
//

#import "PesoGetGoogleMarketAPI.h"

@implementation PesoGetGoogleMarketAPI
{
    NSDictionary *_dic;
}
- (instancetype)initWithData:(NSDictionary *)data
{
    if (self = [super init]) {
        _dic = data;
    }
    return self;
}

- (NSString *)requestUrl
{
    return  @"thirteencr/market";
}
- (NSTimeInterval)requestTimeoutInterval
{
    return 30;
}
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return _dic ? : @{};
}
@end
