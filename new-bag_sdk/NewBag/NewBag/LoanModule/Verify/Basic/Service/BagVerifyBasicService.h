//
//  BagVerifyBasicService.h
//  NewBag
//
//  Created by Jacky on 2024/4/6.
//

#import "BagBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface BagVerifyBasicService : BagBaseRequest
- (instancetype)initWithProductId:(NSString *)product_id;
@end

NS_ASSUME_NONNULL_END
