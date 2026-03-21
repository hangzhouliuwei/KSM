//
//  XTUpAdidApi.m
//  XTApp
//
//  Created by 刘巍 on 2024/9/25.
//

#import "XTUpAdidApi.h"

@interface XTUpAdidApi ()
@property(nonatomic, copy) NSString *xt_adid;
@end

@implementation XTUpAdidApi

- (instancetype)initAdId:(NSString *)adid
{
    self = [super init];
    if(self) {
        self.xt_adid = adid;
    }
    return self;
}

- (NSString *)requestUrl {
    return [self urlAppendQueryParameterToUrl:@"sixcr/aio"];
}

-(YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
- (id)requestArgument{
    return @{
        @"exepsixtionalNc":XT_Object_To_Stirng([XTDevice xt_share].xt_idfv),
        @"fkgjsixgkxdkcnNc":XT_Object_To_Stirng(self.xt_adid),
    };
}
@end
