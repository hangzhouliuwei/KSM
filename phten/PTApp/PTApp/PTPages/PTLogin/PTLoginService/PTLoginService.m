//
//  PTLoginService.m
//  PTApp
//
//  Created by 刘巍 on 2024/7/31.
//

#import "PTLoginService.h"

@implementation PTLoginService
{
    NSDictionary *_dataDic;
    
}

- (instancetype)initWithPhoneDataDic:(NSDictionary *)dataDic{
    self = [super init];
    if(self){
        _dataDic = dataDic;
    }
    
    return self;
}


- (NSString *)requestUrl {
    return PTGetLongin;
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
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return _dataDic;
}

@end
