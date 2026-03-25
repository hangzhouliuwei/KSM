//
//  BagBaseRequest.m
//  NewBag
//
//  Created by Jacky on 2024/3/12.
//

#import "BagBaseRequest.h"
#import <MBProgressHUD.h>
#import "BagRequestUrlArgumentsFilter.h"
@interface XBBaseRequestDelegate : NSObject

@end
@interface XBBaseRequestDelegate ()<YTKRequestDelegate,YTKRequestAccessory>

@end
@implementation XBBaseRequestDelegate

- (void)requestFinished:(__kindof BagBaseRequest *)request
{
    NSString *url = request.requestUrl;
    NSString *responseString = request.responseString;
    NSLog(@"\n=================\nXBBaseRequest 返回结果:\n>>>>>>%@ url=%@ \n responseString = %@\n=================",request.requestMethod == 0 ? @"GET" : @"Post",url,responseString);
    //101401 登录态失效 101402 登录态被顶掉
    if (request.response_code == -2 ) {
        [[BagUserManager shareInstance] logout];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[BagRouterManager shareInstance] jumpLogin];
        });
    }
}
- (void)requestFailed:(__kindof BagBaseRequest *)request;
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
@interface BagBaseRequest ()
@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, strong) XBBaseRequestDelegate *requestDelegate;
@end
@implementation BagBaseRequest
- (instancetype)init
{
    if (self = [super init]) {
        self.isShowLoading = NO;
        self.delegate = self.requestDelegate;
        [self addAccessory:self.requestDelegate];
        [[YTKNetworkConfig sharedConfig] clearUrlFilter];
        BagRequestUrlArgumentsFilter *filter = [BagRequestUrlArgumentsFilter filterWithArguments];
        [[YTKNetworkConfig sharedConfig] addUrlFilter:filter];
        NSLog(@"lw=======>urlFilters%@",[YTKNetworkConfig sharedConfig].urlFilters);
    }
    return self;
}
- (NSInteger)response_code
{
    NSString *code = self.responseObject[@"taxidermyF"];
    return code.integerValue;
}
- (NSString *)response_message
{
    NSString *message = self.responseObject[@"camoufleurF"];
    return message;
}
- (NSDictionary *)response_dic
{
    return self.responseObject[@"daemonF"];
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
- (XBBaseRequestDelegate *)requestDelegate
{
    if (!_requestDelegate) {
        _requestDelegate = [XBBaseRequestDelegate new];
    }
    return _requestDelegate;
}
- (void)dealloc
{

}
@end
