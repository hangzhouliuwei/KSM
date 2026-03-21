//
//  BagVerifyIdentifyPresenter.m
//  NewBag
//
//  Created by Jacky on 2024/4/8.
//

#import "BagVerifyIdentifyPresenter.h"
#import "BagVerifyGetIdentifyService.h"
#import "BagVerifyUploadIDService.h"
#import "BagVerifySaveIdentifyService.h"
#import "BagHomePushService.h"
#import "BagIdentifyModel.h"
#import "UIImage+BRAdd.h"
#import "BagUploadDeviceService.h"
#import "BagUploadDeviceManager.h"

@implementation BagVerifyIdentifyPresenter
/**初始化**/
- (void)sendGetIdentifyRequestWithProductId:(NSString *)product_id
{
    BagVerifyGetIdentifyService *service = [[BagVerifyGetIdentifyService alloc] initWithProductId:product_id];
    [service startWithCompletionBlockWithSuccess:^(__kindof BagBaseRequest * _Nonnull request) {
        NSLog(@"lw=====>%@",[request.response_dic yy_modelToJSONString]);
        if (request.response_code == 0) {
            BagIdentifyModel *model = [BagIdentifyModel yy_modelWithDictionary:request.response_dic];
            [self.delegate updateUIWithModel:model];
        }else{
            [self.delegate showToast:request.response_message duration:1.5];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
/**上传身份证**/
- (void)sendUploadImageRequestWithDic:(NSDictionary *)dic image:(UIImage *)image
{
    UIImage *imageP = [UIImage scaleBiteImage:image toKBite:200];

    BagVerifyUploadIDService*service = [[BagVerifyUploadIDService alloc] initWithImage:imageP param:dic];
    [service startWithCompletionBlockWithSuccess:^(__kindof BagBaseRequest * _Nonnull request) {
        if (request.response_code == 0) {
            BagIdentifyDetailModel *model = [BagIdentifyDetailModel yy_modelWithDictionary:request.response_dic];
            model.idCardImage = imageP;
            [self.delegate updateUIWithIdentifyDetailModel:model];
            
        }else{
            [self.delegate showToast:request.response_message duration:1.5];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
/**保存身份信息**/
- (void)sendSaveIdentifyRequestWithDic:(NSDictionary *)dic product_id:(nonnull NSString *)product_id
{
    BagVerifySaveIdentifyService *service = [[BagVerifySaveIdentifyService alloc] initWithDic:dic];
    [service startWithCompletionBlockWithSuccess:^(__kindof BagBaseRequest * _Nonnull request) {
        if (request.response_code == 0) {
            [self.delegate saveIdentifySucceed];
            if(BagUserManager.shareInstance.is_aduit){
                [self.delegate removeViewController];
                return;
            }
            NSString *nextStr = [NSString stringWithFormat:@"%@",request.response_dic[@"deecfourteentibleNc"][@"relofourteenomNc"]];
            if(![nextStr br_isBlankString]){
                [self.delegate jumpNextPageWithProductId:product_id nextUrl:nextStr];
                [self.delegate removeViewController];
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
            NSString *url = dic[@"viusfourteenNc"][@"relofourteenomNc"];
            [self.delegate jumpNextPageWithProductId:@"" nextUrl:url];
            [self.delegate removeViewController];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
- (void)sendUploadDeviceRequest{
//    BagUploadDeviceService *request = [[BagUploadDeviceService alloc] initWithData:[Util getNowDeviceInfo]];
//    [request startWithCompletionBlockWithSuccess:^(__kindof BagBaseRequest * _Nonnull request) {
//        if (request.response_code == 0) {
//            //success
//            NSLog(@"");
//        }
//    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//        
//    }];
    
    [[BagUploadDeviceManager shareInstance] uploadDevice];
}
@end
