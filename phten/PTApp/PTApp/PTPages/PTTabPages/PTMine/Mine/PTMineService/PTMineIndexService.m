//
//  PTMineIndexService.m
//  PTApp
//
//  Created by 刘巍 on 2024/8/9.
//

#import "PTMineIndexService.h"

@implementation PTMineIndexService

- (instancetype)initWithMineIndex{
    self = [super init];
    if(self){
    }
    return self;
}

- (NSString *)requestUrl {
    
    return PTMineIndex;
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
