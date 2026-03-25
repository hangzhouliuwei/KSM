//
//  PTTabBarViewController.m
//  PTApp
//
//  Created by 刘巍 on 2024/7/16.
//

#import "PTTabBarViewController.h"
#import "PTHomeController.h"
#import "PTMineController.h"

@interface PTTabBarViewController ()

@end

@implementation PTTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createSubViews];
}

-(void)createSubViews
{
   
    [self.tabBar showRadius:24.f];
    self.tabBar.layer.borderWidth = 0.5f;
    self.tabBar.layer.borderColor = PTUIColorFromHex(0xDDDDDD).CGColor;
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    
    PTHomeController *homeVC = [[PTHomeController alloc] init];
    PTMineController *mineVC = [[PTMineController alloc] init];
    self.viewControllers = @[homeVC,mineVC];
    NSArray *icons = @[@"PT_tab_home",@"PT_tab_mine"];
    NSArray *selecticons = @[@"PT_tabselect_home",@"PT_tabselect_mine"];
    
    for (int i = 0; i <selecticons.count; i ++) {
        UITabBarItem *item = self.tabBar.items[i];
        UIImage *image = [[UIImage imageNamed:icons[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *imageSelect = [[UIImage imageNamed:selecticons[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item = [item initWithTitle:@""
                             image:image
                     selectedImage:imageSelect];
    }
    
}


@end
