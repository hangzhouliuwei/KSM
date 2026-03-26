//
//  PUBMianVCManager.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/21.
//

#import "PUBMianVCManager.h"
#import "PUBTabBarController.h"
#import "PUBBaseViewController.h"
@interface PUBMianVCManager()<UITabBarControllerDelegate>
@property(nonatomic, strong) PUBTabBarController *tabBarController;
@end

@implementation PUBMianVCManager
SINGLETON_M(PUBMianVCManager)

- (instancetype)init
{
    self = [super init];
    if(self){
        [self certTabAndNav];
    }
    return self;
}

- (void)certTabAndNav
{
    self.tabBarController = [[PUBTabBarController alloc]init];
    self.tabBarController.delegate = self;
    self.navigationController = [[PUBNavigationController alloc] initWithRootViewController:self.tabBarController];
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)configureWithWindow:(UIWindow *)window {
    window.rootViewController = self.navigationController;
    window.backgroundColor = [UIColor whiteColor];
}


- (void)showRootViewController {
    [self showRootViewControllerAnimated:YES];
}

- (void)showRootViewControllerAnimated:(BOOL)animated {
    [self.navigationController qmui_popToViewController:self.tabBarController animated:animated completion:^{
        
    }];
}



- (PUBBaseViewController *)topViewController{
    UIViewController *topViewController = self.navigationController.topViewController;
    if ([topViewController isKindOfClass:[PUBTabBarController class]]) {
        return [self selectedTabVC];
    }
    
    if (![topViewController isKindOfClass:[PUBBaseViewController class]]) {
        return nil;
    }
    
    return (PUBBaseViewController *)topViewController;
}


- (PUBBaseViewController *)selectedTabVC{
    if (!self.tabBarController) {
        return nil;
    }
    
    UIViewController *viewController = self.tabBarController.selectedViewController;
    if (![viewController isKindOfClass:[PUBBaseViewController class]]) {
        return nil;
    }
    return (PUBBaseViewController *)viewController;
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(ReturnNoneBlock)completion {
    [self.topViewController  presentViewController:viewControllerToPresent animated:YES completion:completion];
}

- (void)switchTabAtIndex:(NSUInteger)index{
    [self switchTabAtIndex:index param:nil];
}

- (void)switchTabAtIndex:(NSUInteger)index param:(NSDictionary *)dic {
    if (self.tabBarController) {
        [self.tabBarController setSelectedIndex:index param:dic];
        [self showRootViewControllerAnimated:NO];
    }
}

@end
