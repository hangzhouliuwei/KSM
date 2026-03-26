//
//  XTTabBarController.m
//  XTApp
//
//  Created by xia on 2024/7/11.
//

#import "XTTabBarController.h"

@interface XTTabBarController ()

@end

@implementation XTTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIColor *unSelectColor = XT_RGB(0xA1DEC5, 1.0f);
    UIColor *selectColor = XT_RGB(0x32B986, 1.0f);

    [[UITabBarItem appearance] setTitleTextAttributes:@{
        NSForegroundColorAttributeName:unSelectColor,
        NSFontAttributeName:XT_Font_W(10, UIFontWeightMedium)
    } forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{
        NSForegroundColorAttributeName:selectColor,
        NSFontAttributeName:XT_Font_W(10, UIFontWeightMedium)
    } forState:UIControlStateSelected];
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
    self.tabBar.tintColor = selectColor;
    if (@available(iOS 10.0, *)) {
        self.tabBar.unselectedItemTintColor = unSelectColor;
    }
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    
    self.viewControllers = @[
        [self xt_childVCWith:XT_Controller_Init(@"XTFirstVC") title:nil normalImg:@"xt_tabbar_item_first_no" selectedImg:@"xt_tabbar_item_first_yes"],
        [self xt_childVCWith:XT_Controller_Init(@"XTMyVC") title:nil normalImg:@"xt_tabbar_item_my_no" selectedImg:@"xt_tabbar_item_my_yes"],
    ];
}
- (UIViewController *)xt_childVCWith:(UIViewController *)vc
                              title:(NSString *)title
                          normalImg:(NSString *)normalImg
                        selectedImg:(NSString *)selectedImg{
    
    
    //设置标题
    vc.tabBarItem.title = title;
    //设置普通状态图片
    UIImage *nmImg = [[UIImage imageNamed:normalImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.image = nmImg;
    
    UIImage *selImg = [[UIImage imageNamed:selectedImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = selImg;
    return vc;
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
