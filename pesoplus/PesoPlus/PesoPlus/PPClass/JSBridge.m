//
//  JSBridge.m
//  king
//
//  Created by jacky on 2023/9/4.
// 
//

#import "JSBridge.h"
#import <StoreKit/StoreKit.h>

@interface JSBridge ()
@end

@implementation JSBridge

SingletonM(JSBridge)

- (void)receiveScriptMessage:(WKScriptMessage *)message {
    id data = message.body;
    if (!data) {
        return;
    }
    self.key = message.name;
    if (isBlankStr(self.key)) {
        return;
    }
    SEL selector = NSSelectorFromString(StrFormat(@"%@:", self.key));
    if ([self respondsToSelector:selector]) {
        [self performSelector:selector withObject:data afterDelay:0];
    }else {
        selector = NSSelectorFromString(StrFormat(@"%@", message.name));
        if ([self respondsToSelector:selector]) {
            [self performSelector:selector withObject:message.body afterDelay:0];
        }
    }
}

- (void)callBack:(NSString *)str {
    if (isBlankStr(str)) {
        str = @"";
    }
    NSString *js = [NSString stringWithFormat:@"window.JSBridge.receiveMessage({data:'%@',callbackId:%@});", notNull(str), notNull(self.callbackId)];
    [self.respondsWebView evaluateJavaScript:js completionHandler:^(id object, NSError * _Nullable error) {
        NSLog(@"obj:%@---error:%@", object, error);
    }];
}

//@[@"dfiuvb01", @"dfiuvb02",@"dfiuvb03",@"dfiuvb04",@"dfiuvb05",@"dfiuvb06",@"dfiuvb07",]

- (void)dfiuvb01:(id)info {//point
    NSDictionary *dic = @{
                         @"rssheeneyCiopjko":@"",
                         @"rsnonallergenicCiopjko":[PPHandleDevicePhoneInfo mirjhaDeviceidfv],
                         @"rsestroneCiopjko":notNull(User.latitude),
                         @"rssplodgyCiopjko":notNull(User.longitude)
                         };
    NSString *jsonStr = [self jsonToString:dic];
    NSString *jsStr = [NSString stringWithFormat:@"dfiuvb02(%@)",jsonStr];
    [self.respondsWebView evaluateJavaScript:jsStr completionHandler:^(id object, NSError * _Nullable error) {
    }];

}

- (NSString *)jsonToString:(NSDictionary *)dic {
   NSError *error;
   NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
   NSString *jsonString;
   if (!jsonData) {
   }else{
       jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
   }
   NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
   NSRange range = {0,jsonString.length};
   [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
   NSRange range2 = {0,mutStr.length};
   [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
   return mutStr;
}

- (void)dfiuvb06:(id)info {//openAppstore
   NSString *url = (NSString *)info;
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options: @{} completionHandler:^(BOOL success) {
        
    }];
}

- (void)dfiuvb05:(id)info {//grage
    [SKStoreReviewController requestReview];
}

- (void)dfiuvb03:(id)info {//phonecall
    if ([info isKindOfClass:[NSString class]]) {
        NSString *str = (NSString *)info;
        NSString *temp = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
        temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        if (isBlankStr(temp)) {
            return;
        }
        NSMutableString *callStr = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",temp];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callStr] options:@{} completionHandler:nil];
    }
}

- (void)dfiuvb04:(id)info {//home
    [Page popToRootTabViewController];
}

@end
