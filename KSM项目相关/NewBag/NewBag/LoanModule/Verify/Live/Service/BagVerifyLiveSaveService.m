//
//  BagVerifyLiveSaveService.m
//  NewBag
//
//  Created by Jacky on 2024/4/8.
//

#import "BagVerifyLiveSaveService.h"

@implementation BagVerifyLiveSaveService
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
    return @"fourteenca/saveauth";
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
