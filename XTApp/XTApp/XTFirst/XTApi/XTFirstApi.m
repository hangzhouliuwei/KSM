//
//  XTFirstApi.m
//  XTApp
//
//  Created by xia on 2024/7/11.
//

#import "XTFirstApi.h"

@implementation XTFirstApi

- (NSString *)requestUrlToBeAddQueryParameter {
    return [self urlAppendQueryParameterToUrl:@"sixch/index"];;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (NSDictionary *)queryParameter{
    return @{};
}

@end
