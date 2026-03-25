//
//  PTVCRouterManager.h
//  PTApp
//
//  Created by 刘巍 on 2024/7/17.
//

#import <Foundation/Foundation.h>
@class PTNavigationController;
NS_ASSUME_NONNULL_BEGIN
#define  PTVCRouter [PTVCRouterManager sharedPTVCRouterManager]
@interface PTVCRouterManager : NSObject
SINGLETON_H(PTVCRouterManager)
@property(nonatomic, strong) PTNavigationController *navVC;
- (PTNavigationController*)rootVC;
///切换tabBar
- (void)switchTabAtIndex:(NSUInteger)index;

-(void)jumpLoginWithSuccessBlock:(PTBlock)block;

@end

NS_ASSUME_NONNULL_END
