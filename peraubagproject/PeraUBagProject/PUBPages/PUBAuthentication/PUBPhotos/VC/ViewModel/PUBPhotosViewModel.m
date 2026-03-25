//
//  PUBPhotosViewModel.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/5.
//

#import "PUBPhotosViewModel.h"
#import "PUBPhotosModel.h"
@implementation PUBPhotosViewModel

- (void)getPhotosView:(UIView *)view dic:(NSDictionary *)dic finish:(void (^)(PUBPhotosModel *photosModel))successBlock failture:(void (^)(void))failtureBlock
{
    
    [HttPPUBRequest postWithPath:certifyPhotos params:dic success:^(NSDictionary * _Nonnull responseDataDic, PUBBaseResponseModel * _Nonnull mode) {
        if(!mode.success){
            [PUBTools showToast:mode.desc];
            return;
        }
        PUBPhotosModel *photosModel = [PUBPhotosModel yy_modelWithDictionary:mode.dataDic];
        if(successBlock){
            successBlock(photosModel);
        }
        
    } failure:^(NSError * _Nonnull error) {
        
        if(failtureBlock){
            failtureBlock();
        }
    } showLoading:YES];
}


///上传证件
- (void)uploadOcrImageView:(UIView *)view dic:(NSDictionary *)dic imageTmp:(UIImage*)imageTmp finish:(void (^)(PUBPhotosDesideratumEgModel *photosModel))successBlock failture:(void (^)(void))failtureBlock
{
    UIImage *imageT = [PUBTools scaleBiteImage:imageTmp toKBite:200];
    [HttPPUBRequest uploadImageWithPath:uploadOcrImage params:dic thumbName:@"am" image:imageT success:^(NSDictionary * _Nonnull responseDataDic, PUBBaseResponseModel * _Nonnull model) {
        if(!model.success){
            [PUBTools showToast:model.desc];
            return;
        }
        PUBPhotosDesideratumEgModel *photosModel = [PUBPhotosDesideratumEgModel yy_modelWithDictionary:model.dataDic];
        photosModel.idCardImage = imageTmp;
        if(successBlock){
            successBlock(photosModel);
        }
        
    } failure:^(NSError * _Nonnull error) {
        if(failtureBlock){
            failtureBlock();
        }
        
    } progress:^(CGFloat progress) {
        
    }];
    
}

- (void)getSaveIdPhotoView:(UIView *)view dic:(NSDictionary *)dic finish:(void (^)(NSDictionary *dic))successBlock failture:(void (^)(void))failtureBlock
{
    [HttPPUBRequest postWithPath:saveIdPhoto params:dic success:^(NSDictionary * _Nonnull responseDataDic, PUBBaseResponseModel * _Nonnull mode) {
        if(!mode.success){
            [PUBTools showToast:mode.desc];
            return;
        }
        if(successBlock){
            successBlock(mode.dataDic);
        }
    } failure:^(NSError * _Nonnull error) {
        
        if(failtureBlock){
            failtureBlock();
        }
    } showLoading:YES];
}

@end
