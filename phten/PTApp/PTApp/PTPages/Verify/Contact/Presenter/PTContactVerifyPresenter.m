//
//  PTContactVerifyPresenter.m
//  PTApp
//
//  Created by Jacky on 2024/8/24.
//

#import "PTContactVerifyPresenter.h"
#import "PTGetContactService.h"
#import "PTSaveContactService.h"
#import "PTHomeGCePushService.h"
#import "PTContactVerifyModel.h"
@implementation PTContactVerifyPresenter
- (void)sendGetContactRequest:(NSString *)product_id
{
    PTGetContactService *service = [[PTGetContactService alloc] initWithProductId:product_id];
    [service startWithCompletionBlockWithSuccess:^(__kindof PTBaseRequest * _Nonnull request) {
        if (request.response_code == 0) {
            PTContactVerifyModel *model = [PTContactVerifyModel yy_modelWithDictionary:request.response_dic];
            NSLog(@"");
            [self.delegate updateUIWithModel:model];
        }else{
            [self.delegate showToast:request.response_message duration:2];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
- (void)sendSaveContactRequest:(NSDictionary *)dic product_id:(NSString *)product_id
{
    PTSaveContactService *service = [[PTSaveContactService alloc] initWithDic:dic];
    [service startWithCompletionBlockWithSuccess:^(__kindof PTBaseRequest * _Nonnull request) {
        if (request.response_code == 0) {
            if ([self.delegate respondsToSelector:@selector(saveContactSucceed)]) {
                [self.delegate saveContactSucceed];
            }
            if(PTUserManager.sharedUser.isaduit){
                if ([self.delegate respondsToSelector:@selector(removeViewController)]) {
                    [self.delegate removeViewController];
                }
                return;
            }
            NSString *nextStr = [NSString stringWithFormat:@"%@",request.response_dic[@"detenectibleNc"][@"retenloomNc"]];
            if(![PTNotNull(nextStr) br_isBlankString]){
                [self.delegate router:[nextStr br_pinProductId:product_id]];
                return;
            }
            [self sendOrderPushRequestWithOrderId:PTUserManager.sharedUser.oder product_id:product_id];
        }else
        {
            [self.delegate showToast:request.response_message duration:2];
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
