//
//  BagVerifySaveIdentifyService.m
//  NewBag
//
//  Created by Jacky on 2024/4/8.
//

#import "BagVerifySaveIdentifyService.h"

@implementation BagVerifySaveIdentifyService
{
    NSDictionary *_dic;
}
- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        _dic = dic;
    }
    return self;
}
- (NSString *)requestUrl {
    return @"fourteenca/photo_next";
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
    return _dic ? : @{};
}
@end
