//
//  BagHomePushService.h
//  NewBag
//
//  Created by Jacky on 2024/4/5.
//

#import "BagBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface BagHomePushService : BagBaseRequest
- (instancetype)initWithOrderId:(NSString *)product_id;
@end

NS_ASSUME_NONNULL_END
