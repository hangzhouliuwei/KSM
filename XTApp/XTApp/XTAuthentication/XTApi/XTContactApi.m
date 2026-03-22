//
//  XTContactApi.m
//  XTApp
//
//  Created by xia on 2024/9/9.
//

#import "XTContactApi.h"

@interface XTContactApi()

@property(nonatomic,copy) NSString *productId;

@end

@implementation XTContactApi


- (instancetype)initProductId:(NSString *)productId {
    self = [super init];
    if(self) {
        self.productId = productId;
    }
    return self;
}

- (NSString *)requestUrl {
    return [self urlAppendQueryParameterToUrl:@"sixca/contact"];
}

-(YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
- (id)requestArgument{
    return @{
        @"lietsixusNc":XT_Object_To_Stirng(self.productId),
        @"seissixacredNc":@"blaalleynk",
    };
}

@end
