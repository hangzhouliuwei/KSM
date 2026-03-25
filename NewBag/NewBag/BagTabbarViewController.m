//
//  BagTabbarViewController.m
//  NewBag
//
//  Created by Jacky on 2024/3/14.
//

#import "BagTabbarViewController.h"
#import "BagHomeViewController.h"
#import "BagMeViewController.h"
@interface BagTabbarViewController ()

@end

@implementation BagTabbarViewController

- (void)didInitialize
{
    [super didInitialize];
    BagHomeViewController *home = [BagHomeViewController new];
    home.tabBarItem.image = [[UIImage imageNamed:@"tab_home_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    home.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_home_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    BagNavigationViewController *homeNav = [[BagNavigationViewController alloc] initWithRootViewController:home];
    
    BagMeViewController *me = [BagMeViewController new];
    me.tabBarItem.image = [[UIImage imageNamed:@"tab_me_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    me.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_me_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    BagNavigationViewController *meNav = [[BagNavigationViewController alloc] initWithRootViewController:me];
    
    self.viewControllers = @[homeNav,meNav];
    self.tabBar.tintColor =[UIColor qmui_colorWithHexString:@"#154685"];
    [[UITabBar appearance] setBackgroundColor:[UIColor qmui_colorWithHexString:@"#ffffff"]];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
