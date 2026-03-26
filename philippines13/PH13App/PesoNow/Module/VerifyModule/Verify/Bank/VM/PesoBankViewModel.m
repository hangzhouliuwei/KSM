//
//  PesoBankViewModel.m
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import "PesoBankViewModel.h"
#import "PesoBankAPI.h"
#import "PesoSaveBankInfoAPI.h"
#import "PesoBankModel.h"
@implementation PesoBankViewModel
- (void)loadGetBankRequest:(NSString *)product_id callback:(void (^)(id _Nonnull))callback
{
    PesoBankAPI *service = [[PesoBankAPI alloc] initWithData:product_id];
    [service startWithCompletionBlockWithSuccess:^(__kindof PesoBaseAPI * _Nonnull request) {
        if (request.responseCode == 0) {
            PesoBankModel *model = [PesoBankModel yy_modelWithDictionary:request.responseDic];
            callback(model);
//            [self.delegate updateUIWithModel:model];
        }else{
            [PesoUtil showToast:request.responseMessage];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
- (void)loadSaveBankInfoRequest:(NSDictionary *)dic productId:(NSString *)product_id callback:(void (^)(id _Nonnull))callback
{
    PesoSaveBankInfoAPI *service = [[PesoSaveBankInfoAPI alloc] initWithData:dic];
    [service startWithCompletionBlockWithSuccess:^(__kindof PesoBaseAPI * _Nonnull request) {
        if (request.responseCode == 0) {
            NSString *nextStr = [NSString stringWithFormat:@"%@",request.responseDic[@"deecthirteentibleNc"][@"relothirteenomNc"]];
            if (callback) {
                callback(nextStr);
            }
        }else{
            [PesoUtil showToast:request.responseMessage];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
@end
