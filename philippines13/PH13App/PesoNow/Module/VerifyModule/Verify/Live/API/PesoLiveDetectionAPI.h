//
//  PesoLiveDetectionAPI.h
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import "PesoBaseAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface PesoLiveDetectionAPI : PesoBaseAPI
- (instancetype)initWithProductId:(NSString *)product_id liveness_id:(NSString *)liveness_id;
@end

NS_ASSUME_NONNULL_END
