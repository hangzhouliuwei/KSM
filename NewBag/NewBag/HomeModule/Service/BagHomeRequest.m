//
//  BagHomeRequest.m
//  NewBag
//
//  Created by Jacky on 2024/3/12.
//

#import "BagHomeRequest.h"

@implementation BagHomeRequest

- (NSString *)requestUrl {
    return @"fourteench/index";
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
