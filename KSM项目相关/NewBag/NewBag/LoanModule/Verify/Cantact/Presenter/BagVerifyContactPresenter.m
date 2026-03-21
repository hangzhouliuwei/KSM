//
//  BagVerifyContactPresenter.m
//  NewBag
//
//  Created by Jacky on 2024/4/8.
//

#import "BagVerifyContactPresenter.h"
#import "BagVerifyGetContactService.h"
#import "BagVerifySaveContactService.h"
#import "BagVerifyContactModel.h"
#import "BagHomePushService.h"
@implementation BagVerifyContactPresenter
- (void)sendGetContactRequestWithProductId:(NSString *)product_id
{
    BagVerifyGetContactService *service = [[BagVerifyGetContactService alloc] initWithProductId:product_id];
    [service startWithCompletionBlockWithSuccess:^(__kindof BagBaseRequest * _Nonnull request) {
        if (request.response_code == 0) {
            BagVerifyContactModel *model = [BagVerifyContactModel yy_modelWithDictionary:request.response_dic];
            NSLog(@"");
            [self.delegate updateUIWithModel:model];
        }else{
            [self.delegate showToast:request.response_message duration:1.5];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
- (void)sendSaveContactRequestWithDic:(NSDictionary *)dic product_id:(NSString *)product_id
{
    BagVerifySaveContactService *service = [[BagVerifySaveContactService alloc] initWithDic:dic];
    [service startWithCompletionBlockWithSuccess:^(__kindof BagBaseRequest * _Nonnull request) {
        if (request.response_code == 0) {
            [self.delegate saveContactSucceed];
            if(BagUserManager.shareInstance.is_aduit){
                [self.delegate removeViewController];
                return;
            }
            NSString *nextStr = [NSString stringWithFormat:@"%@",request.response_dic[@"deecfourteentibleNc"][@"relofourteenomNc"]];
            if(![nextStr br_isBlankString]){
                [self.delegate jumpNextPageWithProductId:product_id nextUrl:nextStr];
                return;
            }
            [self sendOrderPushRequestWithOrderId:BagUserManager.shareInstance.order_numer];
        }else
        {
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
