//
//  BagOrderService.m
//  NewBag
//
//  Created by Jacky on 2024/4/1.
//

#import "BagOrderService.h"

@implementation BagOrderService
{
    NSInteger _status;
    NSInteger _page;
    NSInteger _pageSize;
}

- (instancetype)initWithState:(NSInteger)status page:(NSInteger)page pageSize:(NSInteger)pageSize
{
    if (self = [super init]) {
        _status = status;
        _page = page;
        _pageSize = pageSize;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"fourteenco/list";
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
        @"hafbfourteenackNc":@(_status).stringValue,
        @"leitfourteenimismNc":@(_page).stringValue,
        @"catofourteennizationNc":@(_pageSize)
    };
}
@end
