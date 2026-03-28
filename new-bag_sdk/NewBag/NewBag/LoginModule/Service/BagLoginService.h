//
//  BagLoginService.h
//  NewBag
//
//  Created by Jacky on 2024/3/21.
//

#import "BagBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface BagLoginService : BagBaseRequest
- (instancetype)initWithPhone:(NSString *)phone code:(NSString *)code point:(NSDictionary *)point;
@end

NS_ASSUME_NONNULL_END
