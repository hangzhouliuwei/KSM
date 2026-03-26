//
//  BagVerifyUploadIDService.h
//  NewBag
//
//  Created by Jacky on 2024/4/8.
//

#import "BagBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface BagVerifyUploadIDService : BagBaseRequest
- (id)initWithImage:(UIImage *)image param:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
