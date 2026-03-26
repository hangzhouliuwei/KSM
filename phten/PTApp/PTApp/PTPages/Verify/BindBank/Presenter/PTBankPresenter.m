//
//  PTBankPresenter.m
//  PTApp
//
//  Created by Jacky on 2024/8/26.
//

#import "PTBankPresenter.h"
#import "PTGetBankService.h"
#import "PTSaveBankService.h"
#import "PTBankModel.h"
#import "PTHomeGCePushService.h"
@implementation PTBankPresenter
- (void)pt_sendGetBankRequest:(NSString *)product_id
{
    PTGetBankService *service = [[PTGetBankService alloc] initWithProductId:product_id];
    [service startWithCompletionBlockWithSuccess:^(__kindof PTBaseRequest * _Nonnull request) {
        if (request.response_code == 0) {
            PTBankModel *model = [PTBankModel yy_modelWithDictionary:request.response_dic];
            [self.delegate updateUIWithModel:model];
        }else{
            [self.delegate showToast:request.response_message duration:1.5];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
- (void)pt_sendSaveBankInfoRequest:(NSDictionary *)dic productId:(NSString *)product_id
{
    PTSaveBankService *service = [[PTSaveBankService alloc] initWithDic:dic];
    [service startWithCompletionBlockWithSuccess:^(__kindof PTBaseRequest * _Nonnull request) {
        if (request.response_code == 0) {
            if ([self.delegate respondsToSelector:@selector(saveBankSucceed)]) {
                [self.delegate saveBankSucceed];
            }
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
