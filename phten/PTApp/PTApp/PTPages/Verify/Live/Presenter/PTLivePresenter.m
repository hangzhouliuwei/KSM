//
//  PTLivePresenter.m
//  PTApp
//
//  Created by Jacky on 2024/8/25.
//

#import "PTLivePresenter.h"
#import "PTInitLiveService.h"
#import "PTLimitLiveService.h"
#import "PTAuthLiveService.h"
#import "PTDetectionLiveService.h"
#import "PTSaveLiveService.h"
#import "PTAuthErrorLiveService.h"
#import "PTLiveVerifyModel.h"
#import "PTHomeGCePushService.h"
@implementation PTLivePresenter

- (void)pt_sendGetLiveRequestWithProductId:(NSString *)product_id
{
    PTInitLiveService *service = [[PTInitLiveService alloc] initWithProductId:product_id];
    [service startWithCompletionBlockWithSuccess:^(__kindof PTBaseRequest * _Nonnull request) {
        if (request.response_code == 0) {
            PTLiveVerifyModel *model = [PTLiveVerifyModel yy_modelWithDictionary:request.response_dic[@"prtentozoalNc"]];
            [self.delegate updateUIWithModel:model];
        }else{
            [self.delegate showToast:request.response_message duration:1.5];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
//活体认证次数限制接 code不为00时，代表超过限制
- (void)pt_sendLiveLimitRequestWithProductId:(NSString *)product_id
{
    PTLimitLiveService *service = [[PTLimitLiveService alloc] initWithProductId:product_id];
    [service startWithCompletionBlockWithSuccess:^(__kindof PTBaseRequest * _Nonnull request) {
        if (request.response_code == 0) {
            [self pt_sendLiveAuthRequest:product_id];
        }else{
            [self.delegate showToast:request.response_message duration:1.5];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
//获取授权license
- (void)pt_sendLiveAuthRequest:(NSString *)product_id
{
    PTAuthLiveService *service = [[PTAuthLiveService alloc] init];
    [service startWithCompletionBlockWithSuccess:^(__kindof PTBaseRequest * _Nonnull request) {
        if (request.response_code == 0) {
            NSString *license = [NSString stringWithFormat:@"%@",request.response_dic[@"tatenfyNc"]];
            [self.delegate startLivenWithLicense:license];
        }else{
            [self.delegate showToast:request.response_message duration:1.5];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
//认证成功获取relation_id
- (void)pt_sendLiveLDetctionRequestWithProductId:(NSString *)product_id liveness_id:(NSString *)liveness_id
{
    PTDetectionLiveService *service = [[PTDetectionLiveService alloc] initWithProductId:product_id liveness_id:liveness_id] ;
    [service startWithCompletionBlockWithSuccess:^(__kindof PTBaseRequest * _Nonnull request) {
        if (request.response_code == 0) {
            NSString *relation_id = [NSString stringWithFormat:@"%@",request.response_dic[@"patenalympicsNc"]];
            [self.delegate updateRelation_id:relation_id];
        }else{
            [self.delegate showToast:request.response_message duration:1.5];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
- (void)pt_sendSaveLiveRequestWithDic:(NSDictionary *)dic productId:(NSString *)product_id
{
    PTSaveLiveService *api = [[PTSaveLiveService alloc] initWithDic:dic];
    [api startWithCompletionBlockWithSuccess:^(__kindof PTBaseRequest * _Nonnull request) {
        if (request.response_code == 0) {
            if (PTUserManager.sharedUser.isaduit) {
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
/**根据订单拿跳转地址**/
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
- (void)pt_sendUploadLiveErrorRequestWithError:(NSString *)error
{
    PTAuthErrorLiveService *api = [[PTAuthErrorLiveService alloc] initWithError:error];
    [api startWithCompletionBlockWithSuccess:^(__kindof PTBaseRequest * _Nonnull request) {
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
@end
