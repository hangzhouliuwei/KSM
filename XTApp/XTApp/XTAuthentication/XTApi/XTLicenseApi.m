//
//  XTLicenseApi.m
//  XTApp
//
//  Created by xia on 2024/9/10.
//

#import "XTLicenseApi.h"

@implementation XTLicenseApi

- (NSString *)requestUrl {
    return [self urlAppendQueryParameterToUrl:@"sixca/license"];
}

-(YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
- (id)requestArgument{
    return @{};
}

@end
