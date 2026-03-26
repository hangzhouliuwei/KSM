//
//  UIViewController+Category.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/9/3.
//

#import "UIViewController+Category.h"

@implementation UIViewController (Category)
+ (UIViewController *)getCurrentViewController {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self findTopViewController:rootViewController];
}

+ (UIViewController *)findTopViewController:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        // 如果是导航控制器，返回最后一个视图控制器
        UINavigationController *navigationController = (UINavigationController *)viewController;
        return [self findTopViewController:navigationController.visibleViewController];
    } else if ([viewController isKindOfClass:[UITabBarController class]]) {
        // 如果是标签栏控制器，返回选中的视图控制器
        UITabBarController *tabBarController = (UITabBarController *)viewController;
        return [self findTopViewController:tabBarController.selectedViewController];
    } 
    else if (viewController.presentedViewController) {
        // 如果有模态弹出控制器，返回模态控制器
        return [self findTopViewController:viewController.presentedViewController];
    } 
    else {
        // 否则返回当前控制器
        return viewController;
    }
}
@end
