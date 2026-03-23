//
//  XTPersonNextApi.m
//  XTApp
//
//  Created by xia on 2024/9/9.
//

#import "XTPersonNextApi.h"

@interface XTPersonNextApi()

@property(nonatomic,strong) NSDictionary *dic;

@end

@implementation XTPersonNextApi

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if(self) {
        self.dic = dic;
    }
    return self;
}

- (NSString *)requestUrl {
    return [self urlAppendQueryParameterToUrl:@"sixca/person_next"];
}

-(YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
- (id)requestArgument{
    return self.dic;
}

@end
