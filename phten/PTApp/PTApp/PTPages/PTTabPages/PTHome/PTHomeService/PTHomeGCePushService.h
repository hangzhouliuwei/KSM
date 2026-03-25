//
//  PTHomeGCePushService.h
//  PTApp
//
//  Created by Jacky on 2024/8/23.
//

#import "PTBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTHomeGCePushService : PTBaseRequest
- (instancetype)initWithOrderId:(NSString *)product_id;
@end

NS_ASSUME_NONNULL_END
