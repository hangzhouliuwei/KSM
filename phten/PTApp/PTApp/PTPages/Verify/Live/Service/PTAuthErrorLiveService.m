//
//  PTAuthErrorLiveService.m
//  PTApp
//
//  Created by Jacky on 2024/8/21.
//

#import "PTAuthErrorLiveService.h"

@implementation PTAuthErrorLiveService
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
    return PTLiveError;
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
        @"datenrymanNc":(_error),
    };
}

@end
