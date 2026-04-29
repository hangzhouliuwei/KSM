//
//  PTBaseRequest.m
//  PTApp
//
//  Created by 刘巍 on 2024/7/15.
//

#import "PTBaseRequest.h"
#import <MBProgressHUD.h>
#import "PTNetworkConfig.h"

static NSString * const PTResponseCodeKey = @"imteneasurabilityNc";
static NSString * const PTResponseMessageKey = @"frtenwnNc";
static NSString * const PTResponseDataKey = @"vitenusNc";
static NSString * const PTRequestLanguageHeader = @"We-Lang";
static NSString * const PTRequestDefaultLanguage = @"en-US";
static NSInteger const PTUnauthorizedResponseCode = -2;
static NSTimeInterval const PTDefaultRequestTimeout = 60.0;

static NSDictionary *PTResponseDictionary(id responseObject)
{
    return [responseObject isKindOfClass:NSDictionary.class] ? responseObject : @{};
}

static NSString *PTRequestMethodName(YTKRequestMethod method)
{
    switch (method) {
        case YTKRequestMethodGET:
            return @"GET";
        case YTKRequestMethodPOST:
            return @"POST";
        case YTKRequestMethodHEAD:
            return @"HEAD";
        case YTKRequestMethodPUT:
            return @"PUT";
        case YTKRequestMethodDELETE:
            return @"DELETE";
        case YTKRequestMethodPATCH:
            return @"PATCH";
    }

    return @"UNKNOWN";
}

@interface PTBaseRequestObserver : NSObject

@end

@interface PTBaseRequestObserver ()<YTKRequestDelegate,YTKRequestAccessory>

@end

@implementation PTBaseRequestObserver

- (void)requestFinished:(__kindof PTBaseRequest *)request
{
    NSLog(@"\n=================\nPTBaseRequest Response:\n%@ %@\n%@\n=================",
          PTRequestMethodName(request.requestMethod),
          request.requestUrl,
          request.responseString);
    //101401 登录态失效 101402 登录态被顶掉
    if (request.response_code == PTUnauthorizedResponseCode) {
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
    NSLog(@"\n=================\nPTBaseRequest Request:\n%@ %@\nparams=%@\n=================",
          PTRequestMethodName(request.requestMethod),
          request.requestUrl,
          request.requestArgument);
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
@property (nonatomic, strong) PTBaseRequestObserver *requestObserver;
@end

@implementation PTBaseRequest

- (instancetype)init
{
    if (self = [super init]) {
        self.isShowLoading = NO;
        self.delegate = self.requestObserver;
        [self addAccessory:self.requestObserver];
        [PTNetworkConfig installURLFilterIfNeeded];
    }
    return self;
}
- (NSInteger)response_code
{
    id code = PTResponseDictionary(self.responseObject)[PTResponseCodeKey];
    return [code respondsToSelector:@selector(integerValue)] ? [code integerValue] : NSNotFound;
}
- (NSString *)response_message
{
    id message = PTResponseDictionary(self.responseObject)[PTResponseMessageKey];
    return [message isKindOfClass:NSString.class] ? message : @"";
}
- (NSDictionary *)response_dic
{
    id data = PTResponseDictionary(self.responseObject)[PTResponseDataKey];
    return [data isKindOfClass:NSDictionary.class] ? data : @{};
}
- (void)hiddenLoading
{
    [self.hud hideAnimated:YES];
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
        [weakSelf.hud hideAnimated:YES];
        [weakSelf.hud removeFromSuperview];
        weakSelf.hud = nil;
    });
    [super toggleAccessoriesDidStopCallBack];
}
- (NSTimeInterval)requestTimeoutInterval
{
    return PTDefaultRequestTimeout;
}
- (NSString *)contentType
{
    return @"application/json";
}
- (YTKRequestSerializerType)requestSerializerType
{
    return YTKRequestSerializerTypeJSON;
}
- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary
{
    return @{PTRequestLanguageHeader: PTRequestDefaultLanguage};
}
- (MBProgressHUD *)hud
{
    if (!_hud) {
        UIView *containerView = [PTNetworkConfig visibleWindow] ?: UIApplication.sharedApplication.delegate.window;
        if (containerView) {
            _hud = [[MBProgressHUD alloc] initWithView:containerView];
            [containerView addSubview:_hud];
        } else {
            _hud = [[MBProgressHUD alloc] init];
        }
        _hud.label.text = self.loadingText ? : @"";
        [_hud hideAnimated:NO];
    }
    return _hud;
}
- (PTBaseRequestObserver *)requestObserver
{
    if (!_requestObserver) {
        _requestObserver = [[PTBaseRequestObserver alloc] init];
    }
    return _requestObserver;
}
- (void)dealloc
{

}
@end
