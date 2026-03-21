//
//  BagHomeApplyService.h
//  NewBag
//
//  Created by Jacky on 2024/3/27.
//

#import "BagBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface BagHomeApplyService : BagBaseRequest
- (instancetype)initWithProductId:(NSString *)product_id;
@end

NS_ASSUME_NONNULL_END
