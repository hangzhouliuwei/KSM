//
//  PUBRequestManager.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/15.
//

#import "PUBRequestManager.h"
#import <AFNetworking/AFNetworking.h>
#import "PUBEnvironmentManager.h"

@interface PUBRequestManager ()
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation PUBRequestManager
SINGLETON_M(PUBRequestManager)

- (instancetype)init{
    self = [super init];
    if (self) {
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:nil sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
        _manager.requestSerializer.timeoutInterval = 60;
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/json", @"text/javascript", @"text/html", nil];
        _manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
        [self resetNetworkType];
    }
    return self;
}

- (void)resetNetworkType {
    self.baseUrl = [NSString stringWithFormat:@"%@/credit",PUBEnvironment.host];
    self.h5Url = PUBEnvironment.host;
#ifdef DEBUG
    _networkType = (NSInteger)[[PUBCacheManager sharedPUBCacheManager] getcacheYYObjectWithKey:NetworkType];
    if (_networkType == NLNetworkPathTypeRelease) {
        self.baseUrl = [NSString stringWithFormat:@"%@/credit",PUBEnvironment.host];
        self.h5Url = PUBEnvironment.host;
    }else if (_networkType == NLNetworkPathTypePre) {
        self.baseUrl = [NSString stringWithFormat:@"%@/credit",PUBEnvironment.host];
        self.h5Url = PUBEnvironment.host;
    }
#endif
}

- (void)loadAuthHeader {
//    if (User.isLogin) {
//        PBSignModel *sign = [PBCacheManager objectForKey:@"sign"];
////        [_manager.requestSerializer setValue:sign.token forHTTPHeaderField:@"token"];
////        [_manager.requestSerializer setValue:sign.appId forHTTPHeaderField:@"appId"];
//        [_manager.requestSerializer setValue:sign.sessionId forHTTPHeaderField:@"acidification_bag"];
//        [_manager.requestSerializer setValue:sign.mobile forHTTPHeaderField:@"racketeering_bag"];
//    }
}

- (void)loadBaseHeader {
    [_manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"jeu_eg"];//终端版本
    [_manager.requestSerializer setValue:NotNull([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]) forHTTPHeaderField:@"geanticline_eg"];//app版本
    
    NSString *deviceName = [NSObject getMobileStyle];
    [_manager.requestSerializer setValue:NotNull(deviceName) forHTTPHeaderField:@"lectionary_eg"];//设备名称
    
    NSString *idfv = [NSObject getIDFV];
    [_manager.requestSerializer setValue:idfv forHTTPHeaderField:@"embonpoint_eg"];//idfv
    
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    [_manager.requestSerializer setValue:phoneVersion forHTTPHeaderField:@"knob_eg"];//设备os版本
    
    [_manager.requestSerializer setValue:@"ph" forHTTPHeaderField:@"disrupture_eg"];//市场
    
    [_manager.requestSerializer setValue: [NSBundle mainBundle].bundleIdentifier forHTTPHeaderField: @"unselfishness_eg"];//包名
    WEAKSELF
    [NSObject getIdfa:^(NSString *idfa) {
        STRONGSELF
        [strongSelf.manager.requestSerializer setValue:NotNull(idfa) forHTTPHeaderField:@"woosh_eg"];//idfa
    }];
    
    if(User.isLogin){
        [_manager.requestSerializer setValue:User.username forHTTPHeaderField:@"faithful_eg"];//市场
        
        [_manager.requestSerializer setValue: User.sessionid forHTTPHeaderField: @"aleph_eg"];//包名
    }
}

