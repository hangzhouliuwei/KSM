//
//  BagVerifyLivePresenter.m
//  NewBag
//
//  Created by Jacky on 2024/4/8.
//

#import "BagVerifyLivePresenter.h"
#import "BagVerifyLiveInitService.h"
#import "BagVerifyLiveLimitService.h"
#import "BagVerifyLiveAuthService.h"
#import "BagVerifyLiveDetectionService.h"
#import "BagVerifyLiveSaveService.h"
#import "BagVerifyLiveAuthErrService.h"
#import "BagHomePushService.h"
#import "BagVerifyLiveModel.h"
@implementation BagVerifyLivePresenter
- (void)sendGetLiveRequestWithProductId:(NSString *)product_id
{
    BagVerifyLiveInitService *service = [[BagVerifyLiveInitService alloc] initWithProductId:product_id];
    [service startWithCompletionBlockWithSuccess:^(__kindof BagBaseRequest * _Nonnull request) {
        if (request.response_code == 0) {
            BagVerifyLiveModel *model = [BagVerifyLiveModel yy_modelWithDictionary:request.response_dic[@"prtofourteenzoalNc"]];
            [self.delegate updateUIWithModel:model];
        }else{
            [self.delegate showToast:request.response_message duration:1.5];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
- (void)sendLiveLimitRequestWithProductId:(NSString *)product_id
{
    BagVerifyLiveLimitService *service = [[BagVerifyLiveLimitService alloc] initWithProductId:product_id];
    [service startWithCompletionBlockWithSuccess:^(__kindof BagBaseRequest * _Nonnull request) {
        if (request.response_code == 0) {
            [self sendLiveAuthRequest:product_id];
        }else{
            [self.delegate showToast:request.response_message duration:1.5];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
/**活体授权拿到 liveness_id**/
- (void)sendLiveAuthRequest:(NSString *)product_id
{
    BagVerifyLiveAuthService *service = [[BagVerifyLiveAuthService alloc] init];
    [service startWithCompletionBlockWithSuccess:^(__kindof BagBaseRequest * _Nonnull request) {
        if (request.response_code == 0) {
            NSString *license = [NSString stringWithFormat:@"%@",request.response_dic[@"tafyfourteenNc"]];
            [self.delegate startLivenWithLicense:license];
//            [self sendLiveLDetctionRequestWithProductId:product_id liveness_id:licenseId];
        }else{
            [self.delegate showToast:request.response_message duration:1.5];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
/**活体做完**/
- (void)sendLiveLDetctionRequestWithProductId:(NSString *)product_id liveness_id:(nonnull NSString *)liveness_id
{
    BagVerifyLiveDetectionService *service = [[BagVerifyLiveDetectionService alloc] initWithProductId:product_id liveness_id:liveness_id] ;
    [service startWithCompletionBlockWithSuccess:^(__kindof BagBaseRequest * _Nonnull request) {
        if (request.response_code == 0) {
            NSString *relation_id = [NSString stringWithFormat:@"%@",request.response_dic[@"paalfourteenympicsNc"]];
            [self.delegate updateRelation_id:relation_id];
        }else{
            [self.delegate showToast:request.response_message duration:1.5];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];

}
/**保存**/
- (void)sendSaveLiveRequestWithDic:(NSDictionary *)dic productId:(NSString *)product_id
{
    BagVerifyLiveSaveService *service = [[BagVerifyLiveSaveService alloc] initWithDic:dic] ;
    [service startWithCompletionBlockWithSuccess:^(__kindof BagBaseRequest * _Nonnull request) {
        if (request.response_code == 0) {
            if (BagUserManager.shareInstance.is_aduit) {
                [self.delegate removeViewController];
                return;
            }
            NSString *nextStr = [NSString stringWithFormat:@"%@",request.response_dic[@"deecfourteentibleNc"][@"relofourteenomNc"]];
            if(![nextStr br_isBlankString]){
                [self.delegate jumpNextPageWithProductId:product_id nextUrl:nextStr];
//                [self.delegate removeViewController];
                return;
            }
            [self sendOrderPushRequestWithOrderId:BagUserManager.shareInstance.order_numer];
        }else{
            [self.delegate showToast:request.response_message duration:1.5];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
- (void)sendUploadLiveErrorRequestWithDic:(NSDictionary *)dic
{
    BagVerifyLiveAuthErrService *service = [[BagVerifyLiveAuthErrService alloc] init] ;
    [service startWithCompletionBlockWithSuccess:^(__kindof BagBaseRequest * _Nonnull request) {
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
/**根据订单拿跳转地址**/
- (void)sendOrderPushRequestWithOrderId:(NSString *)order_id
{
    BagHomePushService *request = [[BagHomePushService alloc] initWithOrderId:order_id];
    [request startWithCompletionBlockWithSuccess:^(__kindof BagBaseRequest * _Nonnull request) {
        if (request.response_code == 0) {
            NSDictionary *dic = request.responseObject;
            NSString *url = dic[@"viusfourteenNc"][@"relofourteenomNc"];
            [self.delegate jumpNextPageWithProductId:@"" nextUrl:url];
            [self.delegate removeViewController];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
@end
