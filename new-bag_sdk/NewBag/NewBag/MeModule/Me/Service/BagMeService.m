//
//  BagMeService.m
//  NewBag
//
//  Created by Jacky on 2024/3/27.
//

#import "BagMeService.h"

@implementation BagMeService

- (NSString *)requestUrl {
    return @"ffhh/home";
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
    return @{
    };
}
@end
