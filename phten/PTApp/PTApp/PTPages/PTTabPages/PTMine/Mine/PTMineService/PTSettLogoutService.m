//
//  PTSettLogoutService.m
//  PTApp
//
//  Created by 刘巍 on 2024/8/13.
//

#import "PTSettLogoutService.h"

@implementation PTSettLogoutService
- (instancetype)initWithSettLogout
{
    self = [super init];
    if(self){
        
    }
    return self;
}

- (NSString *)requestUrl {
    
    return PTSettLogout;
}
- (BOOL)isShowLoading
{
    return YES;
}
- (NSTimeInterval)requestTimeoutInterval
{
    return 30;
}
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (id)requestArgument {
   
    return @{};
}

@end
