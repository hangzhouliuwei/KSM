//
//  BagVerifyLiveAuthService.m
//  NewBag
//
//  Created by Jacky on 2024/4/8.
//

#import "BagVerifyLiveAuthService.h"

@implementation BagVerifyLiveAuthService
- (NSString *)requestUrl {
    return @"fourteenca/license";
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
