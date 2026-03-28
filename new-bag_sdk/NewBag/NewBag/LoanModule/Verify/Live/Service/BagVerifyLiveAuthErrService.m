//
//  BagVerifyLiveAuthErrService.m
//  NewBag
//
//  Created by Jacky on 2024/4/8.
//

#import "BagVerifyLiveAuthErrService.h"

@implementation BagVerifyLiveAuthErrService
{
    NSString *_error;
}
- (instancetype)initWithError:(NSString *)error
{
    if (self = [super init]) {
        _error = error;
    }
    return self;
}
- (NSString *)requestUrl {
    return @"fca/auth";
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
    return @{
        @"lorrieF":NotNull(_error),
    };
}

@end
