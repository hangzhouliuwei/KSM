//
//  XTApplyApi.m
//  XTApp
//
//  Created by xia on 2024/9/7.
//

#import "XTApplyApi.h"

@interface XTApplyApi()

@property(nonatomic,copy) NSString *productId;

@end

@implementation XTApplyApi

- (instancetype)initProductId:(NSString *)productId {
    self = [super init];
    if(self) {
        self.productId = productId;
    }
    return self;
}

- (NSString *)requestUrl {
    return [self urlAppendQueryParameterToUrl:@"sixnv2/gce/apply"];
}

-(YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
- (id)requestArgument{
    return @{
        @"lietsixusNc":XT_Object_To_Stirng(self.productId),
        @"fuhasixmNc":@"cakestand",
    };
}

@end
