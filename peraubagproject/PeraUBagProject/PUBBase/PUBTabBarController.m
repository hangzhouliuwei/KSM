//
//  PUBTabBarController.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/21.
//

#import "PUBTabBarController.h"
#import "PUBLoanViewController.h"
#import "PUBOrderViewController.h"
#import "PUBMineViewController.h"
#import "PUBNavigationController.h"

@interface PUBTabBarController ()

@end

@implementation PUBTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self cretUI];
}

- (void)cretUI
{
    PUBLoanViewController *loanVC = [[PUBLoanViewController alloc] init];
    PUBOrderViewController *orderVC = [[PUBOrderViewController alloc] init];
    PUBMineViewController *mineVC = [[PUBMineViewController alloc] init];
    
    NSArray *titleArray = @[@"Loan",@"Order",@"Mine"];
    NSArray *icons = @[@"pub_tab_home",@"pub_tab_order",@"pub_tab_mine"];
    NSArray *selecticons = @[@"pub_tabselect_home",@"pub_tabselect_order",@"pub_tabselect_mine"];
    self.viewControllers = @[loanVC,orderVC,mineVC];
    
    for (int i = 0; i < titleArray.count; i ++) {
        
        UITabBarItem *item = self.tabBar.items[i];
        UIImage *image = [ImageWithName(icons[i]) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *imageSelect = [ImageWithName(selecticons[i]) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        item = [item initWithTitle:titleArray[i]
                             image:image
                     selectedImage:imageSelect];
    }
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor qmui_colorWithHexString:@"#BDBDC2"]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor qmui_colorWithHexString:@"#FFFFFF"]} forState:UIControlStateSelected];
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
    self.tabBar.tintColor =[UIColor qmui_colorWithHexString:@"#BDBDC2"];
    if (@available(iOS 10.0, *)) {
        self.tabBar.unselectedItemTintColor = [UIColor qmui_colorWithHexString:@"#FFFFFF"];
    }
 //   self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    [[UITabBar appearance] setBackgroundColor:[UIColor qmui_colorWithHexString:@"#252735"]];
    
    
//    CGRect frame = self.tabBar.frame;
//    frame.size.height = 100;
//    frame.origin.y = self.view.frame.size.height - frame.size.height;
//    self.tabBar.frame = frame;
//    self.tabBar.backgroundColor = [UIColor whiteColor];
//    self.tabBar.barStyle = UIBarStyleBlack;
//    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, -10, SCREEN_WIDTH, 100)];
//    view.backgroundColor = [UIColor whiteColor];
//    [[UITabBar appearance] insertSubview:view atIndex:0];
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //[HttPPUBRequest updateNetWorkStatus];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex param:(NSDictionary *)dic{
    [super setSelectedIndex:selectedIndex];
}

@end
