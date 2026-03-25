//
//  PTDeviceService.m
//  PTApp
//
//  Created by 刘巍 on 2024/7/19.
//

#import "PTDeviceService.h"

@implementation PTDeviceService

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
    return  PTUpdateDevice;
}
- (BOOL)isShowLoading
{
    return NO;
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
