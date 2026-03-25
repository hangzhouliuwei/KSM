//
//  PesoIdentifyViewModel.h
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PesoIdentifyViewModel : NSObject
/**获取**/
- (void)loadGetIdentifyRequestWithProductId:(NSString *)product_id callback:(void(^)(id model))callback;
/**保存**/
- (void)loadSaveIdentifyRequestWithDic:(NSDictionary *)dic product_id:(NSString *)product_id  callback:(void(^)(id model))callback;;
/**上传图片**/
- (void)loadUploadImageRequestWithDic:(NSDictionary *)dic image:(UIImage *)image  callback:(void(^)(id model))callback;;
@end

NS_ASSUME_NONNULL_END
