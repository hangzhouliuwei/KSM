//
//  PUBLiveViewModel.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/10.
//

#import "PUBLiveViewModel.h"
#import "PUBLiveModel.h"

@implementation PUBLiveViewModel

- (void)getCertifyLivenessView:(UIView *)view dic:(NSDictionary *)dic finish:(void (^)(PUBLiveModel *model))successBlock failture:(void (^)(void))failtureBlock
{
    
    [HttPPUBRequest postWithPath:certifyLiveness params:dic success:^(NSDictionary * _Nonnull responseDataDic, PUBBaseResponseModel * _Nonnull mode) {
        if(!mode.success){
            [PUBTools showToast:mode.desc];
            return;
        }
        PUBLiveModel *liveModel = [PUBLiveModel yy_modelWithDictionary:mode.dataDic[@"wickthing_eg"]];
        if(successBlock){
            successBlock(liveModel);
        }
    } failure:^(NSError * _Nonnull error) {
        
        if(failtureBlock){
            failtureBlock();
        }
    } showLoading:YES];
}

//活体保存（第四项）
- (void)saveLivenessView:(UIView *)view dic:(NSDictionary *)dic finish:(void (^)(NSDictionary *dic))successBlock failture:(void (^)(void))failtureBlock
{
    [HttPPUBRequest postWithPath:saveLiveness params:dic success:^(NSDictionary * _Nonnull responseDataDic, PUBBaseResponseModel * _Nonnull mode) {
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

- (void)getLivenessLimitView:(UIView *)view dic:(NSDictionary *)dic finish:(void (^)(NSDictionary *dic))successBlock failture:(void (^)(void))failtureBlock
{
    [HttPPUBRequest postWithPath:livenessLimit params:dic success:^(NSDictionary * _Nonnull responseDataDic, PUBBaseResponseModel * _Nonnull mode) {
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


- (void)getAdvanceLicenseView:(UIView *)view dic:(NSDictionary *)dic finish:(void (^)(NSDictionary *dic))successBlock
failture:(void (^)(void))failtureBlock
{
    [HttPPUBRequest getWithPath:advanceLicense params:dic success:^(NSDictionary * _Nonnull responseDataDic, PUBBaseResponseModel * _Nonnull model) {
        if(!model.success){
            [PUBTools showToast:model.desc];
            return;
        }
        if(successBlock){
            successBlock(model.dataDic);
        }
        
    } failure:^(NSError * _Nonnull error) {
        
        
    } showLoading:YES];
    
}

- (void)getlivenessDetectionView:(UIView *)view dic:(NSDictionary *)dic finish:(void (^)(NSDictionary *dic))successBlock failture:(void (^)(void))failtureBlock
{
   
    [HttPPUBRequest postWithPath:livenessDetection params:dic success:^(NSDictionary * _Nonnull responseDataDic, PUBBaseResponseModel * _Nonnull mode) {
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


- (void)getlivenessErrorView:(UIView *)view dic:(NSDictionary *)dic finish:(void (^)(void))successBlock failture:(void (^)(void))failtureBlock
{
    
    
    [HttPPUBRequest postWithPath:livenessError params:dic success:^(NSDictionary * _Nonnull responseDataDic, PUBBaseResponseModel * _Nonnull mode) {
        if(!mode.success){
            [PUBTools showToast:mode.desc];
            return;
        }
        if(successBlock){
            successBlock();
        }
    } failure:^(NSError * _Nonnull error) {
        
        if(failtureBlock){
            failtureBlock();
        }
    } showLoading:NO];
}

@end
