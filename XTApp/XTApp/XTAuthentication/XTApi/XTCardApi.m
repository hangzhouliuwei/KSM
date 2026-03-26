//
//  XTCardApi.m
//  XTApp
//
//  Created by xia on 2024/9/11.
//

#import "XTCardApi.h"

@interface XTCardApi()

@property(nonatomic,copy) NSString *productId;

@end

@implementation XTCardApi


- (instancetype)initProductId:(NSString *)productId {
    self = [super init];
    if(self) {
        self.productId = productId;
    }
    return self;
}

- (NSString *)requestUrl {
    return [self urlAppendQueryParameterToUrl:@"sixca/card"];
}

-(YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
- (id)requestArgument{
    return @{
        @"lietsixusNc":XT_Object_To_Stirng(self.productId),
    };
}

@end
