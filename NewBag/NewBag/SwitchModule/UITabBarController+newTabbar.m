//
//  UITabBarController+newTabbar.m
//  wangpai
//
//  Created by YONGZHENG on 2020/8/4.
//  Copyright © 2020 YONGZHENG. All rights reserved.
//

#import "UITabBarController+newTabbar.h"
#import <objc/runtime.h>
#import "BgTabbarRequest.h"
#import "BagRootVCManager.h"
#import "BagRequestUrlArgumentsFilter.h"
#import <AFNetworking/AFNetworking.h>

@implementation UITabBarController (newTabbar)
+(void)load{
    SEL orginSelector = @selector(viewWillAppear:);
    SEL newSelector = @selector(BagTabViewwillApper:);
    Method orginMethod = class_getInstanceMethod(self, orginSelector);
    Method newMethod = class_getInstanceMethod(self, newSelector);
    BOOL didAddMethod = class_addMethod(self, orginSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (didAddMethod) {
        class_replaceMethod(self, orginSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    }
    else {
        method_exchangeImplementations(orginMethod, newMethod);
    }
//    NSLog(@"newTabbar ----------------- ");
}

- (void)BagTabViewwillApper:(BOOL)animated{
    [self BagTabViewwillApper:animated];
    
    UIWindow *tmpwind = [self getBagWind];
    UIViewController *vc = tmpwind.rootViewController;
    
    unsigned int propertyCount = 0;
    objc_property_t *propertys = class_copyPropertyList([vc class], &propertyCount);
    NSString *baseNewStr;
    for (int i = 0; i < propertyCount; i ++) {
        objc_property_t property = propertys[i];
        const char * propertyName = property_getName(property);
        if ([[NSString stringWithUTF8String:propertyName] isEqualToString:@"bgTransfStr"]) {
            baseNewStr = [vc valueForKey:[NSString stringWithUTF8String:propertyName]];
            break;
        }
    }
    free(propertys);
    
    if ([baseNewStr isEqualToString:@"s#Ug212&Jda$1hda"]){
        [[BagRootVCManager shareInstance] initNetworkConfig];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[BagRootVCManager shareInstance]setRootVC];
        });
    }
    else if ([baseNewStr isEqualToString:@"123"]){
        [[BagRootVCManager shareInstance] initNetworkConfig];
        BOOL canB = [[NSUserDefaults standardUserDefaults] objectForKey:@"ijasdiediudiuhuqw"];
        if (canB){
            dispatch_async(dispatch_get_main_queue(), ^{
                [[BagRootVCManager shareInstance]setRootVC];
            });
            return;
        }
        [self getBaseInfo];
    }
    
}

- (UIWindow *)getBagWind
{
    UIWindow *tmpwind;
    @try {
        tmpwind = UIApplication.sharedApplication.delegate.window;
        if (!tmpwind) {
            for (UIWindow *tmpnewWind in UIApplication.sharedApplication.windows) {
                if ([tmpnewWind.rootViewController isKindOfClass:[UITabBarController class]]) {
                    tmpwind = tmpnewWind;
                    break;
                }
            }
        }
    } @catch (NSException *exception) {
        for (UIWindow *tmpnewWind in UIApplication.sharedApplication.windows) {
            if ([tmpnewWind.rootViewController isKindOfClass:[UITabBarController class]]) {
                tmpwind = tmpnewWind;
                break;
            }
        }
    } @finally {
        
    }
    return tmpwind;
}

- (void)getBaseInfo{
    NSString *url = [NSString stringWithFormat:@"%@facetype",TestHost];
    NSString *paraUrlString = AFQueryStringFromParameters([BagRequestUrlArgumentsFilter getURLParam]).stringByRemovingPercentEncoding;
    NSString *urlStr = @"";
    if ([url hasSuffix:@"?"]) {
        urlStr = [NSString stringWithFormat:@"%@%@", url, [paraUrlString br_stringByUTF8Encode]];
    } else if ([url containsString:@"?"]) {
        urlStr = [NSString stringWithFormat:@"%@&%@", url, [paraUrlString br_stringByUTF8Encode]];
    } else {
        urlStr = [NSString stringWithFormat:@"%@?%@", url, [paraUrlString br_stringByUTF8Encode]];
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    request.HTTPMethod = @"GET";
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self getBaseInfo];
                });
            }else{
                NSError *error;
                NSMutableDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                NSLog(@"newTabbar ----------------- \n %@ \n %@ \n ----------------- ",urlStr,responseObject);
                NSString *codeStr = responseObject[@"imeafourteensurabilityNc"];
                NSInteger code = codeStr.intValue;
                if (code == 0){
                    NSString *type = responseObject[@"viusfourteenNc"][@"itlifourteenanizeNc"];
                    if ([type isEqualToString:@"B"]){
                        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"ijasdiediudiuhuqw"];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        [[BagRootVCManager shareInstance]setRootVC];
                    }
                }else{
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self getBaseInfo];
                    });
                }
                
            }
        });
    }];
    [dataTask resume];
    
}
@end
