//
//  BagVerifyLiveAuthErrService.h
//  NewBag
//
//  Created by Jacky on 2024/4/8.
//

#import "BagBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface BagVerifyLiveAuthErrService : BagBaseRequest
- (instancetype)initWithError:(NSString *)error;
@end

NS_ASSUME_NONNULL_END
