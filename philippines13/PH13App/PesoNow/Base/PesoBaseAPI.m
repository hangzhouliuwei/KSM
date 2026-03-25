//
//  PesoBaseAPI.m
//  PesoApp
//
//  Created by Jacky on 2024/9/9.
//

#import "PesoBaseAPI.h"
#import <MBProgressHUD.h>
#import "PesoRequestArguments.h"
#import "PesoRouterCenter.h"

@interface PesoBaseRequestDelegate ()<YTKRequestDelegate,YTKRequestAccessory>

@end

@implementation PesoBaseRequestDelegate

- (void)requestFinished:(__kindof PesoBaseAPI *)request
{
    NSString *url = request.requestUrl;
    NSString *responseString = request.responseString;
    NSLog(@"\n=================\nPHBaseRequest 返回结果:\n>>>>>>%@ url=%@ \n responseString = %@\n=================",request.requestMethod == 0 ? @"GET" : @"Post",url,responseString);
   
    if (request.responseCode == -2 ) {
        [[PesoUserCenter sharedPesoUserCenter] logout];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[PesoRootVCCenter sharedPesoRootVCCenter] checkLogin:^{
                
            }];
        });
    }
}
- (void)requestFailed:(__kindof PesoBaseAPI *)request;
{
    
}
#pragma mark - YTKRequestAccessory
- (void)requestWillStart:(YTKRequest *)request
{
    NSDictionary *param = [request requestArgument];
    NSString *url = request.requestUrl;
    
    NSLog(@"lw======\n=================\nPHBaseRequest:\n >>>>>>%@ url=%@ \n=============== param=%@",request.requestMethod == 0 ? @"GET" : @"Post",url,param);
}
- (void)requestWillStop:(id)request
{
    
}
- (void)requestDidStop:(id)request
{
    
}


@end
@interface PesoBaseAPI ()
@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, strong) PesoBaseRequestDelegate *requestDelegate;
@end
@implementation PesoBaseAPI
- (instancetype)init
{
    if (self = [super init]) {
        [self config];
    }
    return self;
}
- (instancetype)initWithData:(id)data
{
    if (self = [super init]) {
        [self config];
    }
    return self;
}
- (void)config{
    self.showLoading = NO;
    self.delegate = self.requestDelegate;
    [self addAccessory:self.requestDelegate];
    [[YTKNetworkConfig sharedConfig] clearUrlFilter];
    PesoRequestArguments *filter = [PesoRequestArguments filterWithArguments];
    [[YTKNetworkConfig sharedConfig] addUrlFilter:filter];
}
- (NSInteger)responseCode
{
    NSString *code = self.responseObject[@"imeathirteensurabilityNc"];
    return code.integerValue;
}
- (NSString *)responseMessage
{
    NSString *message = self.responseObject[@"frwnthirteenNc"];
    return message;
}
- (NSDictionary *)responseDic
{
    return self.responseObject[@"viusthirteenNc"];
}
- (void)hiddenLoading
{
    [self.hud hideAnimated:YES ];
}

- (void)toggleAccessoriesWillStartCallBack
{
    if (self.showLoading) {
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
    return 30.f;
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
- (PesoBaseRequestDelegate *)requestDelegate
{
    if (!_requestDelegate) {
        _requestDelegate = [[PesoBaseRequestDelegate alloc] init];
    }
    return _requestDelegate;
}
- (void)dealloc
{

}
@end
