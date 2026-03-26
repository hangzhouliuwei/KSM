//
//  XTSaveAuthApi.m
//  XTApp
//
//  Created by xia on 2024/9/11.
//

#import "XTSaveAuthApi.h"

@interface XTSaveAuthApi()

@property(nonatomic,strong) NSDictionary *dic;

@end

@implementation XTSaveAuthApi

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if(self) {
        self.dic = dic;
    }
    return self;
}

- (NSString *)requestUrl {
    return [self urlAppendQueryParameterToUrl:@"sixca/saveauth"];
}

-(YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
- (id)requestArgument{
    return self.dic;
}
@end
