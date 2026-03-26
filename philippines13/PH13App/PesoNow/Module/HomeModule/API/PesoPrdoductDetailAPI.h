//
//  PesoDetailAPI.h
//  PesoApp
//
//  Created by Jacky on 2024/9/11.
//

#import "PesoPrdoductDetailAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface PesoPrdoductDetailAPI : PesoBaseAPI
- (instancetype)initWithProductId:(NSString *)product_id;
@end

NS_ASSUME_NONNULL_END
