//
//  PTOrderAPI.h
//  PTApp
//
//  Created by Jacky on 2024/8/28.
//

#import "PTBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTOrderAPI : PTBaseRequest
- (instancetype)initWithNumber:(NSInteger)status page:(NSInteger)page pageSize:(NSInteger)pageSize;
@end

NS_ASSUME_NONNULL_END
