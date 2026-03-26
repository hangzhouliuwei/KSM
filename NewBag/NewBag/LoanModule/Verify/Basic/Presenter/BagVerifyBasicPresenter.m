//
//  BagVerifyBasicPresenter.m
//  NewBag
//
//  Created by Jacky on 2024/4/6.
//

#import "BagVerifyBasicPresenter.h"
#import "BagVerifyBasicService.h"
#import "BagVerifySaveBasicService.h"
#import "BagVerifyBasicModel.h"
#import "BagHomePushService.h"
@interface BagVerifyBasicPresenter()

@end
@implementation BagVerifyBasicPresenter
- (void)sendGetBasicRequestWithProduct_id:(NSString *)product_id
{
    BagVerifyBasicService *service = [[BagVerifyBasicService alloc] initWithProductId:product_id];
    [service startWithCompletionBlockWithSuccess:^(__kindof BagBaseRequest * _Nonnull request) {
        if (request.response_code == 0) {
            BagVerifyBasicModel *model = [BagVerifyBasicModel yy_modelWithDictionary:request.response_dic];
            if (self.delegate && [self.delegate respondsToSelector:@selector(updateUIWithModel:)]) {
                [self.delegate updateUIWithModel:model];
            }
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
/**保存基础信息**/
- (void)sendSaveBasicRequest:(NSDictionary *)data product_id:(NSString *)product_id
{
    BagVerifySaveBasicService *service = [[BagVerifySaveBasicService alloc] initWithDic:data];
    [service startWithCompletionBlockWithSuccess:^(__kindof BagBaseRequest * _Nonnull request) {
        if (request.response_code == 0) {
            [self.delegate saveBasicSucceed];
            if (BagUserManager.shareInstance.is_aduit) {
                [self.delegate removeViewController];
                return;
            }
            NSString *nextStr = [NSString stringWithFormat:@"%@",request.response_dic[@"lyardF"][@"nonvoterF"]];
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
            NSString *url = dic[@"daemonF"][@"nonvoterF"];
            [self.delegate jumpNextPageWithProductId:@"" nextUrl:url];
            [self.delegate removeViewController];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

@end
