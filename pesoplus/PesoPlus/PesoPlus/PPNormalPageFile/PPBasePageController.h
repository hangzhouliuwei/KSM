//
//  PPBasePageController.h
// FIexiLend
//
//  Created by jacky on 2024/10/31.
//

#import <UIKit/UIKit.h>
#import "PPBaseWidgetView.h"
#import "PPNavTopStausAndBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface PPBasePageController : UIViewController
@property (nonatomic, strong) PPBaseWidgetView *content;
@property (nonatomic, strong) NSDictionary *paramDic;
@property (nonatomic, assign) BOOL naviBarHidden;
@property (nonatomic, assign) BOOL canGestureBack;
@property (nonatomic, strong) PPNavTopStausAndBar *navBar;

- (void)backAction;
@end

NS_ASSUME_NONNULL_END
