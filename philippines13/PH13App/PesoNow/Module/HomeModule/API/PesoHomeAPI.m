//
//  PesoHomeAPI.m
//  PesoApp
//
//  Created by Jacky on 2024/9/11.
//

#import "PesoHomeAPI.h"

@implementation PesoHomeAPI
- (NSString *)requestUrl {
    
    return @"thirteench/index";
}
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (id)requestArgument {
   
    return @{};
}

@end
