//
//  XTDetectionApi.h
//  XTApp
//
//  Created by xia on 2024/9/11.
//

#import "XTBaseApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface XTDetectionApi : XTBaseApi

- (instancetype)initWithProductId:(NSString *)productId
                       livenessId:(NSString *)livenessId;

@end

NS_ASSUME_NONNULL_END
