//
//  PTBasicVerifyPresenter.m
//  PTApp
//
//  Created by Jacky on 2024/8/22.
//

#import "PTBasicVerifyPresenter.h"
#import "PTBasicVerifyModel.h"
#import "PTBasicVerifyService.h"
#import "PTSaveBasicVerifyService.h"
#import "PTHomeGCePushService.h"
@implementation PTBasicVerifyPresenter
- (void)pt_sendGetBasicRequestWithProduct_id:(NSString *)product_id
{
    PTBasicVerifyService *service = [[PTBasicVerifyService alloc] initWithProductId:product_id];
    [service startWithCompletionBlockWithSuccess:^(__kindof PTBaseRequest * _Nonnull request) {
        if (request.response_code == 0) {
            PTBasicVerifyModel *model = [PTBasicVerifyModel yy_modelWithDictionary:request.response_dic];
            if ([self.delegate respondsToSelector:@selector(updateUIWithModel:)]) {
                [self.delegate updateUIWithModel:model];
            }
            return;
        }
        [self.delegate showToast:request.response_message duration:2];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
- (void)pt_sendSaveBasicRequest:(NSDictionary *)data product_id:(NSString *)product_id
{
    PTSaveBasicVerifyService *api = [[PTSaveBasicVerifyService alloc] initWithDic:data];
    [api startWithCompletionBlockWithSuccess:^(__kindof PTBaseRequest * _Nonnull request) {
        if (request.response_code == 0) {
            [self.delegate saveBasicSucceed];
            if (PTUserManager.sharedUser.isaduit) {
                [self.delegate removeViewController];
                return;
            }
            NSString *nextStr = [NSString stringWithFormat:@"%@",request.response_dic[@"detenectibleNc"][@"retenloomNc"]];
            if(![nextStr br_isBlankString]){
                [self.delegate jumpNextPageWithProductId:product_id nextUrl:nextStr];
                return;
            }
            [self sendOrderPushRequestWithOrderId:[PTUserManager sharedUser].oder product_id:product_id];
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
@end
