//
//  BagJSManager.m
//  NewBag
//
//  Created by Jacky on 2024/4/15.
//

#import "BagJSManager.h"
#import <StoreKit/StoreKit.h>

@interface BagJSManager ()
@property (nonatomic, copy)void(^callBack)(NSString *);
@end
@implementation BagJSManager

+(instancetype)sharedInstance
{
    static BagJSManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[BagJSManager alloc] init];
    });
    return manager;
}
- (void)receiveScriptMessage:(WKScriptMessage *)message CallBlock:(void (^)(NSString * _Nonnull))callBlock
{
    self.callBack = callBlock;
    SEL selector = NSSelectorFromString([NSString stringWithFormat:@"%@:",message.name]);

    if ([self respondsToSelector:selector]) {
        [self performSelector:selector withObject:message.body afterDelay:0];
    } else {
        selector = NSSelectorFromString([NSString stringWithFormat:@"%@:",message.name]);
        if ([self respondsToSelector:selector]) {
            [self performSelector:selector withObject:message.body afterDelay:0];
        }
    }
}

- (void)fourteen001:(NSString*)str
{
    if(self.callBack){
        __block NSString *idfaStr = @"";
        [NSObject getIdfa:^(NSString * _Nonnull idfa) {
            idfaStr = NotNull(idfa);
        }];
        
        NSDictionary *dic = @{
            @"unevfourteenoutNc":@(BagLocationManager.shareInstance.longitude),
            @"boomfourteenofoNc":@(BagLocationManager.shareInstance.latitude),
            @"cacofourteentomyNc" : [NSObject getIDFV],
            @"spdifourteenlleNc" : idfaStr,
        };
        NSString *jsonStr = [dic yy_modelToJSONString];
        self.callBack([NSString  stringWithFormat:@"fourteen002(%@)",jsonStr]);
        self.callbackId = nil;
    }
}

- (void)fourteen003:(NSString *)phone
{
    if(self.callBack){
        self.callBack = nil;
    }
    
    NSString * tel = [[phone stringByReplacingOccurrencesOfString:@" " withString:@""] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
     NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"tel://%@", tel]];
     if (url && [[UIApplication sharedApplication] canOpenURL:url]) {
         [[UIApplication sharedApplication] openURL:url options:nil completionHandler:^(BOOL success) {
         }];
     }
}

- (void)fourteen004:(NSString *)home
{
    [[BagRouterManager shareInstance] setSelectedIndex:0 viewController:nil];
}

- (void)fourteen005:(NSString*)str
{
    if (@available(iOS 14.0, *)) {
        UIWindowScene *scene = [BagRouterManager.shareInstance getCurrentViewController].view.window.windowScene;
        [SKStoreReviewController requestReviewInScene:scene];
    } else if (@available(iOS 10.3, *)){
        [SKStoreReviewController requestReview];
    }
}

- (void)fourteen006:(NSString*)url
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}


//原生页面跳转 uewvhgaa(String url)
- (void)fourteen007:(NSString *)url {
    [BagRouterManager.shareInstance routeWithUrl:url];
}

@end
