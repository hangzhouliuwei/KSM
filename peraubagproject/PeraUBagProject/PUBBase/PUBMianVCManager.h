//
//  PUBMianVCManager.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/21.
//

#import <Foundation/Foundation.h>
#import "PUBNavigationController.h"
#import "PUBDragView.h"

NS_ASSUME_NONNULL_BEGIN
#define  VCManager [PUBMianVCManager sharedPUBMianVCManager]
@class PUBBaseViewController;
@interface PUBMianVCManager : NSObject
SINGLETON_H(PUBMianVCManager)
@property(nonatomic, strong) PUBNavigationController *navigationController;
///全局浮窗
@property(nonatomic, strong) PUBDragView *dragView;
//配置Window
- (void)configureWithWindow:(UIWindow *)window;
//顶层ViewController
- (PUBBaseViewController *)topViewController;
//回到主页面
- (void)showRootViewController;
- (void)showRootViewControllerAnimated:(BOOL)animated;
- (void)presentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(ReturnNoneBlock)completion;
//切换tabBar
- (void)switchTabAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
