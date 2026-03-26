//
//  PesoLogouOutAPI.m
//  PesoApp
//
//  Created by Jacky on 2024/9/18.
//

#import "PesoLogouOutAPI.h"

@implementation PesoLogouOutAPI
- (NSString *)requestUrl {
    
    return @"thirteencp/logout";
}
- (BOOL)showLoading
{
    return YES;
}
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (id)requestArgument {
   
    return @{};
}
@end
