//
//  PesoLiveSaveAPI.m
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import "PesoLiveSaveAPI.h"

@implementation PesoLiveSaveAPI
{
    NSDictionary *_dic;
}
- (instancetype)initWithData:(NSDictionary *)data{
    if (self = [super init]) {
        _dic = data;
    }
    return self;
}
- (NSString *)requestUrl {
    return @"thirteenca/saveauth";
}
- (BOOL)showLoading
{
    return YES;
}
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return _dic ? : @{};
}
@end
