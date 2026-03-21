//
//  BagUploadDeviceService.h
//  NewBag
//
//  Created by Jacky on 2024/4/5.
//

#import "BagBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface BagUploadDeviceService : BagBaseRequest
- (instancetype)initWithData:(NSDictionary *)data;
@end

NS_ASSUME_NONNULL_END
