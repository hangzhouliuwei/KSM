//
//  PesoSaveContactAPI.m
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import "PesoSaveContactAPI.h"

@implementation PesoSaveContactAPI
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
    return @"thirteenca/contact_next";
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
