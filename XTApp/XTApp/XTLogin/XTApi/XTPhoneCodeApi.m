//
//  XTPhoneCodeApi.m
//  XTApp
//
//  Created by xia on 2024/7/11.
//

#import "XTPhoneCodeApi.h"

@interface XTPhoneCodeApi()

@property(nonatomic,copy) NSString *phone;

@end

@implementation XTPhoneCodeApi

- (instancetype)initPhone:(NSString *)phone {
    self = [super init];
    if(self) {
        self.phone = phone;
    }
    return self;
}

- (NSString *)requestUrl {
    return [self urlAppendQueryParameterToUrl:@"sixcp/get_code"];
}

-(YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
- (id)requestArgument{
    return @{
        @"chresixographyNc":XT_Object_To_Stirng(self.phone),
        @"betysixNc":@"juyttrr",
    };
}

@end
