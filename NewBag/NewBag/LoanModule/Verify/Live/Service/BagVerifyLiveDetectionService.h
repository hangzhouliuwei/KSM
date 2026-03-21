//
//  BagVerifyLiveDetectionService.h
//  NewBag
//
//  Created by Jacky on 2024/4/8.
//

#import "BagBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface BagVerifyLiveDetectionService : BagBaseRequest
- (instancetype)initWithProductId:(NSString *)product_id liveness_id:(NSString *)liveness_id;
@end

NS_ASSUME_NONNULL_END
