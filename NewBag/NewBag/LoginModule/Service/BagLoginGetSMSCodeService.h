//
//  BagLoginGetSMSCodeService.h
//  NewBag
//
//  Created by Jacky on 2024/3/21.
//

#import "BagBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface BagLoginGetSMSCodeService : BagBaseRequest
- (instancetype)initWithPhone:(NSString *)phone;
@end

NS_ASSUME_NONNULL_END
