//
//  PesoLoginAPI.m
//  PesoApp
//
//  Created by Jacky on 2024/9/10.
//

#import "PesoLoginAPI.h"

@implementation PesoLoginAPI
{
    NSDictionary *_dataDic;
}

- (instancetype)initWithDic:(NSDictionary *)dataDic{
    self = [super init];
    if(self){
        _dataDic = dataDic;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"thirteencp/login";
}
- (BOOL)showLoading
{
    return YES;
}
- (NSTimeInterval)requestTimeoutInterval
{
    return 30;
}
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return _dataDic;
}

@end
