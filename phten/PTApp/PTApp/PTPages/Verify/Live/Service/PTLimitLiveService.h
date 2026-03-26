//
//  PTLimitLiveService.h
//  PTApp
//
//  Created by Jacky on 2024/8/21.
//

#import "PTBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTLimitLiveService : PTBaseRequest
- (instancetype)initWithProductId:(NSString *)product_id;

@end

NS_ASSUME_NONNULL_END
