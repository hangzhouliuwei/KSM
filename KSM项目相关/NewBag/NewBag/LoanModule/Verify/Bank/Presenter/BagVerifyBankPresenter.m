//
//  BagVerifyBankPresenter.m
//  NewBag
//
//  Created by Jacky on 2024/4/8.
//

#import "BagVerifyBankPresenter.h"
#import "BagVerifyGetBankService.h"
#import "BagVerifySaveBankService.h"
#import "BagHomePushService.h"
#import "BagBankModel.h"
@implementation BagVerifyBankPresenter
- (void)sendGetBankRequestWithProductId:(NSString *)product_id
{
    BagVerifyGetBankService *service = [[BagVerifyGetBankService alloc] initWithProductId:product_id];
    [service startWithCompletionBlockWithSuccess:^(__kindof BagBaseRequest * _Nonnull request) {
        if (request.response_code == 0) {
            BagBankModel *model = [BagBankModel yy_modelWithDictionary:request.response_dic];
            [self.delegate updateUIWithModel:model];
        }else{
            [self.delegate showToast:request.response_message duration:1.5];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
- (void)sendSaveContactRequestWithDic:(NSDictionary *)dic productId:(nonnull NSString *)product_id
{
    BagVerifySaveBankService *service = [[BagVerifySaveBankService alloc] initWithDic:dic];
    [service startWithCompletionBlockWithSuccess:^(__kindof BagBaseRequest * _Nonnull request) {
        if (request.response_code == 0) {
            [self.delegate saveBankSucceed];
            if (BagUserManager.shareInstance.is_aduit) {
                [self.delegate removeViewController];
                return;
            }
            NSString *nextStr = [NSString stringWithFormat:@"%@",request.response_dic[@"deecfourteentibleNc"][@"relofourteenomNc"]];
            if(![nextStr br_isBlankString]){
                [self.delegate jumpNextPageWithProductId:product_id nextUrl:nextStr];
                return;
            }
            [self sendOrderPushRequestWithOrderId:BagUserManager.shareInstance.order_numer];
        }else{
            [self.delegate showToast:request.response_message duration:1.5];
        }
        
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
