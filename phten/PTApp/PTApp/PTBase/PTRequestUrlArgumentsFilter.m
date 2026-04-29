//
//  PTRequestUrlArgumentsFilter.m
//  PTApp
//
//  Created by 刘巍 on 2024/7/15.
//

#import "PTRequestUrlArgumentsFilter.h"
#import <AFNetworking/AFNetworking.h>
#import "PTDeviceInfo.h"

@implementation PTRequestUrlArgumentsFilter

+ (PTRequestUrlArgumentsFilter *)filterWithArguments{
    return [[self alloc] init];
}

+ (NSDictionary *)getURLParam{

    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                               @"satenurnicNc":@"ios",
                                                                               @"antendicNc":PTNotNull([PTDeviceInfo version]),
                                                                               @"petennisetumNc":PTNotNull([PTDeviceInfo deviceName]),
                                                                               @"exteneptionalNc":PTNotNull([PTDeviceInfo idfv]),
                                                                               @"detendeningNc":PTNotNull([PTDeviceInfo systemVersion]),
                                                                               @"fetenicidalNc":@"ph",
                                                                               @"prtengnenoloneNc":PTNotNull([PTDeviceInfo bundleId]),
                                                                               @"sptendilleNc":PTNotNull([PTDeviceInfo idfa]),
                                                                               @"dstenhdbashdNc":PTNotNull([PTDeviceInfo createRandomUUID]),
                                                                               @"astenbcaydNc":PTNotNull([PTDeviceInfo firstInstallation]),
                                                                               @"kbtenhjdgfNc":PTNotNull([PTDeviceInfo newIDFV])
                                                                              }];
    
    if([PTUser isLogin]){
        dic[@"ratenioiodineNc"] = PTUser.username;
        dic[@"ghtenstNc"] = PTUser.sessionid;
    }
    
    return dic.mutableCopy;
}

- (nonnull NSString *)filterUrl:(nonnull NSString *)originUrl withRequest:(nonnull YTKBaseRequest *)request { 
    return [self urlStringWithOriginUrlString:originUrl appendParameters:[PTRequestUrlArgumentsFilter getURLParam]];
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
