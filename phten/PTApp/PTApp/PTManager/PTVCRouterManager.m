//
//  PTVCRouterManager.m
//  PTApp
//
//  Created by 刘巍 on 2024/7/17.
//

#import "PTVCRouterManager.h"
#import "PTTabBarViewController.h"
#import "PTNavigationController.h"
#import "PTLoginKit.h"

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
    [PTLoginKit presentLoginFromViewController:self.navVC success:block];
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
