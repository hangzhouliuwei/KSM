//
//  PesoLiveAuthAPI.m
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import "PesoLiveAuthAPI.h"

@implementation PesoLiveAuthAPI
- (NSString *)requestUrl {
    return @"thirteenca/license";
}
- (BOOL)showLoading
{
    return YES;
}
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (id)requestArgument {
    return @{
        
    };
}
@end
