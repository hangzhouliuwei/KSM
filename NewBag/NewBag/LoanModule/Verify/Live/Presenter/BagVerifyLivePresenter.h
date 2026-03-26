//
//  BagVerifyLivePresenter.h
//  NewBag
//
//  Created by Jacky on 2024/4/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol BagVerifyLiveProtocol <BagBaseProtocol>
@optional
- (void)updateUIWithModel:(id)model;
- (void)removeViewController;
- (void)jumpNextPageWithProductId:(NSString *)product_id nextUrl:(NSString *)url;
- (void)updateRelation_id:(NSString *)relation_id;
- (void)startLivenWithLicense:(NSString*)license;
@end

@interface BagVerifyLivePresenter : NSObject

@property (nonatomic, weak) id<BagVerifyLiveProtocol>delegate;

/**活体初始化**/
- (void)sendGetLiveRequestWithProductId:(NSString *)product_id;
/**活体限制**/
- (void)sendLiveLimitRequestWithProductId:(NSString *)product_id;
/**活体授权接口**/
- (void)sendLiveAuthRequest;
/**活体认证上传接口(advance ai)**/
- (void)sendLiveLDetctionRequestWithProductId:(NSString *)product_id liveness_id:(NSString *)liveness_id; 
/**保存活体**/
- (void)sendSaveLiveRequestWithDic:(NSDictionary *)dic productId:(NSString *)product_id;
/**Advance Ai活体识别错误上报*/
- (void)sendUploadLiveErrorRequestWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
