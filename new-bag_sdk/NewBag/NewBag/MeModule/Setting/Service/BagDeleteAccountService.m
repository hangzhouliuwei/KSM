//
//  BagDeleteAccountService.m
//  NewBag
//
//  Created by Jacky on 2024/3/31.
//

#import "BagDeleteAccountService.h"

@implementation BagDeleteAccountService


- (NSString *)requestUrl {
    return @"ffcp/logout";
}
- (BOOL)isShowLoading
{
    return YES;
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
