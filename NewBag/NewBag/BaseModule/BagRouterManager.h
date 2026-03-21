//
//  BagRouterManager.h
//  NewBag
//
//  Created by Jacky on 2024/3/31.
//

#import <Foundation/Foundation.h>
@class BagTabbarViewController;
NS_ASSUME_NONNULL_BEGIN

@interface BagRouterManager : NSObject

+ (instancetype)shareInstance;
- (void)routeWithUrl:(NSString*)url;
- (void)setSelectedIndex:(NSInteger)selectedIndex viewController:(UIViewController *__nullable)controller;

- (void)pushToViewController:(UIViewController *)vc;
- (void)jumpLoanWithProId:(NSString *)product_id;
- (void)jumpLogin;
- (void)jumpLoginWithSuccessBlock:(void (^)(void))block;
- (BagTabbarViewController *)rootVC;
- (BagBaseVC *)getCurrentViewController;
@end

NS_ASSUME_NONNULL_END
