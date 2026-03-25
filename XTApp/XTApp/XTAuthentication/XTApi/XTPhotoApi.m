//
//  XTPhotoApi.m
//  XTApp
//
//  Created by xia on 2024/9/10.
//

#import "XTPhotoApi.h"

@interface XTPhotoApi()

@property(nonatomic,copy) NSString *productId;

@end

@implementation XTPhotoApi


- (instancetype)initProductId:(NSString *)productId {
    self = [super init];
    if(self) {
        self.productId = productId;
    }
    return self;
}

- (NSString *)requestUrl {
    return [self urlAppendQueryParameterToUrl:@"sixca/photo"];
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
