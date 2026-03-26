//
//  PTNavigationController.m
//  PTApp
//
//  Created by 刘巍 on 2024/7/16.
//

#import "PTNavigationController.h"

@interface PTNavigationController ()

@end

@implementation PTNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) { // 非根控制器
        // 恢复滑动返回功能 -> 分析:把系统的返回按钮覆盖 -> 1.手势失效(1.手势被清空 2.可能手势代理做了一些事情,导致手势失效)
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
