//
//  PesoOrderAPI.h
//  PesoApp
//
//  Created by Jacky on 2024/9/18.
//

#import "PesoBaseAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface PesoOrderAPI : PesoBaseAPI
- (instancetype)initWithNumber:(NSInteger)status page:(NSInteger)page pageSize:(NSInteger)pageSize;
@end

NS_ASSUME_NONNULL_END
