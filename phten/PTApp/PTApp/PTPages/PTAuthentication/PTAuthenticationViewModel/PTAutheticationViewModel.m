//
//  PTAutheticationViewModel.m
//  PTApp
//
//  Created by 刘巍 on 2024/8/13.
//

#import "PTAutheticationViewModel.h"
#import "PTAuthenTicationSerive.h"
#import "PTAuthenticationModel.h"
#import "PTHomeGCePushService.h"
@implementation PTAutheticationViewModel

-(void)getAutheticationdeatalRetengnNc:(NSString*)retengnNc finish:(void (^)(PTAuthenticationModel *model))successBlock failture:(void (^)(void))failtureBlock
{
    PTAuthenTicationSerive *serive = [[PTAuthenTicationSerive alloc] initWithlitenetusNc:PTNotNull(retengnNc)];
    [serive startWithCompletionBlockWithSuccess:^(__kindof PTBaseRequest * _Nonnull request) {
        if(request.response_code != 00){
            [PTTools showToast:request.response_message];
            return;
        }
        
        PTAuthenticationModel *model = [PTAuthenticationModel yy_modelWithDictionary:request.response_dic];
        if(successBlock){
            successBlock(model);
        }
        
    } failure:^(__kindof PTBaseRequest * _Nonnull request) {
       
    }];
}

/**根据订单拿跳转地址**/
- (void)pt_sendOrderPushRequestWithOrderId:(NSString *)order_id product_id:(NSString *)product_id
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
