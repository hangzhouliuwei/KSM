//
//  HttpManager.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/23.
//

#import "PLPNetRequestManager.h"
#import <sys/utsname.h>
#import <objc/runtime.h>
#import <AdSupport/AdSupport.h>
#import "AppDelegate.h"
#import "PLPBaseNavigationController.h"
#import "PLPLoginRegistViewController.h"
@implementation PLPNetRequestManager

+(instancetype)plpJsonManager
{
    static PLPNetRequestManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[PLPNetRequestManager alloc] init];
    });
    return manager;
}
-(AFHTTPSessionManager *)netRequestmanager
{
    if(!_netRequestmanager) {
        _netRequestmanager = [AFHTTPSessionManager manager];
        AFJSONRequestSerializer *request_serial = [AFJSONRequestSerializer serializer];
        request_serial.timeoutInterval = 30;
        [request_serial setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        AFJSONResponseSerializer *reponseSerial = [AFJSONResponseSerializer serializer];
        reponseSerial.acceptableContentTypes = [NSSet setWithObjects:@"text/javascript",@"application/json",@"text/json", @"text/html",@"text/plain",@"application/x-www-form-urlencoded", nil];
        _netRequestmanager.requestSerializer = request_serial;
        _netRequestmanager.responseSerializer = reponseSerial;
    }
    return _netRequestmanager;
}
-(void)POSTURL:(NSString *)url paramsInfo:(id)params successBlk:(void (^)(id _Nonnull))success failureBlk:(void (^)(NSError * _Nonnull))failure
{
    [self generateNetRequestManagerHeader];
    NSString *result = [[NSString stringWithFormat:@"%@/%@?%@",kURLDomain, url, [self plp_generateParams]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [self.netRequestmanager POST:result parameters:params headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSInteger imeatwelvesurabilityNc = [responseObject[@"imeatwelvesurabilityNc"] integerValue];
        if (imeatwelvesurabilityNc == 0) {
            success(responseObject);
        }else if (imeatwelvesurabilityNc == -2) {
            kHideLoading
            [self exitToLoginViewController];
        }else
        {
            kHideLoading
            NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:imeatwelvesurabilityNc userInfo:responseObject[@"viustwelveNc"]];
            kPLPPopInfoWithStr([NSString stringWithFormat:@"%@",responseObject[@"frwntwelveNc"]]);
            failure(error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        kHideLoading
        failure(error);
    }];
}
-(void)GETURL:(NSString *)url paramsInfo:(id)params successBlk:(void (^)(id _Nonnull))success failureBlk:(void (^)(NSError * _Nonnull))failure
{
    [self generateNetRequestManagerHeader];
    NSString *result = [[NSString stringWithFormat:@"%@/%@?%@",kURLDomain, url, [self plp_generateParams]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [self.netRequestmanager GET:result parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSInteger imeatwelvesurabilityNc = [responseObject[@"imeatwelvesurabilityNc"] integerValue];
        if (imeatwelvesurabilityNc == 0) {
            success(responseObject);
        }else if (imeatwelvesurabilityNc == -2) {
            kHideLoading
            [self exitToLoginViewController];
        }else
        {
            kHideLoading
            NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:imeatwelvesurabilityNc userInfo:responseObject[@"viustwelveNc"]];
            failure(error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        kHideLoading
        failure(error);
    }];
}
-(void)UPLOADURL:(NSString *)url imageData:(UIImage *)imageData paramsInfo:(id)params successBlk:(void (^)(id _Nonnull))success failureBlk:(void (^)(NSError * _Nonnull))failure
{
    [self generateNetRequestManagerHeader];
    NSString *result = [[NSString stringWithFormat:@"%@/%@?%@",kURLDomain, url, [self plp_generateParams]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:params];
    [dic removeObjectForKey:@"name"];
    [self.netRequestmanager POST:result parameters:dic headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [[NSString alloc] init];
        fileName = [NSString stringWithFormat:@"%@%@.png",params[@"name"],str];
        [formData appendPartWithFileData:imageData name:params[@"name"] fileName:fileName mimeType:@"image/png"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSInteger imeatwelvesurabilityNc = [responseObject[@"imeatwelvesurabilityNc"] integerValue];
        if (imeatwelvesurabilityNc == 0) {
            success(responseObject);
        }else if (imeatwelvesurabilityNc == -2) {
            kHideLoading
            [self exitToLoginViewController];
        }else
        {
            kHideLoading
            NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:imeatwelvesurabilityNc userInfo:responseObject[@"viustwelveNc"]];
            kPLPPopInfoWithStr([NSString stringWithFormat:@"%@",responseObject[@"frwntwelveNc"]]);
            failure(error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        kHideLoading
        failure(error);
    }];
}

-(void)exitToLoginViewController
{
    [kMMKV setBool:false forKey:kIsLoginKey];
    [kMMKV removeValueForKey:kPhoneKey];
    [kMMKV removeValueForKey:kSessionIDKey];
    [kMMKV removeValueForKey:kUserIdKey];
    ((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController = [[PLPBaseNavigationController alloc] initWithRootViewController:[PLPLoginRegistViewController new]];
}


-(NSString *)plp_generateParams
{
    // 获取应用的版本号
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@"saurtwelvenicNc=ios"];
    [array addObject:[NSString stringWithFormat:@"anditwelvecNc=%@",[PLPCommondTools fetchShortVersion]]];
    [array addObject:[NSString stringWithFormat:@"penitwelvesetumNc=%@",[PLPCommondTools getDeviceModelName]]];
    [array addObject:[NSString stringWithFormat:@"exeptwelvetionalNc=%@",[PLPCommondTools getDeviceIDFV]]];
    [array addObject:[NSString stringWithFormat:@"dedetwelveningNc=%@",[UIDevice currentDevice].systemVersion]];
//    NSString *countryCode = [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
    
    
    [array addObject:[NSString stringWithFormat:@"prgntwelveenoloneNc=%@",[[NSBundle mainBundle] bundleIdentifier]]];
    NSString *idfaString = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    [array addObject:@"feictwelveidalNc=ph"];
    [array addObject:[NSString stringWithFormat:@"spditwelvelleNc=%@",idfaString]];
    if ([kMMKV getBoolForKey:kIsLoginKey]) {
        [array addObject:[NSString stringWithFormat:@"raiotwelveiodineNc=%@",[kMMKV getStringForKey:kPhoneKey]]];
        NSString *sessionId = [kMMKV getStringForKey:kSessionIDKey];
        [array addObject:[NSString stringWithFormat:@"ghsttwelveNc=%@",sessionId]];
    }
    return [array componentsJoinedByString:@"&"];
}
-(void)generateNetRequestManagerHeader
{
    // 获取应用的版本号
    [self.netRequestmanager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"saurtwelvenicNc"];
    [self.netRequestmanager.requestSerializer setValue:[PLPCommondTools fetchShortVersion] forHTTPHeaderField:@"anditwelvecNc"];
    [self.netRequestmanager.requestSerializer setValue:[PLPCommondTools getDeviceModelName] forHTTPHeaderField:@"penitwelvesetumNc"];
    [self.netRequestmanager.requestSerializer setValue:[PLPCommondTools getDeviceIDFV] forHTTPHeaderField:@"exeptwelvetionalNc"];
    [self.netRequestmanager.requestSerializer setValue:[UIDevice currentDevice].systemVersion forHTTPHeaderField:@"dedetwelveningNc"];
    
    
    [self.netRequestmanager.requestSerializer setValue:[[NSBundle mainBundle] bundleIdentifier] forHTTPHeaderField:@"prgntwelveenoloneNc"];
    NSString *idfaString = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    [self.netRequestmanager.requestSerializer setValue:idfaString forHTTPHeaderField:@"spditwelvelleNc"];
    
    if ([kMMKV getBoolForKey:kIsLoginKey]) {
        NSString *sessionId = [kMMKV getStringForKey:kSessionIDKey];
        if ([sessionId isReal]) {
            [self.netRequestmanager.requestSerializer setValue:sessionId forHTTPHeaderField:@"ghsttwelveNc"];
        }
        [self.netRequestmanager.requestSerializer setValue:@"ph" forHTTPHeaderField:@"feictwelveidalNc"];
    }
}
@end
