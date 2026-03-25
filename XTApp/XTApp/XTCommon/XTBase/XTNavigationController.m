//
//  XTNavigationController.m
//  XTApp
//
//  Created by xia on 2024/7/11.
//

#import "XTNavigationController.h"

@interface XTNavigationController ()

@end

@implementation XTNavigationController

- (id)initWithRootViewController:(UIViewController *)rootViewController{
    XTNavigationController *nv = [super initWithRootViewController:rootViewController];
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = self;
    }
    nv.delegate = self;
    return nv;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBarHidden = YES;
}
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (navigationController.viewControllers.count == 1)
        self.xt_currentVC = Nil;
    else
        self.xt_currentVC = viewController;
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        NSString *class = NSStringFromClass(self.visibleViewController.class);
        if([class isEqualToString:@"XTVerifyBaseVC"] ||
           [class isEqualToString:@"XTVerifyContactVC"] ||
           [class isEqualToString:@"XTOCRVC"] ||
//           [class isEqualToString:@"XTVerifyFaceVC"] ||
           [class isEqualToString:@"XTVerifyBankVC"] ||
           [class isEqualToString:@"XTHtmlVC"]){
            XTBaseVC *vc = (XTBaseVC *)self.visibleViewController;
            if([vc isKindOfClass:[XTBaseVC class]]) {
                [vc xt_back];
            }
            return NO;
        }
//        if([class isEqualToString:@"XTHtmlVC"]){
//            return NO;
//        }
        return (self.xt_currentVC == self.topViewController);
    }
    return YES;
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
