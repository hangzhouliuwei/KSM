//
//  PesoBasicViewModel.m
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import "PesoBasicViewModel.h"
#import "PesoBasicInfoAPI.h"
#import "PesoSaveBasicAPI.h"
#import "PesoBasicModel.h"
@implementation PesoBasicViewModel
- (void)loadBasicRequestWithProduct_id:(NSString *)product_id callback:(void (^)(id _Nonnull))callback
{
    PesoBasicInfoAPI *api = [[PesoBasicInfoAPI alloc] initWithData:product_id];
    [api startWithCompletionBlockWithSuccess:^(__kindof PesoBaseAPI * _Nonnull request) {
        if (request.responseCode == 0) {
            PesoBasicModel *model = [PesoBasicModel yy_modelWithDictionary:request.responseDic];
            callback(model);
        }else{
            [PesoUtil showToast:request.responseMessage];
        }
    } failure:^(__kindof PesoBaseAPI * _Nonnull request) {
        
    }];
}
- (void)loadSaveBasicRequest:(NSDictionary *)data product_id:(NSString *)product_id callback:(void(^)(NSString *url))callback
{
    PesoSaveBasicAPI *service = [[PesoSaveBasicAPI alloc] initWithData:data];
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
