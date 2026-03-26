//
//  PUBRouteManager.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PUBRouteManager : NSObject

+ (void)routeWithUrl:(NSString*)url;

+ (void)routeWitheNextPage:(NSString*)nextPage productId:(NSString*)productId;
@end

NS_ASSUME_NONNULL_END
