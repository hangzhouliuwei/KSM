//
//  BagTestPointService.m
//  NewBag
//
//  Created by Jacky on 2024/4/12.
//

#import "BagTestPointService.h"

@implementation BagTestPointService
{
    NSDictionary *_dic;
}

- (instancetype)initWithData:(NSDictionary *)data
{
    if (self = [super init]) {
        _dic = data;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"testPoint5";
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
    return _dic ? : @{};
}
@end
