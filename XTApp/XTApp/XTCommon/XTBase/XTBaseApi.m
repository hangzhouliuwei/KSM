//
//  DCBaseApi.m
//  XTApp
//
//  Created by xia on 2024/7/11.
//

#import "XTBaseApi.h"

#ifdef DEBUG
#define XTRequestLog(__result_,__ViewControllerName_, __Url_, __Type_, __Header_, __Params_,__ResponseHeaderParams_, __ResponseData_) \
fprintf(stderr, "\n\n======== 数据请求%s(%s): ========\n",__result_.UTF8String,__ViewControllerName_.UTF8String); \
fprintf(stderr, "-- RequestUrl: %s\n", __Url_.UTF8String); \
fprintf(stderr, "-- Type: %s\n", __Type_.UTF8String); \
if (__Params_) {\
fprintf(stderr, "-- RequestHeader: %s\n", [NSString stringWithFormat:@"%@", __Header_].UTF8String); \
} \
if (__Params_) {\
fprintf(stderr, "-- Params: %s\n", [NSString stringWithFormat:@"%@", __Params_].UTF8String); \
} \
if (__ResponseHeaderParams_) {\
fprintf(stderr, "-- ResponseHeaders: %s\n", [NSString stringWithFormat:@"%@", __ResponseHeaderParams_].UTF8String); \
}\
if (__ResponseData_) {\
fprintf(stderr, "-- ResponseData: %s\n", [NSString stringWithFormat:@"%@", __ResponseData_].UTF8String); \
}\
fprintf(stderr, "================================================\n\n");
#else
#define XTRequestLog(__result_,__ViewControllerName_, __Url_, __Type_, __Header_, __Params_,__ResponseHeaderParams_, __ResponseData_)
#endif

//网络请求超时时间设置
static NSTimeInterval xt_timeoutSeconds = 30.0f;

@interface XTBaseApi ()

@property (nonatomic, strong) NSDictionary * _Nonnull headerDic;
@property (nonatomic, strong) NSString * xt_request_url;;

@end

@implementation XTBaseApi

- (void)dealloc{
    [self cancel];
}
- (void)cancel{
    [self.requestTask cancel];
    [self clearCompletionBlock];
}

- (NSDictionary *)headerDic{
    if (!_headerDic) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [XTDevice xt_getIdfaShowAlt:NO block:^(NSString * _Nonnull idfa) {
            [dic setObject:XT_Object_To_Stirng(idfa) forKey:@"spdisixlleNc"];
        }];
        //终端名称
        [dic setObject:@"ios" forKey:@"saursixnicNc"];
        //版本号
        [dic setObject:XT_App_Version forKey:@"andisixcNc"];
        //手机型号
        [dic setObject:XT_Object_To_Stirng([XTDevice xt_share].xt_mobileStyle) forKey:@"penisixsetumNc"];
        //idfv
        [dic setObject:XT_Object_To_Stirng([XTDevice xt_share].xt_idfv) forKey:@"exepsixtionalNc"];
        //系统版本
        [dic setObject:XT_Object_To_Stirng([XTDevice xt_share].xt_sysVersion) forKey:@"dedesixningNc"];
        //市场
        [dic setObject:@"ph" forKey:@"feicsixidalNc"];
        //包名
        [dic setObject:XT_App_BundleId forKey:@"prgnsixenoloneNc"];
//        //第一次安装时间
//        [dic setObject:XT_Object_To_Stirng([[XTDevice xt_share] xt_firstAppTime]) forKey:@"asbcthirteenaydNc"];
//        [dic setObject:XT_Object_To_Stirng([UIDevice currentDevice].identifierForVendor.UUIDString) forKey:@"kbhjthirteendgfNc"];
        if([XTUserManger xt_isLogin]){
            //登录后获取的用户的sessionId
            [dic setObject:XT_Object_To_Stirng([XTUserManger xt_share].xt_user.xt_userSessionid) forKey:@"ghstsixNc"];
            [dic setObject:XT_Object_To_Stirng([XTUserManger xt_share].xt_user.xt_phone) forKey:@"raiosixiodineNc"];
        }
        _headerDic = dic;
    }
    return _headerDic;
}

