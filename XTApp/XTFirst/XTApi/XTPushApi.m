//
//  XTPushApi.m
//  XTApp
//
//  Created by xia on 2024/9/7.
//

#import "XTPushApi.h"

@interface XTPushApi()

@property(nonatomic,copy) NSString *orderId;

@end

@implementation XTPushApi

- (instancetype)initOrderId:(NSString *)orderId {
    self = [super init];
    if(self) {
        self.orderId = orderId;
    }
    return self;
}

- (NSString *)requestUrl {
    return [self urlAppendQueryParameterToUrl:@"sixnv2/gce/push"];
}

-(YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
- (id)requestArgument{
    return @{
        @"spsmsixogenicNc":XT_Object_To_Stirng(self.orderId),
        @"ditosixmeNc":@"houijhyus",
    };
}

@end
