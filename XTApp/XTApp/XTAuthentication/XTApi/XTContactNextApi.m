//
//  XTContactNextApi.m
//  XTApp
//
//  Created by xia on 2024/9/9.
//

#import "XTContactNextApi.h"

@interface XTContactNextApi()

@property(nonatomic,strong) NSDictionary *dic;

@end

@implementation XTContactNextApi

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if(self) {
        self.dic = dic;
    }
    return self;
}

- (NSString *)requestUrl {
    return [self urlAppendQueryParameterToUrl:@"sixca/contact_next"];
}

-(YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
- (id)requestArgument{
    return self.dic;
}

@end
