//
//  PesoDeviceInfoAPI.m
//  PesoApp
//
//  Created by Jacky on 2024/9/12.
//

#import "PesoDeviceInfoAPI.h"

@implementation PesoDeviceInfoAPI
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
    return  @"thirteencr/device";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return _dic ? : @{};
}

@end
