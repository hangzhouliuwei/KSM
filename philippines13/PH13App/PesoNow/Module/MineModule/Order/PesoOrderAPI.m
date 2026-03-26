//
//  PesoOrderAPI.m
//  PesoApp
//
//  Created by Jacky on 2024/9/18.
//

#import "PesoOrderAPI.h"

@implementation PesoOrderAPI
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
    return @"thirteenco/list";
}
- (BOOL)showLoading
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
        @"hafbthirteenackNc":@(_status).stringValue,
        @"leitthirteenimismNc":@(_page).stringValue,
        @"catothirteennizationNc":@(20)
    };
}
@end
