//
//  XTLogoutApi.m
//  XTApp
//
//  Created by xia on 2024/9/24.
//

#import "XTLogoutApi.h"

@implementation XTLogoutApi

- (NSString *)requestUrlToBeAddQueryParameter {
    return [self urlAppendQueryParameterToUrl:@"sixcp/logout"];;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

@end
