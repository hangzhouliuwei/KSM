//
//  PTVCRouterManager.m
//  PTApp
//
//  Created by 刘巍 on 2024/7/17.
//

#import "PTVCRouterManager.h"
#import "PTTabBarViewController.h"
#import "PTNavigationController.h"
#import "PTLoginController.h"

@interface PTVCRouterManager()
@property(nonatomic, strong) PTTabBarViewController *tabBarVC;
@end

@implementation PTVCRouterManager
SINGLETON_M(PTVCRouterManager)


- (PTNavigationController*)rootVC
{
    return self.navVC;
}


///切换tabBar
- (void)switchTabAtIndex:(NSUInteger)index
{
    if (self.tabBarVC) {
        [self.tabBarVC setSelectedIndex:index];
        [self showRootViewControllerAnimated:NO];
    }
}


- (void)showRootViewControllerAnimated:(BOOL)animated 
{
    [self.navVC qmui_popToViewController:self.tabBarVC animated:animated completion:nil];
}


-(void)jumpLoginWithSuccessBlock:(PTBlock)block
{
    PTLoginController *loginVC = [[PTLoginController alloc] init];
    PTNavigationController *nav = [[PTNavigationController alloc] initWithRootViewController:loginVC];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    if(block){
        loginVC.loginResultBlock = block;
    }
    [self.navVC presentViewController:nav animated:YES completion:nil];
}



#pragma mark - lazy

-(PTTabBarViewController *)tabBarVC{
    if(!_tabBarVC){
        _tabBarVC = [[PTTabBarViewController alloc] init];
    }
    
    return _tabBarVC;
}

- (PTNavigationController *)navVC{
    if(!_navVC){
        _navVC = [[PTNavigationController alloc] initWithRootViewController:self.tabBarVC];
    }
    
    return _navVC;
}

@end
