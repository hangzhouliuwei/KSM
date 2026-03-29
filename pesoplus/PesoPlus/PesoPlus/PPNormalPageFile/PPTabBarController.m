//
//  PPTabBarController.m
// FIexiLend
//
//  Created by jacky on 2024/10/31.
//

#import "PPTabBarController.h"
#import "PPLeftWindowPage.h"
#import "PPUserInfoProfilePage.h"

@interface PPTabBarController () <UITabBarControllerDelegate>

@end

@implementation PPTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    UITabBar *tabBar = self.tabBar;
    tabBar.backgroundColor = MainColor;
    tabBar.layer.cornerRadius = 30;
    tabBar.shadowImage = [[UIImage alloc] init];
    tabBar.backgroundImage = [[UIImage alloc] init];
    
    PPLeftWindowPage *main = [[PPLeftWindowPage alloc] init];
    main.naviBarHidden = YES;
    UIImage *homeIcon = [[UIImage imageNamed:@"icon_home_tab"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *homeIconSelected = [[UIImage imageNamed:@"icon_home_tabs"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *homeItem = [[UITabBarItem alloc] initWithTitle:nil image:homeIcon selectedImage:homeIconSelected];
    homeItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    main.tabBarItem = homeItem;
    
    PPUserInfoProfilePage *user = [[PPUserInfoProfilePage alloc] init];
    user.naviBarHidden = YES;
    UIImage *userIcon = [[UIImage imageNamed:@"icon_mine_tab"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *userIconSelected = [[UIImage imageNamed:@"icon_mine_tabs"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *userItem = [[UITabBarItem alloc] initWithTitle:nil image:userIcon selectedImage:userIconSelected];
    userItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    user.tabBarItem = userItem;
    
    self.viewControllers = @[main, user];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if (User.isLogin) {
        return YES;
    }else {
        NSString *str = NSStringFromClass([viewController class]);
        if ([str isEqualToString:@"PPUserInfoProfilePage"]) {
            [User login];
            return NO;
        }
        return YES;
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGFloat margin = 50.0;
    CGRect tabFrame = self.tabBar.frame;
    tabFrame.size.height = 60;
    CGFloat safeAreaHeight = self.view.safeAreaInsets.bottom + 60;
    tabFrame.origin.y = self.view.frame.size.height - safeAreaHeight;
    tabFrame.size.width = self.view.frame.size.width - (margin * 2);
    tabFrame.origin.x = margin;
    self.tabBar.frame = tabFrame;
}

@end
