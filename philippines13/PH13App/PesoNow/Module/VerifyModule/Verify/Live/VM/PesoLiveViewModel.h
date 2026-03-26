//
//  PesoLiveViewModel.h
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PesoLiveViewModel : NSObject
/**活体初始化**/
- (void)loadLiveRequestWithProductId:(NSString *)product_id callback:(void(^)(id model))callback;
/**活体限制**/
- (void)loadLiveLimitRequestWithProductId:(NSString *)product_id callback:(void(^)(id model))callback;
/**活体认证上传接口(advance ai)**/
- (void)loadLiveLDetctionRequestWithProductId:(NSString *)product_id liveness_id:(NSString *)liveness_id callback:(void(^)(id model))callback;
/**保存活体**/
- (void)loadSaveLiveRequestWithDic:(NSDictionary *)dic productId:(NSString *)product_id callback:(void(^)(id model))callback;
/**Advance Ai活体识别错误上报*/
- (void)loadUploadLiveErrorRequestWithError:(NSString *)error;
@end

NS_ASSUME_NONNULL_END
