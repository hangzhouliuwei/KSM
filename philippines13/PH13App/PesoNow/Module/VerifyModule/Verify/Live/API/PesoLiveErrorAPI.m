//
//  PesoLiveErrorAPI.m
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import "PesoLiveErrorAPI.h"

@implementation PesoLiveErrorAPI
{
    NSString *_error;
}
- (instancetype)initWithData:(NSString *)data
{
    if (self = [super init]) {
        _error = data;
    }
    return self;
}
- (NSString *)requestUrl {
    return @"thirteenca/auth_err";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
        @"darythirteenmanNc":NotNil(_error)
    };
}
@end
