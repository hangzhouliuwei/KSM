//
//  AppDelegate.m
//  XTApp
//
//  Created by xia on 2024/7/11.
//

#import "AppDelegate.h"
#import "XTLoginCodeVC.h"
#import "XTRequestCenter.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [[XTDevice xt_share] xt_checkNetWork:^(BOOL have) {
        if(have) {
            
            
//            [XTDevice xt_getIdfaShowAlt:YES block:^(NSString * _Nonnull idfa) {
//                [[XTRequestCenter xt_share] xt_market:idfa];
//            }];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (@available(iOS 14, *)) {
                    [XTDevice fixTrackingAuthorizationWithCompletion:^(ATTrackingManagerAuthorizationStatus status) {
                        
                        [XTDevice xt_getIdfaShowAlt:YES block:^(NSString * _Nonnull idfa) {
                            [[XTRequestCenter xt_share] xt_market:idfa];
                        }];
                    }];
                } else {
                   
                    [XTDevice xt_getIdfaShowAlt:YES block:^(NSString * _Nonnull idfa) {
                        [[XTRequestCenter xt_share] xt_market:idfa];
                    }];
                }
            });
        }
    }];
    if([XTUserManger xt_isLogin]){
        [self xt_mainView];
    }
    else {
        [self xt_loginView];
    }
    
    [self xt_publicDisposition];
    return YES;
}

#pragma mark 公共配置
- (void)xt_publicDisposition {
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enable = YES;
    
    //全局设置tableView
    if (@available(iOS 15.0, *)) {
        [UITableView appearance].sectionHeaderTopPadding = 0;
    }
    [UITableView appearance].estimatedSectionHeaderHeight = 0;
    [UITableView appearance].estimatedSectionFooterHeight = 0;
}

- (void)xt_mainView {
    XTTabBarController *mainVC = [[XTTabBarController alloc] init];
    XTNavigationController *nv = [[XTNavigationController alloc] initWithRootViewController:mainVC];
    self.window.rootViewController = nv;
    self.xt_nv = nv;
}

- (void)xt_loginView {
    self.xt_nv = nil;
    XTLoginCodeVC *codeVC = [[XTLoginCodeVC alloc] init];
    XTNavigationController *nv = [[XTNavigationController alloc] initWithRootViewController:codeVC];
    self.window.rootViewController = nv;
}

@end
