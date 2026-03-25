//
//  PTLivePresenter.h
//  PTApp
//
//  Created by Jacky on 2024/8/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PTLiveProtocol <PTBaseProtocol>

- (void)updateRelation_id:(NSString *)relation_id;
- (void)startLivenWithLicense:(NSString*)license;
@end
@interface PTLivePresenter : NSObject
@property (nonatomic, weak)id<PTLiveProtocol>delegate;
/**活体初始化**/
- (void)pt_sendGetLiveRequestWithProductId:(NSString *)product_id;
/**活体限制**/
- (void)pt_sendLiveLimitRequestWithProductId:(NSString *)product_id;
/**活体授权接口**/
- (void)pt_sendLiveAuthRequest:(NSString *)product_id;;
/**活体认证上传接口(advance ai)**/
- (void)pt_sendLiveLDetctionRequestWithProductId:(NSString *)product_id liveness_id:(NSString *)liveness_id;
/**保存活体**/
- (void)pt_sendSaveLiveRequestWithDic:(NSDictionary *)dic productId:(NSString *)product_id;
/**Advance Ai活体识别错误上报*/
- (void)pt_sendUploadLiveErrorRequestWithError:(NSString *)error;
@end

NS_ASSUME_NONNULL_END
