//
//  BagRouterManager.m
//  NewBag
//
//  Created by Jacky on 2024/3/31.
//

#import "BagRouterManager.h"
#import "BagTabbarViewController.h"
#import "BagNavigationViewController.h"
#import "BagLoginViewController.h"
#import "BagLoanVC.h"
#import "BagVerifyBasicVC.h"
#import "BagVerifyContactVC.h"
#import "BagVerifyIdentifyVC.h"
#import "BagVerifyLiveVC.h"
#import "BagVerifyBankVC.h"
#import "BagMeSettingVC.h"
#import "BagOrderVC.h"
@interface BagRouterManager ()
@property (nonatomic, weak) BagTabbarViewController *tab;
@end

@implementation BagRouterManager
+ (instancetype)shareInstance{
    static BagRouterManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [BagRouterManager new];
    });
    return manager;
}
- (void)routeWithUrl:(NSString*)url; {
    if ([url containsString:@"http://"] || [url containsString:@"https://"]) {
        BagWebViewController *web = [BagWebViewController new];
        web.url = url;
        [self pushToViewController:web];
    }else if ([url containsString:@"openapp://"]) {
        NSArray *arr = @[@"config",@"main",@"login",@"orderList",@"detail",@"a1",@"a2",@"a3",@"a4",@"a5"];
        for (NSString *str in arr) {
            if([url containsString:str]){
                NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                if([url containsString:@"?"]){
                    NSArray * arr1 = [url componentsSeparatedByString:@"?"];
                    if(arr1.count > 0){
                        NSString *str1 = arr1[1];
                        NSArray * arr2 = [str1 componentsSeparatedByString:@"="];
                        if(arr2.count>0){
                            NSString *idStr = [NSString stringWithFormat:@"%@", arr2[1]];
                            [dict setValue:@([idStr integerValue]) forKey:arr2[0]];
                        }
                    }
                    SEL selector = NSSelectorFromString([NSString stringWithFormat:@"%@:", str]);
                    if ([self respondsToSelector:selector]) {
                        [self performSelector:selector withObject:dict afterDelay:0];
                    }
                }else{
                    SEL selector = NSSelectorFromString([NSString stringWithFormat:@"%@:", str]);
                    if ([self respondsToSelector:selector]) {
                        [self performSelector:selector withObject:nil afterDelay:0];
                    }
                }
            }
        }
    }
}
#pragma mark - 设置
- (void)config:(NSDictionary *)options{
    BagMeSettingVC *set = [[BagMeSettingVC alloc] init];
    [self pushToViewController:set];
}
#pragma mark - 详情
- (void)detail:(NSDictionary *)options{
    BagLoanVC *vc = [BagLoanVC new];
    vc.productId = [options[@"vachelF"] stringValue];
    [self pushToViewController:vc];
}
#pragma mark - 首页
- (void)main:(NSDictionary *)options
{
    [self setSelectedIndex:0 viewController:nil];
}

#pragma mark - 登录页
- (void)login:(NSDictionary *)options
{
    [self jumpLogin];
}

#pragma mark - 订单列表页
- (void)orderList:(NSDictionary *)options
{
    BagOrderVC *order = [[BagOrderVC alloc] init];
    NSInteger index = (NotNull([options[@"mastodontF"] stringValue])).integerValue;
    order.selectIndex = index;
    [self setSelectedIndex:1 viewController:order];
}

#pragma mark - 认证
- (void)a1:(NSDictionary *)options{
    BagVerifyBasicVC *basicVC = [[BagVerifyBasicVC alloc] init];
    basicVC.productId =  NotNull([options[@"vachelF"] stringValue]);
    [self pushToViewController:basicVC];
}
- (void)a2:(NSDictionary *)options{
    BagVerifyContactVC *contactVC = [[BagVerifyContactVC alloc] init];
    contactVC.productId =  NotNull([options[@"vachelF"] stringValue]);
    [self pushToViewController:contactVC];
}
- (void)a3:(NSDictionary *)options{
    BagVerifyIdentifyVC *vc = [BagVerifyIdentifyVC new];
    vc.productId =  NotNull([options[@"vachelF"] stringValue]);
    [self pushToViewController:vc];
}
- (void)a4:(NSDictionary *)options{
    BagVerifyLiveVC *liveVC = [[BagVerifyLiveVC alloc] init];
    liveVC.productId =  NotNull([options[@"vachelF"] stringValue]);
    [self pushToViewController:liveVC];
}
- (void)a5:(NSDictionary *)options{
    BagVerifyBankVC *liveVC = [[BagVerifyBankVC alloc] init];
    liveVC.productId =  NotNull([options[@"vachelF"] stringValue]);
    [self pushToViewController:liveVC];
}

- (void)jumpLoanWithProId:(NSString *)product_id{
    BagLoanVC *vc = [BagLoanVC new];
    vc.productId = product_id;
    [self pushToViewController:vc];
}
- (void)pushToViewController:(UIViewController *)vc{
    NSInteger index = self.tab.selectedIndex;
    if (self.tab.viewControllers.count > self.tab.selectedIndex && index >=0) {
        BagNavigationViewController *nav = self.tab.viewControllers[self.tab.selectedIndex];
        [nav pushViewController:vc animated:YES];
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex viewController:(UIViewController *__nullable)controller
{
    UIViewController *navController;
    NSInteger index = self.tab.selectedIndex;
    if (self.tab.viewControllers.count > index && index >=0) {
        navController = self.tab.viewControllers[index];
    }
    if ([navController respondsToSelector:@selector(popToRootViewControllerAnimated:)]) {
        [(BagNavigationViewController *)navController popToRootViewControllerAnimated:NO];
    }
    self.tab.selectedIndex = selectedIndex;
    if (controller) {
        [(BagNavigationViewController *)navController pushViewController:controller animated:YES];
    }
}
- (void)jumpLogin
{
    BagLoginViewController *login = [BagLoginViewController new];
    BagNavigationViewController *nav = [[BagNavigationViewController alloc] initWithRootViewController:login];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.tab presentViewController:nav animated:YES completion:^{
        
    }];
}
- (void)jumpLoginWithSuccessBlock:(void (^)(void))block{
    BagLoginViewController *login = [BagLoginViewController new];
    login.loginResultBlock = ^(NSInteger uid) {
        if (uid) {
            block();
        }
    };
    BagNavigationViewController *nav = [[BagNavigationViewController alloc] initWithRootViewController:login];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.tab presentViewController:nav animated:YES completion:^{
        
    }];
}
//获取当前显示在最前面的页面的vc
- (BagBaseVC *)getCurrentViewController
{
    NSInteger index = self.tab.selectedIndex;
    if (self.tab.viewControllers.count > index&& index >=0) {
        BagNavigationViewController *navNow = [self.tab.viewControllers objectAtIndex:self.tab.selectedIndex];
        if (navNow.viewControllers.count > 0) {
            return [navNow.viewControllers objectAtIndex:[navNow.viewControllers count] - 1];
        }
    }
    return nil;
}
- (BagTabbarViewController *)rootVC{
    BagTabbarViewController *tab = [[BagTabbarViewController alloc]init];
    [tab didInitialize];
    self.tab = tab;
    return tab;
}
@end
