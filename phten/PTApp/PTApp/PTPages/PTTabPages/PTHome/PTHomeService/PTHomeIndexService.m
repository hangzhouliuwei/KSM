//
//  PTHomeIndexService.m
//  PTApp
//
//  Created by 刘巍 on 2024/8/1.
//

#import "PTHomeIndexService.h"

@implementation PTHomeIndexService

- (instancetype)initWithhomeIndex{
    self = [super init];
    if(self){
    }
    return self;
}

- (NSString *)requestUrl {
    
    return PTHomeIndex;
}
- (BOOL)isShowLoading
{
    return NO;
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
