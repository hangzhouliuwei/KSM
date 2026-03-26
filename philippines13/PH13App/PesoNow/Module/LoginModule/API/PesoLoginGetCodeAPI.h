//
//  PesoLoginGetCodeAPI.h
//  PesoApp
//
//  Created by Jacky on 2024/9/10.
//

#import "PesoBaseAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface PesoLoginGetCodeAPI : PesoBaseAPI
- (instancetype)initWithPhoneNumber:(NSString *)phoneNumber;
@end

NS_ASSUME_NONNULL_END
