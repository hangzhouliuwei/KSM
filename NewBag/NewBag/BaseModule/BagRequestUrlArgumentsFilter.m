//
//  BagRequestUrlArgumentsFilter.m
//  NewBag
//
//  Created by Jacky on 2024/3/13.
//

#import "BagRequestUrlArgumentsFilter.h"
#import <AFNetworking/AFNetworking.h>
@implementation BagRequestUrlArgumentsFilter{
    NSDictionary *_arguments;
}
+ (BagRequestUrlArgumentsFilter *)filterWithArguments{
    return [[self alloc] initWithArguments:[BagRequestUrlArgumentsFilter getURLParam]];
}
+ (BagRequestUrlArgumentsFilter *)filterWithArguments:(NSDictionary *)arguments {
    return [[self alloc] initWithArguments:arguments];
}

- (id)initWithArguments:(NSDictionary *)arguments {
    self = [super init];
    if (self) {
        _arguments = arguments;
    }
    return self;
}
+ (NSDictionary *)getURLParam{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"saurfourteennicNc":@"ios",//
                                                                               @"andifourteencNc":[[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] br_PramsString],//版本号
                                                                               @"penifourteensetumNc":[[NSObject getMobileStyle] br_PramsString].stringByRemovingPercentEncoding,//手机型号
                                                                               @"exepfourteentionalNc":NotNull([NSObject getIDFV]),//idfv
                                                                               @"dedefourteenningNc":[[UIDevice currentDevice] systemVersion],//手机系统
                                                                               @"feicfourteenidalNc":@"ph",
                                                                               @"prgnfourteenenoloneNc":[NSBundle mainBundle].bundleIdentifier,//包名
                                                                             }];
    [NSObject getIdfa:^(NSString * _Nonnull idfa) {
        [dic setObject:NotNull(idfa) forKey:@"spdifourteenlleNc"];
    }];
    [dic setObject: NotNull([BagUserManager shareInstance].sessionid) forKey:@"ghstfourteenNc"];//session
    [dic setObject: NotNull([BagUserManager shareInstance].username) forKey:@"raiofourteeniodineNc"];//手机号
    return  dic.copy;
}

- (NSString *)filterUrl:(NSString *)originUrl withRequest:(YTKBaseRequest *)request {
    return [self urlStringWithOriginUrlString:originUrl appendParameters:_arguments];
}
- (NSString *)urlStringWithOriginUrlString:(NSString *)originUrlString appendParameters:(NSDictionary *)parameters {
    NSString *paraUrlString = AFQueryStringFromParameters(parameters).stringByRemovingPercentEncoding;
    
    if (!(paraUrlString.length > 0)) {
        return originUrlString;
    }
    
    BOOL useDummyUrl = NO;
    static NSString *dummyUrl = nil;
    NSURLComponents *components = [NSURLComponents componentsWithString:originUrlString];
    if (!components) {
        useDummyUrl = YES;
        if (!dummyUrl) {
            dummyUrl = @"http://www.dummy.com";
        }
        components = [NSURLComponents componentsWithString:dummyUrl];
    }
    
    NSString *queryString = components.query ?: @"";
    NSString *newQueryString = [queryString stringByAppendingFormat:queryString.length > 0 ? @"&%@" : @"%@", paraUrlString];
    
    components.query = newQueryString;
    
    if (useDummyUrl) {
        return [components.URL.absoluteString substringFromIndex:dummyUrl.length - 1];
    } else {
        return components.URL.absoluteString;
    }
}

@end
