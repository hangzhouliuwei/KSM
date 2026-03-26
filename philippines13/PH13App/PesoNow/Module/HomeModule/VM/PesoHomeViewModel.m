//
//  PesoHomeViewModel.m
//  PesoApp
//
//  Created by Jacky on 2024/9/11.
//

#import "PesoHomeViewModel.h"
#import "PesoHomeAPI.h"
#import "PesoApplyAPI.h"
#import "PesoHomeViewModel+ResolveData.h"
#import "PesoApplyModel.h"
#import "PesoPrdoductDetailAPI.h"
#import "PesoOrderPushAPI.h"
#import "PesoHomePopAPI.h"
#import "PesoDetailModel.h"
@interface PesoHomeViewModel()

@end
@implementation PesoHomeViewModel

- (void)loadHomeData:(void (^)(id _Nonnull))callback
{
    PesoHomeAPI *api = [[PesoHomeAPI alloc] init];
    [api startWithCompletionBlockWithSuccess:^(__kindof PesoBaseAPI * _Nonnull request) {
        if (request.responseCode == 0) {
            __block RACTuple *tuple = [[RACTuple alloc] init];
            NSString *iconUrl = request.responseDic[@"ieNcthirteen"][@"intathirteenntNc"];
            NSString *jumpUrl = request.responseDic[@"ieNcthirteen"][@"kichthirteeniNc"];

            [self resolveData:request.responseDic callback:^(NSArray * _Nonnull array) {
                tuple = [tuple tupleByAddingObject:array];
                tuple = [tuple tupleByAddingObject:NotNil(iconUrl)];
                tuple = [tuple tupleByAddingObject:NotNil(jumpUrl)];
                if (callback) {
                    callback(tuple);
                }
            }];
        }else {
            [PesoUtil showToast:request.responseMessage];
        }
    } failure:^(__kindof PesoBaseAPI * _Nonnull request) {
        
    }];
}
- (void)loadApplyRequest:(NSString *)product_id callback:(void(^)(id model))callback
{
    PesoApplyAPI *api = [[PesoApplyAPI alloc] initWithProductId:product_id];
    [api startWithCompletionBlockWithSuccess:^(__kindof PesoBaseAPI * _Nonnull request) {
        if (request.responseCode != 0) {
            [PesoUtil showToast:request.responseMessage];
            return;
        }
        PesoApplyModel *model = [PesoApplyModel yy_modelWithDictionary:request.responseDic];
        if (callback) {
            callback(model);
        }
        
    } failure:^(__kindof PesoBaseAPI * _Nonnull request) {
        
    }];
}
- (void)loadProductDetailRequest:(NSString *)product_id callback:(void (^)(id _Nonnull))callback
{
    PesoPrdoductDetailAPI *api = [[PesoPrdoductDetailAPI alloc] initWithProductId:product_id];
    [api startWithCompletionBlockWithSuccess:^(__kindof PesoBaseAPI * _Nonnull request) {
        if (request.responseCode == 0) {
            PesoDetailModel *model = [PesoDetailModel yy_modelWithDictionary:request.responseDic];
            if (callback) {
                callback(model);
            }
        }else {
            [PesoUtil showToast:request.responseMessage];
        }
    } failure:^(__kindof PesoBaseAPI * _Nonnull request) {
        
    }];
}
/**推单**/
- (void)loadPushRequestWithOrderId:(NSString *)order_id product_id:(NSString *)product_id callback:(void (^)(id _Nonnull))callback
{
    PesoOrderPushAPI *api = [[PesoOrderPushAPI alloc] initWithOrderId:order_id];
    [api startWithCompletionBlockWithSuccess:^(__kindof PesoBaseAPI * _Nonnull request) {
        if (request.responseCode != 0) {
            [PesoUtil showToast:request.responseMessage];
            return;
        }
        NSDictionary *dic = request.responseDic;
        NSString *url = dic[@"relothirteenomNc"];
        if (callback) {
            callback(url);
        }
    } failure:^(__kindof PesoBaseAPI * _Nonnull request) {
        
    }];
}
- (void)loadHomePopData:(void (^)(id _Nonnull))callback
{
    PesoHomePopAPI *api = [[PesoHomePopAPI alloc] init];
    [api startWithCompletionBlockWithSuccess:^(__kindof PesoBaseAPI * _Nonnull request) {
        if (request.responseCode == 0) {
            NSString *url = request.responseDic[@"meulthirteenloblastomaNc"];
            NSString *jumpURL = request.responseDic[@"relothirteenomNc"];
            RACTuple *tuple = [RACTuple tupleWithObjectsFromArray:@[NotNil(url),NotNil(jumpURL)]];
            callback(tuple);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
@end
