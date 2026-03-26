//
//  XTDetectionApi.m
//  XTApp
//
//  Created by xia on 2024/9/11.
//

#import "XTDetectionApi.h"

@interface XTDetectionApi()

@property(nonatomic,copy) NSString *productId;
@property(nonatomic,copy) NSString *livenessId;

@end

@implementation XTDetectionApi

- (instancetype)initWithProductId:(NSString *)productId
                       livenessId:(NSString *)livenessId {
    self = [super init];
    if(self) {
        self.productId = productId;
        self.livenessId = livenessId;
    }
    return self;
}


- (NSString *)requestUrl {
    return [self urlAppendQueryParameterToUrl:@"sixca/detection"];
}

-(YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
- (id)requestArgument{
    return @{
        @"lietsixusNc":XT_Object_To_Stirng(self.productId),
        @"gyossixeNc":XT_Object_To_Stirng(self.livenessId),
    };
}


@end
