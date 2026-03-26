//
//  XTNavigationController.h
//  XTApp
//
//  Created by xia on 2024/7/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTNavigationController : UINavigationController<UINavigationControllerDelegate, UIGestureRecognizerDelegate>
@property(nonatomic,weak) UIViewController *xt_currentVC;

@end

NS_ASSUME_NONNULL_END