- (YTKRequestSerializerType)requestSerializerType{
    return YTKRequestSerializerTypeJSON;
}

- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.headerDic];
//    [dic setValue:@"application/json" forKey:@"Content-Type"]
    return dic;
}

- (NSDictionary<NSString *,NSString *> *)responseHeadersFieldValueDictionary{
    NSMutableDictionary <NSString *,NSString *> *headerParameters = self.responseHeaders.mutableCopy;
    return headerParameters;
}
- (NSString *)baseUrl{
    return self.xt_request_url;
}

- (NSString *)xt_request_url{
    if(!_xt_request_url) {
        NSString *str = [NSString stringWithContentsOfFile:XT_Locality_Url_Path encoding:NSUTF8StringEncoding error:nil];
        if(![NSString xt_isEmpty:str]){
            _xt_request_url = str;
        }
        else {
            _xt_request_url = XT_Api;
        }
    }
    return _xt_request_url;
}

- (NSTimeInterval)requestTimeoutInterval {
    return xt_timeoutSeconds;
}

#pragma mark --parameter
- (NSDictionary *)queryParameter{
    return nil;
}

- (NSString *)requestUrlToBeAddQueryParameter{
    return nil;
}

- (NSString *)requestUrl{
    NSString *originUrl = [self requestUrlToBeAddQueryParameter];
    return [self urlAppendQueryParameterToUrl:originUrl];
}

- (NSString *)urlAppendQueryParameterToUrl:(NSString *)url{
    NSDictionary *para = self.headerDic;
    return [XTBaseApi urlAppendDicToUrl:url dic:para];
}

+ (NSString *)urlAppendDicToUrl:(NSString *)url dic:(NSDictionary *)dic{
    if (!url || !dic) {
        return url;
    }
    //
    NSMutableString *queryStr = [NSMutableString string];
    [dic.allKeys enumerateObjectsUsingBlock:^(id  _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        if (queryStr.length > 0) {
            [queryStr appendString:@"&"];
        }
        [queryStr appendString:key];
        [queryStr appendString:@"="];
        NSString *value = XT_Object_To_Stirng([dic objectForKey:key]);
        [queryStr appendString:value];
    }];
    
    if ([url rangeOfString:@"?"].location == NSNotFound) {
        return [XTUtility xt_urlEncode:[NSString stringWithFormat:@"%@?%@",url,queryStr]];
    }
    
    return [XTUtility xt_urlEncode:[NSString stringWithFormat:@"%@&%@",url,queryStr]];
}

- (NSString *)webUrlAppendQueryParameterToUrl:(NSString *)url {
    NSDictionary *para = self.headerDic;
    return [XTBaseApi webUrlAppendDicToUrl:url dic:para];
}
+ (NSString *)webUrlAppendDicToUrl:(NSString *)url dic:(NSDictionary *)dic {
    if (!url || !dic) {
        return url;
    }
    //
    NSMutableString *queryStr = [NSMutableString string];
    [dic.allKeys enumerateObjectsUsingBlock:^(id  _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        if (queryStr.length > 0) {
            [queryStr appendString:@"&"];
        }
        [queryStr appendString:key];
        [queryStr appendString:@"="];
        NSString *value = XT_Object_To_Stirng([dic objectForKey:key]);
        [queryStr appendString:value];
    }];
    
    if ([url rangeOfString:@"?"].location == NSNotFound) {
        return [NSString stringWithFormat:@"%@?%@",url,queryStr.xt_encodeString];
    }
    
    return [NSString stringWithFormat:@"%@&%@",url,queryStr.xt_encodeString];
}
/**
 网络请求

 @param success 网络请求成功回调
 @param failure 网络请求失败回调
 */
