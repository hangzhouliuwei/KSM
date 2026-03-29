//
//  PPPage.h
// FIexiLend
//
//  Created by jacky on 2024/10/31.
//

#import <Foundation/Foundation.h>
#import "PPBasePageController.h"
#import "PPTabBarController.h"

#define Page    [PPPage sharedPPPage]

@interface PPPage : NSObject


SingletonH(PPPage)

- (void)popToRootTabViewController;
- (void)popToRootTabViewControllerAnimated:(BOOL)animated;
- (void)switchTab:(NSUInteger)index;
- (PPBasePageController *)popAnimated:(BOOL)animated;
- (PPBasePageController *)pop;
- (NSArray *)popGotoViewController:(UIViewController *)viewController notFoundBlock:(void(^)(void))notFoundBlock;
- (NSArray *)popGotoViewController:(UIViewController *)viewController;
- (NSArray *)popToViewName:(NSString *)pageName notFoundBlock:(void(^)(void))notFoundBlock animated:(BOOL)animated;
- (NSArray *)popToViewName:(NSString *)pageName;
- (NSArray *)popToViewName:(NSString *)pageName animated:(BOOL)animated;

- (PPBasePageController *)pushToRootTabViewController:(NSString *)pageName param:(NSDictionary *)dic animated:(BOOL)animated;

- (PPBasePageController *)pushToRootTabViewController:(NSString *)pageName;

- (PPBasePageController *)pushToRootTabViewController:(NSString *)pageName param:(NSDictionary *)dic;

- (PPBasePageController *)pushToRootTabViewController:(NSString *)pageName animated:(BOOL)animated;

- (PPBasePageController *)topWindowFirstViewController;

- (void)present:(UIViewController *)vc animated: (BOOL)flag completion:(CallBackNone)completion;
- (void)dismiss;
@end
