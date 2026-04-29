//
//  PTNetworkConfig.m
//  PTApp
//
//  Created by Codex on 2026/4/28.
//

#import "PTNetworkConfig.h"
#import <YTKNetwork/YTKNetwork.h>
#import "PTRequestUrlArgumentsFilter.h"

@implementation PTNetworkConfig

+ (void)configureWithBaseURL:(NSString *)baseURL
{
    [YTKNetworkConfig sharedConfig].baseUrl = baseURL ?: @"";
    [self installURLFilterIfNeeded];
}

+ (void)installURLFilterIfNeeded
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        PTRequestUrlArgumentsFilter *filter = [PTRequestUrlArgumentsFilter filterWithArguments];
        [[YTKNetworkConfig sharedConfig] addUrlFilter:filter];
    });
}

+ (nullable UIWindow *)visibleWindow
{
    if (@available(iOS 13.0, *)) {
        for (UIScene *scene in UIApplication.sharedApplication.connectedScenes) {
            if (scene.activationState != UISceneActivationStateForegroundActive || ![scene isKindOfClass:UIWindowScene.class]) {
                continue;
            }

            UIWindowScene *windowScene = (UIWindowScene *)scene;
            for (UIWindow *window in windowScene.windows) {
                if (window.isKeyWindow) {
                    return window;
                }
            }
        }
    }

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    return UIApplication.sharedApplication.keyWindow;
#pragma clang diagnostic pop
}

@end
