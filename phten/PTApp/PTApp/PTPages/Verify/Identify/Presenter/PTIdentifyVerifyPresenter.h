//
//  PTIdentifyVerifyPresenter.h
//  PTApp
//
//  Created by Jacky on 2024/8/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class PTIdentifyDetailModel;
@protocol PTIdentifyVerifyProtocol <PTBaseProtocol>
- (void)updateUIWithIdentifyDetailModel:(PTIdentifyDetailModel *)model;
- (void)saveIdentifySucceed;

@end
@interface PTIdentifyVerifyPresenter : NSObject
@property (nonatomic, weak) id<PTIdentifyVerifyProtocol>delegate;
/**获取**/
- (void)pt_sendGetIdentifyRequestWithProductId:(NSString *)product_id;
/**保存**/
- (void)pt_sendSaveIdentifyRequestWithDic:(NSDictionary *)dic product_id:(NSString *)product_id;
/**上传图片**/
- (void)pt_uploadImageRequestWithDic:(NSDictionary *)dic image:(UIImage *)image;

- (void)pt_sendUploadDeviceRequest;
@end

NS_ASSUME_NONNULL_END
