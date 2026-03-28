//
//  BagVerifyIdentifyPresenter.h
//  NewBag
//
//  Created by Jacky on 2024/4/8.
//

#import <Foundation/Foundation.h>
@class BagIdentifyDetailModel;
NS_ASSUME_NONNULL_BEGIN
@protocol BagVerifyIdentifyProtocol <BagBaseProtocol>
@optional
- (void)updateUIWithModel:(id)model;
- (void)updateUIWithIdentifyDetailModel:(BagIdentifyDetailModel *)model;

- (void)removeViewController;
- (void)jumpNextPageWithProductId:(NSString *)product_id nextUrl:(NSString *)url;
- (void)saveIdentifySucceed;
@end

@interface BagVerifyIdentifyPresenter : NSObject

@property (nonatomic, weak) id<BagVerifyIdentifyProtocol>delegate;

/**获取**/
- (void)sendGetIdentifyRequestWithProductId:(NSString *)product_id;
/**保存**/
- (void)sendSaveIdentifyRequestWithDic:(NSDictionary *)dic product_id:(NSString *)product_id;
/**上传图片**/
- (void)sendUploadImageRequestWithDic:(NSDictionary *)dic image:(UIImage *)image;

- (void)sendUploadDeviceRequest;
@end

NS_ASSUME_NONNULL_END
