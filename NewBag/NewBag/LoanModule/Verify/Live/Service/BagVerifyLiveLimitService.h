//
//  BagVerifyLiveLimitService.h
//  NewBag
//
//  Created by Jacky on 2024/4/8.
//

#import "BagBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface BagVerifyLiveLimitService : BagBaseRequest
- (instancetype)initWithProductId:(NSString *)product_id;
@end

NS_ASSUME_NONNULL_END
