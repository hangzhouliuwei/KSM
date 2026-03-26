//
//  BagHomeOpenService.m
//  NewBag
//
//  Created by Jacky on 2024/4/28.
//

#import "BagHomeOpenService.h"

@implementation BagHomeOpenService
- (NSString *)requestUrl {
    return @"ffhh/pop-up";
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