- (NSString *)loadCommonParameter {
    // iOS 9 之后
//    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
//    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    __block  NSString *wenStr = @"?";
//    wenStr = [wenStr stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    
    __block  NSString *qieStr = @"&";
//    qieStr = [qieStr stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    
  __block NSString *pathStr = wenStr;

    
//    [_manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"beth_bag"];//终端版本
    pathStr = [pathStr stringByAppendingString:STR_FORMAT(@"jeu_eg=%@", @"ios")];
    
//    [_manager.requestSerializer setValue:NotNull([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]) forHTTPHeaderField:@"categorize_bag"];//app版本
    pathStr = [pathStr stringByAppendingString:STR_FORMAT(@"%@geanticline_eg=%@", qieStr,NotNull([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]))];
    
    NSString *deviceName = [NSObject getMobileStyle];
//    [_manager.requestSerializer setValue:NotNull([PBTools base64String:deviceName]) forHTTPHeaderField:@"trough_bag"];//设备名称
    pathStr = [pathStr stringByAppendingString:STR_FORMAT(@"%@lectionary_eg=%@", qieStr, NotNull(deviceName))];

    NSString *idfv = [NSObject getIDFV];
//    [_manager.requestSerializer setValue:idfv forHTTPHeaderField:@"chopboat_bag"];//idfv
    pathStr = [pathStr stringByAppendingString:STR_FORMAT(@"%@embonpoint_eg=%@", qieStr, idfv)];
    
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
//    [_manager.requestSerializer setValue:phoneVersion forHTTPHeaderField:@"growler_bag"];//设备os版本
    pathStr = [pathStr stringByAppendingString:STR_FORMAT(@"%@knob_eg=%@", qieStr, phoneVersion)];
    
//    [_manager.requestSerializer setValue:@"ph" forHTTPHeaderField:@"idolize_bag"];//市场
    pathStr = [pathStr stringByAppendingString:STR_FORMAT(@"%@disrupture_eg=%@", qieStr, @"ph")];
    
//    [_manager.requestSerializer setValue:@"com.PB.PerabagProject" forHTTPHeaderField:@"endothelioma_bag"];//包名
    pathStr = [pathStr stringByAppendingString:STR_FORMAT(@"%@unselfishness_eg=%@", qieStr, [NSBundle mainBundle].bundleIdentifier)];
    
    [NSObject getIdfa:^(NSString *idfa) {
        pathStr = [pathStr stringByAppendingString:STR_FORMAT(@"%@woosh_eg=%@", qieStr, idfa)];
    }];
    
    if (User.isLogin) {
        pathStr = [pathStr stringByAppendingString:STR_FORMAT(@"%@aleph_eg=%@", qieStr, User.sessionid)];
        pathStr = [pathStr stringByAppendingString:STR_FORMAT(@"%@faithful_eg=%@", qieStr, User.username)];
    }
    return pathStr;
}

- (void)getWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure {
    [self getWithPath:path params:params success:success failure:failure showLoading:NO];
}

- (void)getWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure showLoading:(BOOL)loading {
    if (loading) {
        [PUBTools showHud];
    }
    __block BOOL load = loading;
    __block NSString *pathStr = path;
    path = [path stringByAppendingString:[self loadCommonParameter]];
    NSString *urlString = [PUBTools urlZhEncode:[self.baseUrl stringByAppendingPathComponent:path]];
    NSLog(@"+++++000000------%@",urlString);
    [_manager GET:urlString parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (load) {
            [PUBTools hideHud];
        }
        NSLog(@"！！！！！------%@",urlString);
        NSDictionary *resDic = (NSDictionary *)responseObject;
        NSString *getStr = [self toJSONData:resDic path:pathStr];
        PUBBaseResponseModel *model = [[PUBBaseResponseModel alloc] initModelWithDic:resDic path:pathStr];
        if ([self managerReturnData:model]) {
            return;
        }
        success(resDic,model);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (load) {
            [PUBTools hideHud];
        }
        failure(error);
    }];
}

- (void)postWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure {
    [self postWithPath:path params:params success:success failure:failure showLoading:NO];
}

- (void)postWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure showLoading:(BOOL)loading {
    if (loading) {
        NSString *tips = @"";
        [PUBTools showHud:tips];
    }
    __block BOOL load = loading;
    __block NSString *pathStr = path;
    path = [path stringByAppendingString:[self loadCommonParameter]];
    NSString *urlString = [PUBTools urlZhEncode:[self.baseUrl stringByAppendingPathComponent:path]];
    [_manager POST:urlString parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (load) {
            [PUBTools hideHud];
        }
        NSLog(@"lw------urlString%@",urlString);
        NSDictionary *resDic = (NSDictionary *)responseObject;
        NSString *postStr = [self toJSONData:resDic path:pathStr];
        NSLog(@"lw==josn%@", postStr);
        PUBBaseResponseModel *model = [[PUBBaseResponseModel alloc] initModelWithDic:resDic path:pathStr];
        if ([self managerReturnData:model]) {
            return;
        }
        success(resDic,model);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (load) {
            [PUBTools hideHud];
        }
        failure(error);
        NSLog(@"faild==%@", error);
    }];
}


- (void)getDomainNameWithUrl:(NSString *)url params:(NSDictionary *)params success:(HttpDomainSuccessBlock)success failure:(HttpFailureBlock)failure showLoading:(BOOL)loading
{
    if (loading) {
        [PUBTools showHud];
    }
    __block BOOL load = loading;
    __block NSString *urlString = url;
    [_manager GET:urlString parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (load) {
            [PUBTools hideHud];
        }
        NSDictionary *resDic = (NSDictionary *)responseObject;
        success(resDic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        if (load) {
            [PUBTools hideHud];
        }
        failure(error);
    }];
}


