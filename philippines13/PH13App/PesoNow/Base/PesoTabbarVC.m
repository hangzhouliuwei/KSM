//
//  PesoTabbarVC.m
//  PesoApp
//
//  Created by Jacky on 2024/9/10.
//

#import "PesoTabbarVC.h"
#import "PesoHomeViewController.h"
#import "PesoMeViewController.h"
#import "PesoNavigationController.h"
@interface PesoTabbarVC ()<UITabBarControllerDelegate>

@end

@implementation PesoTabbarVC
- (void)configTabbar{
    if (@available(iOS 13.0, *)) {
        UITabBarAppearance *appearance = [[UITabBarAppearance alloc] init];
        appearance.backgroundImage = [UIImage new];
        appearance.backgroundColor = [UIColor whiteColor];
        [appearance setShadowColor:nil];
        // 这句话非常重要，在不动.translucent属性前提下，设置纯背景颜色，特别是设置tabbar透明，非常重要
        appearance.backgroundEffect = nil;
        self.tabBar.standardAppearance = appearance;
        if (@available(iOS 15.0, *)) {
            // 用这个方法的，这个一定要加，否则15.0系统下会出问题，一滑动tabbar就变透明!!!
            self.tabBar.scrollEdgeAppearance = appearance;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configTabbar];
    PesoHomeViewController *home = [PesoHomeViewController new];
    PesoNavigationController *homeNav = [[PesoNavigationController alloc] initWithRootViewController:home];
    

    PesoMeViewController *me = [PesoMeViewController new];
    PesoNavigationController *meNav = [[PesoNavigationController alloc] initWithRootViewController:me];

    self.viewControllers = @[homeNav,meNav];
    self.delegate = self;
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tab_home"]];
    image.backgroundColor = [UIColor clearColor];
    image.userInteractionEnabled = NO;
    image.frame = CGRectMake(0, 0, 218, 63);
    image.center = CGPointMake(kScreenWidth/2, kTabBarHeight/2);
    image.tag = 100;
    [self.tabBar addSubview:image];
}
- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [super setSelectedIndex:selectedIndex];
    [self setImage:selectedIndex];
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSInteger index = [self.viewControllers indexOfObject:viewController];
    [self setImage:index];
    NSLog(@"===select ==%@",NSStringFromClass(viewController.class));
}
- (void)setImage:(NSInteger)index{
    UIImageView *image = [self.tabBar viewWithTag:100];
    if (index == 0) {
        image.image = [UIImage imageNamed:@"tab_home"];
    }else{
        image.image =[UIImage imageNamed:@"tab_mine"];
    }
}

@end
