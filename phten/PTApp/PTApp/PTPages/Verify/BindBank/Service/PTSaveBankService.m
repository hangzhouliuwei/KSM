//
//  PTSaveBankService.m
//  PTApp
//
//  Created by Jacky on 2024/8/21.
//

#import "PTSaveBankService.h"

@implementation PTSaveBankService
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
    return PTSaveCard;
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
