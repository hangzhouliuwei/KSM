//
//  PTOrderAPI.m
//  PTApp
//
//  Created by Jacky on 2024/8/28.
//

#import "PTOrderAPI.h"

@implementation PTOrderAPI
{
    NSInteger _status;
    NSInteger _page;
    NSInteger _pageSize;
}

- (instancetype)initWithNumber:(NSInteger)status page:(NSInteger)page pageSize:(NSInteger)pageSize
{
    if (self = [super init]) {
        _status = status;
        _page = page;
        _pageSize = pageSize;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"tenco/list";
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
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
        @"hatenfbackNc":@(_status).stringValue,
        @"letenitimismNc":@(_page).stringValue,
        @"catentonizationNc":@(20)
    };
}
@end
