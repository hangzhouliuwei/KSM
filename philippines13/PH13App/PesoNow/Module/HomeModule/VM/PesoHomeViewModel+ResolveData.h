//
//  PesoHomeViewModel+ResolveData.h
//  PesoApp
//
//  Created by Jacky on 2024/9/11.
//

#import "PesoHomeViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PesoHomeViewModel (ResolveData)
- (void)resolveData:(NSDictionary *)data callback:(void(^)(NSArray *))callback;
@end

NS_ASSUME_NONNULL_END
