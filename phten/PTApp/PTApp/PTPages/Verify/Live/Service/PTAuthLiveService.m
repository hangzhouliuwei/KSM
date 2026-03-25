//
//  PTAuthLiveService.m
//  PTApp
//
//  Created by Jacky on 2024/8/21.
//

#import "PTAuthLiveService.h"

@implementation PTAuthLiveService
- (NSString *)requestUrl {
    return PTLicenseLive;
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
