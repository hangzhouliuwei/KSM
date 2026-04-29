//
//  PTLoginKit.h
//  PTApp
//

#import <UIKit/UIKit.h>
#import "PTAPIHeader.h"

NS_ASSUME_NONNULL_BEGIN

@class PTNavigationController;

@interface PTLoginKit : NSObject

+ (PTNavigationController *)loginNavigationControllerWithSuccessBlock:(nullable PTBlock)successBlock;
+ (void)presentLoginFromViewController:(UIViewController *)viewController success:(nullable PTBlock)successBlock;

@end

NS_ASSUME_NONNULL_END
