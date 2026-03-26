//
//  PesoUploadLocationAPI.m
//  PesoApp
//
//  Created by Jacky on 2024/9/11.
//

#import "PesoUploadLocationAPI.h"

@implementation PesoUploadLocationAPI
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
    return  @"thirteencr/location";
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
