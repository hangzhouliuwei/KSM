//
//  PesoRootVCCenter.h
//  PesoApp
//
//  Created by Jacky on 2024/9/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PesoRootVCCenter : NSObject
singleton_interface(PesoRootVCCenter)

- (UIViewController *)rootVC;
- (void)checkLogin:(PHBlock)block;
- (void)switchIndex:(NSInteger)index;
- (void)pushToVC:(UIViewController *)vc;
@end

NS_ASSUME_NONNULL_END
