//
//  PesoRouterCenter.h
//  PesoApp
//
//  Created by Jacky on 2024/9/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PesoRouterCenter : NSObject
singleton_interface(PesoRouterCenter)
- (void)routeWithUrl:(NSString*)url;
@end

NS_ASSUME_NONNULL_END
