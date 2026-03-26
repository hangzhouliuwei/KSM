//
//  PTBaseRequest.m
//  PTApp
//
//  Created by 刘巍 on 2024/7/15.
//

#import "PTBaseRequest.h"
#import <MBProgressHUD.h>
#import "PTRequestUrlArgumentsFilter.h"

@interface PTBaseRequestDelegate : NSObject

@end

@interface PTBaseRequestDelegate ()<YTKRequestDelegate,YTKRequestAccessory>

@end

@implementation PTBaseRequestDelegate

- (void)requestFinished:(__kindof PTBaseRequest *)request
{
    NSString *url = request.requestUrl;
    NSString *responseString = request.responseString;
    NSLog(@"\n=================\nXBBaseRequest 返回结果:\n>>>>>>%@ url=%@ \n responseString = %@\n=================",request.requestMethod == 0 ? @"GET" : @"Post",url,responseString);
    //101401 登录态失效 101402 登录态被顶掉
    if (request.response_code == -2 ) {
//        [[BagUserManager shareInstance] logout];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [[BagRouterManager shareInstance] jumpLogin];
//        });
    }
}
- (void)requestFailed:(__kindof PTBaseRequest *)request;
{
    
}
#pragma mark - YTKRequestAccessory
- (void)requestWillStart:(YTKRequest *)request
{
    NSDictionary *param = [request requestArgument];
    NSString *url = request.requestUrl;
    
    NSLog(@"lw======\n=================\nXBBaseRequest:\n >>>>>>%@ url=%@ \n=============== param=%@",request.requestMethod == 0 ? @"GET" : @"Post",url,param);
}
- (void)requestWillStop:(id)request
{
    
}
- (void)requestDidStop:(id)request
{
    
}


@end


@interface PTBaseRequest ()
@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, strong) PTBaseRequestDelegate *requestDelegate;
@end

@implementation PTBaseRequest

- (instancetype)init
{
    if (self = [super init]) {
        self.isShowLoading = NO;
        self.delegate = self.requestDelegate;
        [self addAccessory:self.requestDelegate];
        [[YTKNetworkConfig sharedConfig] clearUrlFilter];
        PTRequestUrlArgumentsFilter *filter = [PTRequestUrlArgumentsFilter filterWithArguments];
        [[YTKNetworkConfig sharedConfig] addUrlFilter:filter];
        NSLog(@"lw=======>urlFilters%@",[YTKNetworkConfig sharedConfig].urlFilters);
    }
    return self;
}
- (NSInteger)response_code
{
    NSString *code = self.responseObject[@"imteneasurabilityNc"];
    return code.integerValue;
}
- (NSString *)response_message
{
    NSString *message = self.responseObject[@"frtenwnNc"];
    return message;
}
- (NSDictionary *)response_dic
{
    return self.responseObject[@"vitenusNc"];
}
- (void)hiddenLoading
{
    [self.hud hideAnimated:YES ];
}

- (void)toggleAccessoriesWillStartCallBack
{
    if (self.isShowLoading) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.hud showAnimated:YES];
        });
    }
    [super toggleAccessoriesWillStartCallBack];
}
- (void)toggleAccessoriesDidStopCallBack
{
    WEAKSELF
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.hud hideAnimated: YES];
        [self.hud removeFromSuperview];
        weakSelf.hud = nil;
    });
    [super toggleAccessoriesDidStopCallBack];
}
- (NSTimeInterval)requestTimeoutInterval
{
    return 60.f;
}
- (NSString *)contentType {
    return @"application/json";
}
- (YTKRequestSerializerType)requestSerializerType
{
    return YTKRequestSerializerTypeJSON;
}
- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary
{
    NSMutableDictionary *headerDic = [NSMutableDictionary dictionaryWithCapacity:0];
    NSString *lanuage = @"en-US";
    [headerDic setObject:lanuage
                  forKey:@"We-Lang"];
    return headerDic;
}
- (MBProgressHUD *)hud
{
    if (!_hud) {
        _hud = [[MBProgressHUD alloc] init];
        [[UIApplication sharedApplication].keyWindow addSubview:_hud];
        _hud.label.text = self.loadingText ? : @"";
        [_hud hideAnimated:NO];
    }
    return _hud;
}
- (PTBaseRequestDelegate *)requestDelegate
{
    if (!_requestDelegate) {
        _requestDelegate = [[PTBaseRequestDelegate alloc] init];
    }
    return _requestDelegate;
}
- (void)dealloc
{

}
@end