- (BOOL)managerReturnData:(PUBBaseResponseModel *)model {
    if (model.success) {
        if ([@[PB_login] containsObject:model.path]) {
            [self loginResult:model];//登录接口处理
        }
        return NO;
    }
    if ([model.code isEqualToString:@"-2"]) {//token失效或者为空
        [self showLoginVC];
        return YES;
    }else if ([model.code isEqualToString:@"-2"]) {//token登陆过期
//        [PBTools showToast:@"登录已过期，请重新登录" time:3];
        [self showLoginVC];
        return YES;
    }else if ([model.code isEqualToString:@"00102019003"]) {//密码修改
//        [PBTools showToast:@"密码已修改，请重新登录" time:3];
        [self showLoginVC];
        return YES;
    }else if ([model.code isEqualToString:@"00102011001"]) {//弹框
        return NO;
    }else if (!model.success) {//toast
        return NO;
    }
    return NO;
}

- (void)showLoginVC {
    [User logoutCallServer];
    [PUBTools checkLogin:^(NSInteger uid) {
        
    }];
}

- (void)loginResult:(PUBBaseResponseModel *)model {
//    [_manager.requestSerializer setValue:model.dataDic[@"comfit_bag"] forHTTPHeaderField:@"acidification_bag"];
//    [_manager.requestSerializer setValue:model.dataDic[@"homeopathic_bag"] forHTTPHeaderField:@"racketeering_bag"];
    
//    PBSignModel *sign = [[PBSignModel alloc] init];
//    sign.token = model.dataDic[@"inexpensive_bag"][@"decommitment_bag"];
////    sign.appId = model.dataDic[@"appId"];
//    sign.sessionId = model.dataDic[@"inexpensive_bag"][@"comfit_bag"];
//    sign.mobile = model.dataDic[@"inexpensive_bag"][@"homeopathic_bag"];
//    [PBCacheManager saveObject:sign forKey:@"sign"];
//
//    [User loginUserData:model.dataDic];
}

- (void)downloadWithPath:(NSString *)path success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure progress:(HttpDownloadProgressBlock)progress {

    // 获取完整的url路径
    NSString *url = [self.baseUrl stringByAppendingPathComponent:path];

    // 下载
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];

    NSURLSessionDownloadTask *downloadTask = [_manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {

        progress(downloadProgress.fractionCompleted);

    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {

        // 获取沙盒cache路径
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];

        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];

    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {

        if (error) {
            failure(error);
        } else {
            success(nil,nil);
        }

    }];

    [downloadTask resume];
}

- (void)uploadImageWithPath:(NSString *)path params:(NSDictionary *)params thumbName:(NSString *)thumbName image:(UIImage *)image success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure progress:(HttpUploadProgressBlock)progress {
    [PUBTools showHud];
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    path = [path stringByAppendingString:[self loadCommonParameter]];
    __block NSString *pathStr = [PUBTools urlZhEncode:[self.baseUrl stringByAppendingPathComponent:path]];
    [_manager POST:pathStr parameters:params headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

        formatter.dateFormat = @"yyyyMMddHHmmss";

        NSString *str = [formatter stringFromDate:[NSDate date]];
        
        NSString *fileName = [[NSString alloc] init];
        if (UIImagePNGRepresentation(image) != nil) {
        fileName = STR_FORMAT(@"%@%@.png", thumbName,str);
        }else{
        fileName = STR_FORMAT(@"%@%@.jpg", thumbName,str);
        }
        
        [formData appendPartWithFileData:data name:STR_FORMAT(@"%@", thumbName) fileName:fileName mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [PUBTools hideHud];
        NSDictionary *resDic = (NSDictionary *)responseObject;
        NSString *postStr = [self toJSONData:resDic path:pathStr];
        NSLog(@"lw==josn%@", postStr);
        PUBBaseResponseModel *model = [[PUBBaseResponseModel alloc] initModelWithDic:resDic path:pathStr];
        if (!model.success) {
            [PUBTools showToast:model.desc];
        }
        success(resDic,model);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [PUBTools hideHud];
        failure(error);
    }];
}

