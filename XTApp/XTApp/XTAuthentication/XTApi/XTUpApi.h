//
//  XTUpApi.h
//  XTApp
//
//  Created by xia on 2024/7/11.
//

#import "XTBaseApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface XTUpApi : XTBaseApi

- (instancetype)initPath:(NSString *)path typeId:(NSString *)typeId;

@end

NS_ASSUME_NONNULL_END
