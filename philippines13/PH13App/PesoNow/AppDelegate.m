//
//  AppDelegate.m
//  PesoApp
//
//  Created by Jacky on 2024/9/4.
//

#import "AppDelegate.h"
#import "PesoAppLoad.h"
#import "PesoRootVCCenter.h"
#import "PesoTabbarVC.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[PesoAppLoad sharedPesoAppLoad] initSDK];
    [[PesoAppLoad sharedPesoAppLoad] startNetworkMonitoring];
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [PesoRootVCCenter sharedPesoRootVCCenter].rootVC;
    [self.window makeKeyAndVisible];
    [[PesoRootVCCenter sharedPesoRootVCCenter] checkLogin:^{
        
    }];
    return YES;
}




@end
