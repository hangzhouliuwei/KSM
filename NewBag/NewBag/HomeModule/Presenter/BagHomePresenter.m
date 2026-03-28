//
//  BagHomePresenter.m
//  NewBag
//
//  Created by Jacky on 2024/3/26.
//

#import "BagHomePresenter.h"
#import "BagHomeRequest.h"
#import "BagHomeApplyService.h"
#import "BagHomeProductDetailService.h"
#import "BagHomeModel.h"
#import "BagHomePushService.h"
#import "BagLoanDeatilModel.h"
#import "BagUploadDeviceService.h"
#import "BagUploadDeviceManager.h"
#import "BagHomeOpenService.h"
@interface BagHomePresenter ()
@property (nonatomic, strong) BagHomeCustomerModel *customerModel;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end
@implementation BagHomePresenter

#pragma mark - 首页接口
- (void)sendGetHomeRequest
{
    BagHomeRequest *request = [[BagHomeRequest alloc] init];
    WEAKSELF
    [request startWithCompletionBlockWithSuccess:^(__kindof BagBaseRequest * _Nonnull request) {
        STRONGSELF
        if (request.response_code == 0) {
            NSDictionary *data = request.responseObject;
            [strongSelf handleData:data];
            if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(reloadUIWithDataArray:customerModel:)]) {
                [strongSelf.delegate reloadUIWithDataArray:strongSelf.dataArray customerModel:strongSelf.customerModel];
            }
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
- (void)handleData:(NSDictionary *)data{
    self.customerModel = [BagHomeCustomerModel yy_modelWithDictionary:data[@"daemonF"][@"wholenessF"]];
    NSLog(@"");
    if(!data[@"daemonF"][@"railageF"] || ![data[@"daemonF"][@"railageF"]isKindOfClass:[NSArray class]])return;
    [self.dataArray removeAllObjects];
    NSArray *dataArr = data[@"daemonF"][@"railageF"];
    NSDictionary *keyValueDic = @{
        @"BANNER":BagHomeBannerModel.class,
        @"LARGE_CARD":BagHomeBigCardModel.class,
        @"SMALL_CARD":BagHomeSmallCardModel.class,
        @"REPAY":BagHomeRepayModel.class,
        @"RIDING_LANTERN":BagHomeHorseModel.class,
        @"PRODUCT_LIST":BagHomeProductListModel.class,
    };
    __block BOOL haveBig = NO;
    [dataArr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *key = obj[@"nortriptylineF"];
       
        Class class = keyValueDic[key];
        BagHomeModel *model = [class yy_modelWithDictionary:obj];

        if ([key isEqual:@"LARGE_CARD"]) {
            haveBig = YES;
            BagHomeBigCardModel *big = (BagHomeBigCardModel *)model;
            if (big.hematopoiesisF.count > 0) {
                BagHomeBigCardItemModel *bigItem = big.hematopoiesisF[0];
                [self.dataArray addObject:bigItem];
            }
            return;
        }
        if ([key isEqual:@"SMALL_CARD"]) {
            BagHomeSmallModel *small = [BagHomeSmallModel yy_modelWithDictionary:obj];
            if (small.hematopoiesisF.count > 0) {
                BagHomeSmallCardModel *smallItem = small.hematopoiesisF[0];
                [self.dataArray addObject:smallItem];
            }
            return;
        }
        if ([key isEqual:@"PRODUCT_LIST"]) {
            BagHomeProductListModel *list = (BagHomeProductListModel *)model;
            [list.hematopoiesisF enumerateObjectsUsingBlock:^(BagHomeProductListItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.dataArray addObject:obj];
            }];
            return;
        }
        
        [self.dataArray addObject:model];
    }];
    if (haveBig) {
        BagHomeBrandModel *model = [BagHomeBrandModel new];
        [self.dataArray addObject:model];
        NSMutableArray *temp = [NSMutableArray array];
        [self.dataArray enumerateObjectsUsingBlock:^(BagHomeModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (![obj.cellId isEqual:@"RIDING_LANTERN"]) {
                [temp addObject:obj];
            }
        }];
        self.dataArray = temp;
    }
    
    self.dataArray = [[self.dataArray sortedArrayUsingComparator:^NSComparisonResult(BagHomeModel *obj1, BagHomeModel  *obj2) {
        return obj1.level < obj2.level;
    }] mutableCopy];
}
#pragma mark - 申请
- (void)sendApplyRequestWithProductId:(NSString *)product_id
{
    BagHomeApplyService *request = [[BagHomeApplyService alloc] initWithProductId:product_id];
    [request startWithCompletionBlockWithSuccess:^(__kindof BagBaseRequest * _Nonnull request) {
        if (request.response_code == 0) {
            BagHomeApplyInfoModel *model = [BagHomeApplyInfoModel yy_modelWithDictionary:request.response_dic];
            if (self.delegate && [self.delegate respondsToSelector:@selector(getApplyRequestSucceed:)]) {
                [self.delegate getApplyRequestSucceed:model];
            }
            [self resolveApplyLogic:model productId:product_id];
        }else{
            [self.delegate showToast:request.response_message duration:1.5];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
- (void)resolveApplyLogic:(BagHomeApplyInfoModel *)model productId:(NSString *)product_id{
    if (model.pricerF == 2) {
        //上报设备信息
        [self sendUploadDeviceRequest];
    }
    //跳认证 &web合并
    if(![NotNull(model.nonvoterF) br_isBlankString]){
        if (![model.nonvoterF containsString:@"eagleJump/detail"]) {
            if ([self.delegate respondsToSelector:@selector(router:)]) {
                [self.delegate router:[model.nonvoterF br_pinProductId:product_id]];
            }
            return;
        }
    }
    
    //是否跳认证详情页 0 不显示，1显示
    if(model.iberiaF){
        [[BagRouterManager shareInstance] jumpLoanWithProId:product_id];
        return;
    }
    [self sendGetProductDetailRequestWithProductId:product_id];
    
}
#pragma mark - 产品详情
- (void)sendGetProductDetailRequestWithProductId:(NSString *)product_id
{
    BagHomeProductDetailService *request = [[BagHomeProductDetailService alloc] initWithProductId:product_id];
    [request startWithCompletionBlockWithSuccess:^(__kindof BagBaseRequest * _Nonnull request) {
        if (request.response_code == 0) {
            NSDictionary *data = request.responseObject;
            BagLoanDeatilModel *model = [BagLoanDeatilModel yy_modelWithDictionary:data[@"daemonF"]];
            //刷新
            if (self.delegate && [self.delegate respondsToSelector:@selector(updateUIWithProductDetailModel:)]) {
                [self.delegate updateUIWithProductDetailModel:model];
            }
            [BagUserManager shareInstance].order_numer = model.succussiveF.indifferentismF;
            //跳转下一步认证
            if (model.peacemongerF && ![model.peacemongerF.nonvoterF isEqual:@""]) {
                if ([self.delegate respondsToSelector:@selector(router:)]) {
                    [self.delegate router:[model.peacemongerF.nonvoterF br_pinProductId:model.succussiveF.franticF]];
                }
                return;
            }
            [self sendOrderPushRequestWithOrderId:model.succussiveF.indifferentismF product_id:product_id];
        }else
        {
            [self.delegate showToast:request.response_message duration:1.5];

        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
/**根据订单拿跳转地址**/
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
- (void)sendGetHomePop{
    BagHomeOpenService *service = [[BagHomeOpenService alloc]init];
    [service startWithCompletionBlockWithSuccess:^(__kindof BagBaseRequest * _Nonnull request) {
        BagHomePopModel *model = [BagHomePopModel yy_modelWithDictionary:request.response_dic];
        [self.delegate updatePop:model];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
#pragma mark - getter
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}
@end
