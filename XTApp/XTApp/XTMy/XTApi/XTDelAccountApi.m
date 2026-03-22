//
//  XTDelAccountApi.m
//  XTApp
//
//  Created by xia on 2024/9/6.
//

#import "XTDelAccountApi.h"

@implementation XTDelAccountApi

- (NSString *)requestUrlToBeAddQueryParameter {
    return [self urlAppendQueryParameterToUrl:@"ph/user/del-account"];;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

@end
