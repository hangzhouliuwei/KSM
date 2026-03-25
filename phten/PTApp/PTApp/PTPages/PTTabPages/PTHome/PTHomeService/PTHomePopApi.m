//
//  PTHomePopApi.m
//  PTApp
//
//  Created by Jacky on 2024/8/29.
//

#import "PTHomePopApi.h"

@implementation PTHomePopApi
- (NSString *)requestUrl {
    return @"tench/pop-up";
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
