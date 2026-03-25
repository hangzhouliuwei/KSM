//
//  PesoRootVCCenter.m
//  PesoApp
//
//  Created by Jacky on 2024/9/10.
//

#import "PesoRootVCCenter.h"
#import "PesoNavigationController.h"
#import "PesoTabbarVC.h"
#import "PesoLoginVC.h"
#import "PesoLoginCodeVC.h"
@interface PesoRootVCCenter ()
@property (nonatomic, strong) PesoTabbarVC *tab;
@property (nonatomic, strong) PesoNavigationController *nav;

@end
@implementation PesoRootVCCenter
singleton_implementation(PesoRootVCCenter)

- (UIViewController *)rootVC
{
    return self.tab;
}
- (void)checkLogin:(PHBlock)block
{
    if (PesoUserCenter.sharedPesoUserCenter.isLogin) {
        return;
    }
    UIViewController *vc = [PesoUtil findVisibleViewController];
    if ([vc isKindOfClass:[UIAlertController class]]) {
        [vc dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
    PesoLoginVC *login = [PesoLoginVC new];
    PesoNavigationController *nav = [[PesoNavigationController alloc] initWithRootViewController:login];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    if(block){
        login.loginResultBlock = block;
    }
    [self.tab presentViewController:nav animated:YES completion:^{
        
    }];
}
- (void)switchIndex:(NSInteger)index
{
    PesoNavigationController *nav =(PesoNavigationController *)[PesoUtil findVisibleViewController].navigationController;
    [self.tab setSelectedIndex:index];
    [nav popToRootViewControllerAnimated:NO];
}
- (void)pushToVC:(UIViewController *)vc{
    PesoNavigationController *nav = self.tab.viewControllers[self.tab.selectedIndex];
    [nav pushViewController:vc animated:YES];
}
- (PesoTabbarVC *)tab
{
    if (!_tab) {
        _tab = [PesoTabbarVC new];
    }
    return _tab;
}
- (PesoNavigationController *)nav
{
    if (!_nav) {
        _nav = [[PesoNavigationController alloc] initWithRootViewController:self.tab];
    }
    return _nav;
}
@end