- (void)xt_startRequestSuccess:(nullable XTDicAndStrBlock)success
                       failure:(nullable XTDicAndStrBlock)failure
                         error:(void (^)(NSError *error))error{
    YTKNetworkAgent *agent = [YTKNetworkAgent sharedAgent];
    NSSet *acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", @"text/css",@"image/jpeg",@"image/png",@"application/octet-stream", nil];
    NSString *keypath = @"jsonResponseSerializer.acceptableContentTypes";
    [agent setValue:acceptableContentTypes forKeyPath:keypath];
    @weakify(self)
    [self startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *resultDic = request.responseObject;
        [self printLogTitle:@"请求成功" request:request];
        dispatch_async(dispatch_get_main_queue(), ^{
            if([resultDic isKindOfClass:[NSDictionary class]]) {
                NSString *imeimeasurabilityNc = XT_Object_To_Stirng(resultDic[@"imeasixsurabilityNc"]);
                if([@"00" isEqualToString:imeimeasurabilityNc] || [@"0" isEqualToString:imeimeasurabilityNc]){
                    if(success) {
                        success(resultDic[@"viussixNc"],resultDic[@"frwnsixNc"]);
                    }
                    return;
                }
                ///重新登录
                if([@"-2" isEqualToString:imeimeasurabilityNc]){
                    if(error) {
                        error(nil);
                    }
                    [XTUtility xt_login:nil];
                    return;
                }
                if(failure) {
                    failure(resultDic[@"viussixNc"],resultDic[@"frwnsixNc"]);
                }
            }
            else{
                if(error) {
                    error(nil);
                }
            }
        });
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        @strongify(self)
        [self printLogTitle:@"请求失败" request:request];
        [XTUtility xt_showTips:request.error.localizedDescription view:nil];
        if(error) {
            error(request.error);
        }
//        NSDictionary *resultDic = request.responseObject;
//        XTLog(@"请求失败:%@\n%@",[NSString stringWithFormat:@"%@/%@",[self baseUrl],[self requestUrl]],request.responseString);
    }];
}

- (void)printLogTitle:(NSString *)title request:(YTKBaseRequest*)request {
    
    BOOL isRelsease = YES;
#ifdef DEBUG
    isRelsease = NO;
#else
    isRelsease = YES;
#endif
    
    if(isRelsease==YES){
        return;
    }
    NSString *requestUrl  = [NSString stringWithFormat:@"%@/%@",[self baseUrl],[self requestUrl]];

    @try {
        /*
         请求结果
         */
        NSString *respondStr =request.responseString;
        /*
         请求参数
         */
        NSString *requestArgument = [self requestArgument];
        if (requestArgument) {
            NSData *jsonData  = [NSJSONSerialization dataWithJSONObject:[self requestArgument] options:NSJSONWritingPrettyPrinted error:nil];
            requestArgument = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
        
        XTRequestLog(title,NSStringFromClass([self class]),requestUrl, [self requestType], [self requestHeaderFieldValueDictionary],requestArgument,[self responseHeadersFieldValueDictionary], [XTUtility xt_objectFromJSON:respondStr]);
    } @catch (NSException *exception) {
        XTLog(@"%@",exception);
        XTLog(@"%@",requestUrl);
    } @finally {
        
    }
   
}

//请求类型转换
- (NSString *)requestType {
    YTKRequestMethod method = [self requestMethod];
    switch (method) {
        case YTKRequestMethodGET:
            return @"Get";
            break;
        case YTKRequestMethodPOST:
            return @"Post";
            break;
        case YTKRequestMethodHEAD:
            return @"Head";
            break;
        case YTKRequestMethodPUT:
            return @"Put";
            break;
        case YTKRequestMethodDELETE:
            return @"Delete";
            break;
        case YTKRequestMethodPATCH:
            return @"Patch";
            break;
        default:
            return @"";
            break;
    }
}

@end
