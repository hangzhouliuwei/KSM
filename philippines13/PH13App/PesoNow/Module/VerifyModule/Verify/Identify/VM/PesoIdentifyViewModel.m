//
//  PesoIdentifyViewModel.m
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import "PesoIdentifyViewModel.h"
#import "PesoIdentifyAPI.h"
#import "PesoIdentifyUploadImgAPI.h"
#import "PesoSaveIdentifyInfoAPI.h"
#import "PesoIdentifyModel.h"
#import "UIImage+HXExtension.h"
@implementation PesoIdentifyViewModel
- (void)loadGetIdentifyRequestWithProductId:(NSString *)product_id callback:(void (^)(id _Nonnull))callback
{
    PesoIdentifyAPI *api = [[PesoIdentifyAPI alloc] initWithData:product_id];
    [api startWithCompletionBlockWithSuccess:^(__kindof PesoBaseAPI * _Nonnull request) {
        if (request.responseCode == 0) {
            PesoIdentifyModel *model = [PesoIdentifyModel yy_modelWithDictionary:request.responseDic];
            callback(model);
        }else{
            [PesoUtil showToast:request.responseMessage];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
- (void)loadUploadImageRequestWithDic:(NSDictionary *)dic image:(UIImage *)image callback:(void (^)(id _Nonnull))callback
{
    UIImage *pressImage =[image hx_scaleToFitSize:CGSizeMake(1024, 1024)];
    
    PesoIdentifyUploadImgAPI *api = [[PesoIdentifyUploadImgAPI alloc] initWithImage:pressImage param:dic];
    [api startWithCompletionBlockWithSuccess:^(__kindof PesoBaseAPI * _Nonnull request) {
        if (request.responseCode == 0) {
            PesoIdentifyDetailModel *model = [PesoIdentifyDetailModel yy_modelWithDictionary:request.responseDic];
            model.idCardImage = pressImage;
            if (callback) {
                callback(model);
            }
        }else {
            [PesoUtil showToast:request.responseMessage];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
- (void)loadSaveIdentifyRequestWithDic:(NSDictionary *)dic product_id:(NSString *)product_id callback:(void (^)(id _Nonnull))callback
{
    PesoSaveIdentifyInfoAPI *api = [[PesoSaveIdentifyInfoAPI alloc] initWithData:dic];
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
