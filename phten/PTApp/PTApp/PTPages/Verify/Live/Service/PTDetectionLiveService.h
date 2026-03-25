//
//  PTDetectionLiveService.h
//  PTApp
//
//  Created by Jacky on 2024/8/21.
//

#import "PTBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTDetectionLiveService : PTBaseRequest
- (instancetype)initWithProductId:(NSString *)product_id liveness_id:(NSString *)liveness_id;

@end

NS_ASSUME_NONNULL_END
