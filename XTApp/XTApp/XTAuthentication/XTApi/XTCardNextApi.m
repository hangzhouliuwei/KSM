//
//  XTCardNextApi.m
//  XTApp
//
//  Created by xia on 2024/9/11.
//

#import "XTCardNextApi.h"

@interface XTCardNextApi()

@property(nonatomic,strong) NSDictionary *dic;

@end

@implementation XTCardNextApi


- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if(self) {
        self.dic = dic;
    }
    return self;
}

- (NSString *)requestUrl {
    return [self urlAppendQueryParameterToUrl:@"sixca/card_next"];
}

-(YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
- (id)requestArgument{
    return self.dic;
}

@end
