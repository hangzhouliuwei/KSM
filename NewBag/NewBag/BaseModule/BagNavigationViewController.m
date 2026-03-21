//
//  BagNavigationViewController.m
//  NewBag
//
//  Created by Jacky on 2024/3/25.
//

#import "BagNavigationViewController.h"

@interface BagNavigationViewController ()

@end

@implementation BagNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationBar.barTintColor = [UIColor whiteColor];
//    self.navigationBar.tintColor = [UIColor blackColor];
    // Do any additional setup after loading the view.
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) { // 非根控制器
        
        // 恢复滑动返回功能 -> 分析:把系统的返回按钮覆盖 -> 1.手势失效(1.手势被清空 2.可能手势代理做了一些事情,导致手势失效)
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 设置返回按钮,只有非根控制器
        //viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"common_back_gray"] style:(UIBarButtonItemStylePlain) target:self action:@selector(backTap)];
    }
    [super pushViewController:viewController animated:animated];
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
