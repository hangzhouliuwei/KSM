//
//  XTHomeApi.m
//  XTApp
//
//  Created by xia on 2024/9/12.
//

#import "XTHomeApi.h"

@implementation XTHomeApi

- (NSString *)requestUrlToBeAddQueryParameter {
    return [self urlAppendQueryParameterToUrl:@"sixch/home"];;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

@end
