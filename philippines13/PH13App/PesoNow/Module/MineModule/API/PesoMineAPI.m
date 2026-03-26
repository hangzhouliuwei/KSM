//
//  PesoMineAPI.m
//  PesoApp
//
//  Created by Jacky on 2024/9/18.
//

#import "PesoMineAPI.h"

@implementation PesoMineAPI
- (NSString *)requestUrl {
    
    return @"thirteench/home";
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
