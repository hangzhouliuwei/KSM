//
//  XTAuthErrApi.m
//  XTApp
//
//  Created by xia on 2024/9/10.
//

#import "XTAuthErrApi.h"

@interface XTAuthErrApi()

@property(nonatomic,copy) NSString *errorStr;

@end

@implementation XTAuthErrApi

- (instancetype)initWithErrorStr:(NSString *)errorStr{
    self = [super init];
    if(self) {
        self.errorStr = errorStr;
    }
    return self;
}

- (NSString *)requestUrl {
    return [self urlAppendQueryParameterToUrl:@"sixca/auth_err"];
}

-(YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
- (id)requestArgument{
    return @{
        @"darysixmanNc":XT_Object_To_Stirng(self.errorStr),
    };
}


@end
