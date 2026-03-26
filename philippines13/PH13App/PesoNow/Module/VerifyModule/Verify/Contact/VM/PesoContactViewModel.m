//
//  PesoContactViewModel.m
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import "PesoContactViewModel.h"
#import "PesoContactAPI.h"
#import "PesoSaveContactAPI.h"
#import "PesoContactModel.h"
@implementation PesoContactViewModel
- (void)loadGetContactRequest:(NSString *)product_id callback:(nonnull void (^)(id _Nonnull))callback
{
    PesoContactAPI *api = [[PesoContactAPI alloc] initWithData:product_id];
    [api startWithCompletionBlockWithSuccess:^(__kindof PesoBaseAPI * _Nonnull request) {
        if (request.responseCode == 0) {
            PesoContactModel *model = [PesoContactModel yy_modelWithDictionary:request.responseDic];
            NSLog(@"");
            callback(model);
        }else{
            [PesoUtil showToast:request.responseMessage];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
- (void)loadSaveContactRequest:(NSString *)product_id dic:(NSDictionary *)dic  callback:(void (^)(id _Nonnull))callback
{
    PesoSaveContactAPI *api = [[PesoSaveContactAPI alloc] initWithData:dic];
    [api startWithCompletionBlockWithSuccess:^(__kindof PesoBaseAPI * _Nonnull request) {
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
