//
//  PTLoginKit.m
//  PTApp
//

#import "PTLoginKit.h"
#import "PTLoginController.h"
#import "PTNavigationController.h"

@implementation PTLoginKit

+ (PTNavigationController *)loginNavigationControllerWithSuccessBlock:(PTBlock)successBlock
{
    PTLoginController *loginVC = [[PTLoginController alloc] init];
    loginVC.loginResultBlock = successBlock;

    PTNavigationController *nav = [[PTNavigationController alloc] initWithRootViewController:loginVC];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    return nav;
}

+ (void)presentLoginFromViewController:(UIViewController *)viewController success:(PTBlock)successBlock
{
    if (!viewController) {
        return;
    }

    PTNavigationController *nav = [self loginNavigationControllerWithSuccessBlock:successBlock];
    [viewController presentViewController:nav animated:YES completion:nil];
}

@end
