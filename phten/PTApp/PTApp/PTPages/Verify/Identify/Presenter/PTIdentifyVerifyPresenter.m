//
//  PTIdentifyVerifyPresenter.m
//  PTApp
//
//  Created by Jacky on 2024/8/24.
//

#import "PTIdentifyVerifyPresenter.h"
#import "PTGetIdentifyService.h"
#import "PTUploadIDImageService.h"
#import "PTSaveIdentifyService.h"
#import "PTIdentifyModel.h"
#import "PTHomeGCePushService.h"
#import "UIImage+HXExtension.h"
@implementation PTIdentifyVerifyPresenter
- (void)pt_sendGetIdentifyRequestWithProductId:(NSString *)product_id
{
    PTGetIdentifyService *api = [[PTGetIdentifyService alloc] initWithProductId:product_id];
    [api startWithCompletionBlockWithSuccess:^(__kindof PTBaseRequest * _Nonnull request) {
        if (request.response_code == 0) {
            PTIdentifyModel *model = [PTIdentifyModel yy_modelWithDictionary:request.response_dic];
            [self.delegate updateUIWithModel:model];
        }else{
            [self.delegate showToast:request.response_message duration:1.5];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
- (void)pt_uploadImageRequestWithDic:(NSDictionary *)dic image:(UIImage *)image
{
    UIImage *pressImage =[image hx_scaleToFitSize:CGSizeMake(1024, 1024)];
    
    PTUploadIDImageService *api = [[PTUploadIDImageService alloc] initWithImage:pressImage param:dic];
    [api startWithCompletionBlockWithSuccess:^(__kindof PTBaseRequest * _Nonnull request) {
        if (request.response_code == 0) {
            PTIdentifyDetailModel *model = [PTIdentifyDetailModel yy_modelWithDictionary:request.response_dic];
            model.idCardImage = pressImage;
            if ([self.delegate respondsToSelector:@selector(updateUIWithIdentifyDetailModel:)]) {
                [self.delegate updateUIWithIdentifyDetailModel:model];
            }
        }else {
            [self.delegate showToast:request.response_message duration:1.5];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
- (void)pt_sendSaveIdentifyRequestWithDic:(NSDictionary *)dic product_id:(NSString *)product_id
{
    PTSaveIdentifyService *api = [[PTSaveIdentifyService alloc] initWithDic:dic];
    [api startWithCompletionBlockWithSuccess:^(__kindof PTBaseRequest * _Nonnull request) {
        if (request.response_code == 0) {
            [self.delegate saveIdentifySucceed];
            if(PTUserManager.sharedUser.isaduit){
                [self.delegate removeViewController];
                return;
            }
            NSString *nextStr = [NSString stringWithFormat:@"%@",request.response_dic[@"detenectibleNc"][@"retenloomNc"]];
            if(![nextStr br_isBlankString]){
                [self.delegate router:[nextStr br_pinProductId:product_id]];
                return;
            }
            [self sendOrderPushRequestWithOrderId:PTUserManager.sharedUser.oder product_id:product_id];
        }else{
            [self.delegate showToast:request.response_message duration:1.5];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
- (void)sendOrderPushRequestWithOrderId:(NSString *)order_id product_id:(NSString *)product_id
{
    PTHomeGCePushService *api = [[PTHomeGCePushService alloc] initWithOrderId:order_id];
    [api startWithCompletionBlockWithSuccess:^(__kindof PTBaseRequest * _Nonnull request) {
        if (request.response_code == 0) {
            NSDictionary *dic = request.responseObject;
            NSString *url = dic[@"vitenusNc"][@"retenloomNc"];
            if (self.delegate && [self.delegate respondsToSelector:@selector(router:)]) {
                [self.delegate router:[url br_pinProductId:product_id]];
            }
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
- (void)pt_sendUploadDeviceRequest
{
    [[PTUploadDeviceInfoManager sharedManager] uploadDeviceInfo];
}
@end
