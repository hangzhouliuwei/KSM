//
//  PesoIdentifyUploadImgAPI.h
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import "PesoBaseAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface PesoIdentifyUploadImgAPI : PesoBaseAPI
- (id)initWithImage:(UIImage *)image param:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
