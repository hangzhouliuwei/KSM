//
//  BagOrderService.h
//  NewBag
//
//  Created by Jacky on 2024/4/1.
//

#import "BagBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface BagOrderService : BagBaseRequest
- (instancetype)initWithState:(NSInteger)status page:(NSInteger)page pageSize:(NSInteger)pageSize;
@end

NS_ASSUME_NONNULL_END
