//
//  PUBJSManager.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/17.
//

#import "PUBJSManager.h"
#import <StoreKit/StoreKit.h>

@interface PUBJSManager ()
@property(nonatomic, copy) ReturnStrBlock  __nullable callBlock;
@end

@implementation PUBJSManager
SINGLETON_M(PUBJSManager)

- (void)receiveScriptMessage:(WKScriptMessage *)message CallBlock:(ReturnStrBlock)callBlock
{
//    NSDictionary *dic = message.body;
//    if ([PBTools isBlankObject:dic]) {
//        return;
//    }
//    self.key = dic[@"data"];
//    if ([PBTools isBlankString:self.key]) {
//        return;
//    }
    self.callBlock = callBlock;
    SEL selector = NSSelectorFromString(STR_FORMAT(@"%@:", message.name));
    if ([self respondsToSelector:selector]) {
        [self performSelector:selector withObject:message.body afterDelay:0];
    } else {
        selector = NSSelectorFromString(STR_FORMAT(@"%@", message.name));
        if ([self respondsToSelector:selector]) {
            [self performSelector:selector withObject:message.body afterDelay:0];
        }
    }
}

//- (void)quintessenti:(id)dic
//{
//    if (self.callBlock) {
//        self.callBlock = nil;
//    }
//    if ([dic isKindOfClass:[NSArray class]]) {
//        NSArray * acpaeetee = dic;
//        if (acpaeetee != nil && acpaeetee.count > 3) {
//            NSString * starTime = acpaeetee[0];
//            NSString * endTime = acpaeetee[1];
//            NSString * productId = acpaeetee[2];
//            NSString * orderId = acpaeetee[3];
//
////            [PBCommonManager reportDangerRequest:[NSNumber numberWithDouble:[starTime integerValue]] endTime:[NSNumber numberWithDouble:[endTime integerValue]] scene:@"11" productId: productId orderId: orderId];
//        }
//    }
//    
//}

- (void)quintessenti:(NSString*)str
{
    if(self.callBlock){
        NSDictionary *dic = @{
                              @"nonrecurring_eg":@(PUBLocation.longitude),
                              @"neuroleptic_eg":@(PUBLocation.latitude),
                              @"infortune_eg" : [NSObject getIDFV],
                              };
        NSString *jsonStr = [PUBTools jsonStringWithDictionary:dic];
        self.callBlock([NSString  stringWithFormat:@"epiphany('%@')",jsonStr]);
        self.callbackId = nil;
    }
}

- (void)openCall:(NSString *)phone
{
    if(self.callBlock){
        self.callBlock = nil;
    }
    
    NSString * tel = [[phone stringByReplacingOccurrencesOfString:@" " withString:@""] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
     NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"tel://%@", tel]];
     if (url && [[UIApplication sharedApplication] canOpenURL:url]) {
         [[UIApplication sharedApplication] openURL:url options:nil completionHandler:^(BOOL success) {
             //
         }];
     }
}

- (void)goHome 
{
    [VCManager switchTabAtIndex:0];
}

- (void)goScore
{
    if (@available(iOS 14.0, *)) {
        UIWindowScene *scene = [VCManager topViewController].view.window.windowScene;
        [SKStoreReviewController requestReviewInScene:scene];
    } else if (@available(iOS 10.3, *)){
        [SKStoreReviewController requestReview];
    }
}

- (void)goAppstore:(NSString*)url
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}


//原生页面跳转 uewvhgaa(String url)
- (void)goRun:(NSString *)url {
//    PBRouteModel *model = [[PBRouteModel alloc] init];
//    model.url = url;
    [PUBRouteManager routeWitheNextPage:url productId:@""];
}


@end
