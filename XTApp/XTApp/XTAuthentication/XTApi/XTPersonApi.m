//
//  XTPersonApi.m
//  XTApp
//
//  Created by xia on 2024/9/8.
//

#import "XTPersonApi.h"

@interface XTPersonApi()

@property(nonatomic,copy) NSString *productId;

@end

@implementation XTPersonApi

- (instancetype)initProductId:(NSString *)productId {
    self = [super init];
    if(self) {
        self.productId = productId;
    }
    return self;
}

- (NSString *)requestUrl {
    return [self urlAppendQueryParameterToUrl:@"sixca/person"];
}

-(YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
- (id)requestArgument{
    return @{
        @"lietsixusNc":XT_Object_To_Stirng(self.productId),
        @"bunasixbleNc":@"stauistill",
    };
}

@end
