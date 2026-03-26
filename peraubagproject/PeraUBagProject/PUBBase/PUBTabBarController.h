//
//  PUBTabBarController.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/21.
//

#import "QMUITabBarViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PUBTabBarController : QMUITabBarViewController
- (void)setSelectedIndex:(NSUInteger)selectedIndex param:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
