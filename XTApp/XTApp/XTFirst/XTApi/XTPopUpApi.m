//
//  XTPopUpApi.m
//  XTApp
//
//  Created by xia on 2024/9/23.
//

#import "XTPopUpApi.h"

@implementation XTPopUpApi

- (NSString *)requestUrlToBeAddQueryParameter {
    return [self urlAppendQueryParameterToUrl:@"sixch/pop-up"];;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (NSDictionary *)queryParameter{
    return @{};
}

@end
