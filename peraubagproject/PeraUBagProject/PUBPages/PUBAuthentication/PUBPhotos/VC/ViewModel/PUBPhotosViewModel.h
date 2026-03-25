//
//  PUBPhotosViewModel.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/5.
//

#import "PUBBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN
@class PUBPhotosModel,PUBPhotosDesideratumEgModel;
@interface PUBPhotosViewModel : PUBBaseViewModel

///上传证件照片初始化
- (void)getPhotosView:(UIView *)view dic:(NSDictionary *)dic
                finish:(void (^)(PUBPhotosModel *photosModel))successBlock
              failture:(void (^)(void))failtureBlock;

///上传证件
- (void)uploadOcrImageView:(UIView *)view
                       dic:(NSDictionary *)dic
                  imageTmp:(UIImage*)imageTmp
                    finish:(void (^)(PUBPhotosDesideratumEgModel *photosModel))successBlock
                  failture:(void (^)(void))failtureBlock;

///点击next保存该认证项信息（第三项）
- (void)getSaveIdPhotoView:(UIView *)view dic:(NSDictionary *)dic
                finish:(void (^)(NSDictionary *dic))successBlock
              failture:(void (^)(void))failtureBlock;
@end

NS_ASSUME_NONNULL_END
