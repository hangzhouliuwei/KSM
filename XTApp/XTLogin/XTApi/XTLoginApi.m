//
//  XTLoginApi.m
//  XTApp
//
//  Created by xia on 2024/7/11.
//

#import "XTLoginApi.h"

@interface XTLoginApi ()

@property(nonatomic,strong) NSDictionary *dic;

@end

@implementation XTLoginApi

- (instancetype)initDic:(NSDictionary *)dic {
    self = [super init];
    if(self) {
        self.dic = dic;
    }
    return self;
}

- (NSString *)requestUrl {
    return [self urlAppendQueryParameterToUrl:@"sixcp/login"];
}

-(YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
- (id)requestArgument{
    return self.dic;
}

@end
