//
//  XTMarketApi.m
//  XTApp
//
//  Created by xia on 2024/9/4.
//

#import "XTMarketApi.h"

@interface XTMarketApi()

@property(nonatomic,copy) NSString *xt_idfa;

@end

@implementation XTMarketApi

- (instancetype)initIdfa:(NSString *)idfa {
    self = [super init];
    if(self) {
        self.xt_idfa = idfa;
    }
    return self;
}

- (NSString *)requestUrl {
    return [self urlAppendQueryParameterToUrl:@"sixcr/market"];
}

-(YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
- (id)requestArgument{
    return @{
        @"manisixcideNc":XT_Object_To_Stirng([XTDevice xt_share].xt_idfv),
        @"patusixrageNc":XT_Object_To_Stirng(self.xt_idfa),
        @"asdfasasdgwg":@"fewfdf",
        @"ATETH":@"123123555",
    };
}

@end
