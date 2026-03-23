//
//  PTUploadIDImageService.h
//  PTApp
//
//  Created by Jacky on 2024/8/21.
//

#import "PTBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTUploadIDImageService : PTBaseRequest
- (id)initWithImage:(UIImage *)image param:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
