//
//  BagLoanPresenter.m
//  NewBag
//
//  Created by Jacky on 2024/4/5.
//

#import "BagLoanPresenter.h"
#import "BagHomeProductDetailService.h"
#import "BagLoanDeatilModel.h"
#import "BagHomePushService.h"
@implementation BagLoanPresenter
#pragma mark - 产品详情
- (void)sendGetProductDetailRequestWithProductId:(NSString *)product_id
{
    BagHomeProductDetailService *request = [[BagHomeProductDetailService alloc] initWithProductId:product_id];
    [request startWithCompletionBlockWithSuccess:^(__kindof BagBaseRequest * _Nonnull request) {
        if (request.response_code == 0) {
            NSDictionary *data = request.responseObject;
            BagLoanDeatilModel *model = [BagLoanDeatilModel yy_modelWithDictionary:data[@"daemonF"]];
            //刷新
            if (self.delegate && [self.delegate respondsToSelector:@selector(updateUIWithModel:)]) {
                [self.delegate updateUIWithModel:model];
            }
            [BagUserManager shareInstance].order_numer = model.succussiveF.indifferentismF;
        }else
        {
            [self.delegate showToast:request.response_message duration:1.5];

        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
- (void)sendOrderPushRequestWithOrderId:(NSString *)order_id product_id:(NSString *)product_id
{
    BagHomePushService *request = [[BagHomePushService alloc] initWithOrderId:order_id];
    [request startWithCompletionBlockWithSuccess:^(__kindof BagBaseRequest * _Nonnull request) {
        if (request.response_code == 0) {
            NSDictionary *dic = request.responseObject;
            NSString *url = dic[@"daemonF"][@"nonvoterF"];
            if (self.delegate && [self.delegate respondsToSelector:@selector(router:)]) {
                [self.delegate router:[url br_pinProductId:product_id]];
            }
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
@end
