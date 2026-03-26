//
//  PTAuthErrorLiveService.h
//  PTApp
//
//  Created by Jacky on 2024/8/21.
//

#import "PTBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTAuthErrorLiveService : PTBaseRequest
- (instancetype)initWithError:(NSString *)error;
@end

NS_ASSUME_NONNULL_END
