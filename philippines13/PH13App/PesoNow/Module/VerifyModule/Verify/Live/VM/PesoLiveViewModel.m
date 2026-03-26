//
//  PesoLiveViewModel.m
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import "PesoLiveViewModel.h"
#import "PesoLiveAPI.h"
#import "PesoLiveLimitAPI.h"
#import "PesoLiveAuthAPI.h"
#import "PesoLiveDetectionAPI.h"
#import "PesoLiveSaveAPI.h"
#import "PesoLiveErrorAPI.h"
#import "PesoLiveModel.h"
@implementation PesoLiveViewModel
- (void)loadLiveRequestWithProductId:(NSString *)product_id callback:(void(^)(id model))callback
{
    PesoLiveAPI *service = [[PesoLiveAPI alloc] initWithData:product_id];
    [service startWithCompletionBlockWithSuccess:^(__kindof PesoBaseAPI * _Nonnull request) {
        if (request.responseCode == 0) {
            PesoLiveModel *model = [PesoLiveModel yy_modelWithDictionary:request.responseDic[@"prtothirteenzoalNc"]];
            if (callback) {
                callback(model);
            }
        }else{
            [PesoUtil showToast:request.responseMessage];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
- (void)loadLiveLimitRequestWithProductId:(NSString *)product_id callback:(void(^)(id model))callback
{
    PesoLiveLimitAPI *service = [[PesoLiveLimitAPI alloc] initWithData:product_id];
    [service startWithCompletionBlockWithSuccess:^(__kindof PesoBaseAPI * _Nonnull request) {
        if (request.responseCode == 0) {
            [self loadLiveAuthRequest:product_id callback:^(NSString *license) {
                if (callback) {
                    callback(license);
                }
            }];
        }else{
            [PesoUtil showToast:request.responseMessage];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
- (void)loadLiveAuthRequest:(NSString *)product_id callback:(void(^)(id model))callback
{
    PesoLiveAuthAPI *service = [[PesoLiveAuthAPI alloc] initWithData:product_id];
    [service startWithCompletionBlockWithSuccess:^(__kindof PesoBaseAPI * _Nonnull request) {
        if (request.responseCode == 0) {
            NSString *license = [NSString stringWithFormat:@"%@",request.responseDic[@"tafythirteenNc"]];
            if (callback) {
                callback(license);
            }
        }else{
            [PesoUtil showToast:request.responseMessage];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
- (void)loadLiveLDetctionRequestWithProductId:(NSString *)product_id liveness_id:(NSString *)liveness_id callback:(void(^)(id model))callback
{
    PesoLiveDetectionAPI *service = [[PesoLiveDetectionAPI alloc] initWithProductId:product_id liveness_id:liveness_id];
    [service startWithCompletionBlockWithSuccess:^(__kindof PesoBaseAPI * _Nonnull request) {
        if (request.responseCode == 0) {
            NSString *relation_id = [NSString stringWithFormat:@"%@",request.responseDic[@"paalthirteenympicsNc"]];
            if (callback) {
                callback(relation_id);
            }
        }else{
            [PesoUtil showToast:request.responseMessage];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
- (void)loadSaveLiveRequestWithDic:(NSDictionary *)dic productId:(NSString *)product_id callback:(void(^)(id model))callback
{
    PesoLiveSaveAPI *service = [[PesoLiveSaveAPI alloc] initWithData:dic];
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
-(void)loadUploadLiveErrorRequestWithError:(NSString *)error
{
    
}
@end
