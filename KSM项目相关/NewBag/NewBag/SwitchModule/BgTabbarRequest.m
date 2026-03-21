//
//  BgTabbarRequest.m
//  NewBag
//
//  Created by Kiven on 2024/8/21.
//

#import "BgTabbarRequest.h"

@implementation BgTabbarRequest

- (NSString *)requestUrl {
    return @"facetype";
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
    return YTKRequestMethodGET;
}

- (id)requestArgument {
    return @{};
}

@end
