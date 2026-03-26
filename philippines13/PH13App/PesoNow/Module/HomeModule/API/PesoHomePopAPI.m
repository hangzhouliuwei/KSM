//
//  PesoHomePopAPI.m
//  PesoApp
//
//  Created by Jacky on 2024/9/11.
//

#import "PesoHomePopAPI.h"

@implementation PesoHomePopAPI
- (NSString *)requestUrl {
    return @"thirteench/pop-up";
}
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (id)requestArgument {
    return @{};
}
@end
