//
//  PesoRequestArguments.m
//  PesoApp
//
//  Created by Jacky on 2024/9/9.
//

#import "PesoRequestArguments.h"
#import <AFNetworking/AFNetworking.h>
#import "PesoDeviceTool.h"
@interface PesoRequestArguments()
@property(nonatomic, copy) NSDictionary *arguments;;
@end
@implementation PesoRequestArguments
+ (PesoRequestArguments *)filterWithArguments{
    return [[self alloc] initWithArguments:[PesoRequestArguments getURLParam]];
}

+ (NSDictionary *)getURLParam{

    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                               @"saurthirteennicNc":@"#",
                                                                               @"andithirteencNc":NotNil([PesoDeviceTool version]),
                                                                               @"penithirteensetumNc":NotNil([PesoDeviceTool deviceName]),
                                                                               @"exepthirteentionalNc":NotNil([PesoDeviceTool idfv]),
                                                                               @"dedethirteenningNc":NotNil([PesoDeviceTool systemVersion]),
                                                                               @"feicthirteenidalNc":@"ph",
                                                                               @"prgnthirteenenoloneNc":NotNil([PesoDeviceTool bundleId]),
                                                                               @"spdithirteenlleNc":NotNil([PesoDeviceTool idfa]),
    
                                                                              }];
    
    if([PesoUserCenter.sharedPesoUserCenter isLogin]){
        dic[@"raiothirteeniodineNc"] = PesoUserCenter.sharedPesoUserCenter.username;
        dic[@"ghstthirteenNc"] =  PesoUserCenter.sharedPesoUserCenter.sessionid;
    }
    
    return dic.mutableCopy;
}

- (id)initWithArguments:(NSDictionary *)arguments {
    self = [super init];
    if (self) {
        _arguments = arguments;
    }
    return self;
}

- (nonnull NSString *)filterUrl:(nonnull NSString *)originUrl withRequest:(nonnull YTKBaseRequest *)request {
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
