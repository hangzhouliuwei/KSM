//
//  XTLocationApi.m
//  XTApp
//
//  Created by xia on 2024/9/7.
//

#import "XTLocationApi.h"

@interface XTLocationApi()

@property(nonatomic,strong) NSDictionary *dic;

@end

@implementation XTLocationApi

- (instancetype)initDic:(NSDictionary *)dic {
    self = [super init];
    if(self) {
        self.dic = dic;
    }
    return self;
}


- (NSString *)requestUrl {
    return [self urlAppendQueryParameterToUrl:@"sixcr/location"];
}

-(YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
- (id)requestArgument{
    return self.dic;
}

@end
