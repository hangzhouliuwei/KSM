//
//  PTLoginGetSMSCodeService.h
//  PTApp
//
//  Created by 刘巍 on 2024/7/31.
//

#import "PTBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTLoginGetSMSCodeService : PTBaseRequest
- (instancetype)initWithPhoneNumber:(NSString *)phoneNumber;
@end

NS_ASSUME_NONNULL_END
