//
//  AppDelegate.h
// FIexiLend
//
//  Created by jacky on 2024/10/31.
//

#import <UIKit/UIKit.h>
#import "PPTabBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navController;
@property (strong, nonatomic) PPTabBarController *tabBarController;

@end

