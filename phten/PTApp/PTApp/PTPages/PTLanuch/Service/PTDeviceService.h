//
//  PTDeviceService.h
//  PTApp
//
//  Created by 刘巍 on 2024/7/19.
// 设备信息上报

#import "PTBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTDeviceService : PTBaseRequest
- (instancetype)initWithData:(NSDictionary *)data;
@end

NS_ASSUME_NONNULL_END