- (void)uploadImagesWithPath:(NSString *)path
                     params:(NSDictionary *)params
                  thumbName:(NSString *)thumbName
                  imageList:(NSMutableArray *)imageList
                    success:(HttpSuccessBlock)success
                    failure:(HttpFailureBlock)failure
                    progress:(HttpUploadProgressBlock)progress {
    [PUBTools showHud];
        
    __block NSString *pathStr = [PUBTools urlZhEncode:[self.baseUrl stringByAppendingPathComponent:path]];
    [_manager POST:pathStr parameters:params headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

        for (int i = 0; i < imageList.count; i++) {
            NSData *data = UIImageJPEGRepresentation(imageList[i], 0.5);
            NSLog(@"-----%@",data);
            [formData appendPartWithFileData:data name:@"file" fileName:STR_FORMAT(@"%@.png", thumbName) mimeType:@"image/octet-stream"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [PUBTools hideHud];
        NSDictionary *resDic = (NSDictionary *)responseObject;
        PUBBaseResponseModel *model = [[PUBBaseResponseModel alloc] initModelWithDic:resDic path:pathStr];
        if (!model.success) {
            [PUBTools showToast:model.desc];
        }
        success(resDic,model);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [PUBTools hideHud];
        failure(error);
    }];
}

- (void)updateNetWorkStatus {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                self.networkStatus = NLNetworkStatusUnNone;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                self.networkStatus = NLNetworkStatusUnknown;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                self.networkStatus = NLNetworkStatusWAN;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                self.networkStatus = NLNetworkStatusWiFi;
                break;
            default:
                break;
        }
    }];
}

- (NSString *)toJSONData:(id)theData path:(NSString *)path
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = @"";
    if (!error) {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"jsonString:%@_______%@", path, jsonString);
    }
    return jsonString;
}

+ (NSString *)commonParameter {
    // iOS 9 之后
    //    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    //    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
  __block  NSString *wenStr = @"";
    //    wenStr = [wenStr stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];

    __block NSString *qieStr = @"&";
    //    qieStr = [qieStr stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];

    __block NSString *pathStr = wenStr;


    //    [_manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"beth_bag"];//终端版本
    pathStr = [pathStr stringByAppendingString:STR_FORMAT(@"jeu_eg=%@", @"ios")];

    //    [_manager.requestSerializer setValue:NotNull([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]) forHTTPHeaderField:@"categorize_bag"];//app版本
    pathStr = [pathStr stringByAppendingString:STR_FORMAT(@"%@geanticline_eg=%@", qieStr,NotNull([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]))];

    NSString *deviceName = [NSObject getMobileStyle];
    //    [_manager.requestSerializer setValue:NotNull([PBTools base64String:deviceName]) forHTTPHeaderField:@"trough_bag"];//设备名称
    pathStr = [pathStr stringByAppendingString:STR_FORMAT(@"%@lectionary_eg=%@", qieStr, NotNull(deviceName))];

    NSString *idfv =[NSObject getIDFV];
    //    [_manager.requestSerializer setValue:idfv forHTTPHeaderField:@"chopboat_bag"];//idfv
    pathStr = [pathStr stringByAppendingString:STR_FORMAT(@"%@embonpoint_eg=%@", qieStr, idfv)];

    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    //    [_manager.requestSerializer setValue:phoneVersion forHTTPHeaderField:@"growler_bag"];//设备os版本
    pathStr = [pathStr stringByAppendingString:STR_FORMAT(@"%@knob_eg=%@", qieStr, phoneVersion)];

    //    [_manager.requestSerializer setValue:@"ph" forHTTPHeaderField:@"idolize_bag"];//市场
    pathStr = [pathStr stringByAppendingString:STR_FORMAT(@"%@disrupture_eg=%@", qieStr, @"ph")];

    //    [_manager.requestSerializer setValue:@"com.PB.PerabagProject" forHTTPHeaderField:@"endothelioma_bag"];//包名
    pathStr = [pathStr stringByAppendingString:STR_FORMAT(@"%@unselfishness_eg=%@", qieStr, [NSBundle mainBundle].bundleIdentifier)];

    [NSObject getIdfa:^(NSString *idfa) {
        pathStr = [pathStr stringByAppendingString:STR_FORMAT(@"%@woosh_eg=%@", qieStr, idfa)];
    }];

    if (User.isLogin) {
        pathStr = [pathStr stringByAppendingString:STR_FORMAT(@"%@aleph_eg=%@", qieStr, User.sessionid)];
        pathStr = [pathStr stringByAppendingString:STR_FORMAT(@"%@faithful_eg=%@", qieStr, User.username)];
    }
    return pathStr;
}



@end
