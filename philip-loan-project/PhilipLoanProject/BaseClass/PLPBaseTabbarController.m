//
//  BaseTabbarController.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/25.
//

#import "PLPBaseTabbarController.h"
#import "PLPBaseNavigationController.h"
@interface PLPBaseTabbarController ()

@end

@implementation PLPBaseTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadChildViewControler];
//    <#NSString *info#>)
}

-(void)loadChildViewControler
{
    NSMutableArray *childArray = [NSMutableArray array];
    NSArray *titles = @[@"Loan",@"Order",@"Mine"];
    NSArray *classes = @[@"PLPLoanViewController",@"PLPOrderListViewController",@"PLPMineViewController"];
    for (int i = 0; i < titles.count; i++) {
        PLPBaseNavigationController *navC = [[PLPBaseNavigationController alloc] initWithRootViewController:[NSClassFromString(classes[i]) new]];
        NSString *selectedImageName = [NSString stringWithFormat:@"tabbar_%d_selected",i];
        NSString *normalImageName = [NSString stringWithFormat:@"tabbar_%d_normal",i];
        navC.tabBarItem.selectedImage = [kImageName(selectedImageName) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        navC.tabBarItem.image = [kImageName(normalImageName) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        navC.tabBarItem.title = titles[i];
//        navC.tabBarItem.title
        navC.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:kWhiteColor};
        [childArray addObject:navC];
    }
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:kHexColor(0xACACBC)} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:kBlueColor_0053FF} forState:UIControlStateSelected];
    self.tabBar.barTintColor = kWhiteColor;
    self.viewControllers = childArray;
//    self.tabBar.translucent = false;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 0.5)];
    lineView.backgroundColor = kGrayColor_C9C9C9;
    [self.tabBar addSubview:lineView];
    
    if (@available(iOS 15.0, *)) {
        UITabBarAppearance *appearance = [UITabBarAppearance new];
        [appearance configureWithTransparentBackground];
        self.tabBar.standardAppearance= appearance;
        self.tabBar.scrollEdgeAppearance = appearance;
    }
//    self.selectedIndex = 1;
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
