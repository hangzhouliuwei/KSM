//
//  AppDelegate.m
//  PTApp
//
//  Created by 刘巍 on 2024/7/12.
//

#import "AppDelegate.h"
#import "PTNavigationController.h"
#import <YTKNetwork/YTKNetworkConfig.h>
#import "PTRequestUrlArgumentsFilter.h"
#import "PTLanuchManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{
    [PTLanuch startUpAppSDK];
    [PTLanuch startNetWork];
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [PTVCRouter rootVC];
    [self.window makeKeyAndVisible];
    [PTLanuch checkLogin];
    return YES;
}


- (BOOL)application:(UIApplication *)application continueUserActivity:(nonnull NSUserActivity *)userActivity restorationHandler:(nonnull void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler{
    if ([userActivity.activityType isEqualToString:NSUserActivityTypeBrowsingWeb]) {
        NSURL *webpageURL = userActivity.webpageURL;
        NSString *host = webpageURL.host;
        if ([host isEqualToString:@"www.next-horizon-lendinginc.com"] && PTUser.isLogin) {
            NSDictionary *dic = [PTTools urlParameFromURL:webpageURL];
            if(dic){
                [PTVCRouter switchTabAtIndex:0];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"jumpApp" object:dic];
                //self.cyl_tabBarController.selectedIndex = 0;
                //[[MCApplyOrderManager shared] applyProductHandle:[NSString  stringWithFormat:@"%@",dic[@"p"]]];
            }
        }
    }

    return YES;
}


@end
