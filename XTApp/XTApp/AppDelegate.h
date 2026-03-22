//
//  AppDelegate.h
//  XTApp
//
//  Created by xia on 2024/7/11.
//

#import <UIKit/UIKit.h>
@class XTNavigationController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) XTNavigationController *xt_nv;

- (void)xt_mainView;
- (void)xt_loginView;

@end

