//
//  PTHomeViewModel.m
//  PTApp
//
//  Created by 刘巍 on 2024/8/1.
//

#import "PTHomeViewModel.h"
#import "PTHomeIndexService.h"
#import "PTHomeIetenNcModel.h"
#import "PTHomeBannerModel.h"
#import "PTHomeLargeEcardModel.h"
#import "PTHomeIetenNcModel.h"
#import "PTRidingLanternModel.h"
#import "PTHomeSmallCardModel.h"
#import "PTHomeProductModel.h"
#import "PTHomeApplyModel.h"
#import "PTHomeRepayModel.h"
#import "PTHomeGceApplyService.h"
#import "PTDeviceService.h"
#import "PTHomeGCeDetailService.h"
#import "PTAuthenticationModel.h"
#import "PTHomeGCePushService.h"
#import "PTHomePopApi.h"
@implementation PTHomeViewModel

-(void)getHomeIndexfinish:(void (^)(BOOL isShowNav,BOOL isShowMember,PTHomeIetenNcModel *ietenNcModel))successBlock failture:(void (^)(void))failtureBlock
{
    WEAKSELF
    PTHomeIndexService *homeIndexService = [[PTHomeIndexService alloc] initWithhomeIndex];
    [homeIndexService startWithCompletionBlockWithSuccess:^(__kindof PTBaseRequest * _Nonnull request) {
        STRONGSELF
        if(request.response_code != 0){
            [PTTools showToast:request.response_message];
            return;
        }
        [strongSelf handleHomePageDic:request.response_dic finish:successBlock];
    } failure:^(__kindof PTBaseRequest * _Nonnull request) {
        
    }];
}

- (void)sendGetHomePop
{
    PTHomePopApi *api = [[PTHomePopApi alloc] init];
    [api startWithCompletionBlockWithSuccess:^(__kindof PTBaseRequest * _Nonnull request) {
        if (request.response_code == 0) {
            NSString *url = request.response_dic[@"metenulloblastomaNc"];
            NSString *jumpURL = request.response_dic[@"retenloomNc"];
            if ([self.delegate respondsToSelector:@selector(updatePopWithIconURL:jumpURL:)]) {
                [self.delegate updatePopWithIconURL:url jumpURL:jumpURL];
            }
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
- (void)sendApplyRequest:(NSString *)product_id
{
    PTHomeGceApplyService *applyService = [[PTHomeGceApplyService alloc] initWithlitenetusNc:product_id];
    WEAKSELF
    [applyService startWithCompletionBlockWithSuccess:^(__kindof PTBaseRequest * _Nonnull request) {
        STRONGSELF
        if(request.response_code != 00){
            [PTTools showToast:PTNotNull(request.response_message)];
            return;
        }
        [strongSelf resolveApplyData:request.response_dic productId:product_id];
    } failure:^(__kindof PTBaseRequest * _Nonnull request) {
        
    }];
}
- (void)resolveApplyData:(NSDictionary *)dic productId:(NSString *)product_id{
    PTHomeApplyModel *model = [PTHomeApplyModel yy_modelWithDictionary:dic];
    if(model.fltencNc == 2){
        [self updataDaeaDevice];
    }
   
    //跳认证 &web合并
    if(![PTNotNull(model.retenloomNc) br_isBlankString]){
        if (![model.retenloomNc containsString:@"open/zzzvten"]) {
            if ([self.delegate respondsToSelector:@selector(router:)]) {
                [self.delegate router:[model.retenloomNc br_pinProductId:product_id]];
            }
            return;
        }
    }
    //是否跳认证详情页 0 不显示，1显示
    if(model.detentrogyrateNc){
        if ([self.delegate respondsToSelector:@selector(router:)]) {
            [self.delegate router:[@"tenJump://open/zzzvten" br_pinProductId:product_id]];
        }
        return;
    }
    
    [self sendGetProductDetailRequest:product_id];

}
/**详情接口**/
- (void)sendGetProductDetailRequest:(NSString *)product_id{
    PTHomeGCeDetailService *api = [[PTHomeGCeDetailService alloc] initWithProductId:product_id];
    [api startWithCompletionBlockWithSuccess:^(__kindof PTBaseRequest * _Nonnull request) {
        if (request.response_code == 0) {
            PTAuthenticationModel *model = [PTAuthenticationModel yy_modelWithDictionary:request.response_dic];
            [PTUserManager sharedUser].oder = model.letenonishNc.cotenketNc;
            //跳转下一步认证
            if (model.hetenistopNc && ![model.hetenistopNc.retenloomNc isEqual:@""]) {
                if ([self.delegate respondsToSelector:@selector(router:)]) {
                    [self.delegate router:[model.hetenistopNc.retenloomNc br_pinProductId:model.letenonishNc.retengnNc]];
                }
                return;
            }
            [self sendOrderPushRequestWithOrderId:model.letenonishNc.cotenketNc product_id:product_id];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
/**推单**/
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
///上报设备信息
-(void)updataDaeaDevice
{
    [[PTUploadDeviceInfoManager sharedManager] uploadDeviceInfo];
//    PTDeviceService *deviceService = [[PTDeviceService alloc] initWithData:[PTDeviceInfo getDevices]];
//    [deviceService startWithCompletionBlockWithSuccess:^(__kindof PTBaseRequest * _Nonnull request) {
//    
//    } failure:^(__kindof PTBaseRequest * _Nonnull request) {
//        
//    }];
}
- (void)handleHomePageDic:(NSDictionary*)dic finish:(void (^)(BOOL isShowNav,BOOL isShowMember,PTHomeIetenNcModel *ietenNcModel))successBlock
{
    PTHomeIetenNcModel *ietenNcModel = nil;
    if(dic[@"ietenNc"]){
        ietenNcModel = [PTHomeIetenNcModel yy_modelWithDictionary:dic[@"ietenNc"]];
    }
    
    if(!dic[@"xatenthosisNc"] || ![dic[@"xatenthosisNc"]isKindOfClass:[NSArray class]])return;
    NSArray *dataArr = dic[@"xatenthosisNc"];
    [self.homeDataArray removeAllObjects];
    WEAKSELF
    __block BOOL isShowNav = NO;
    __block BOOL isShowMember = NO;
    [dataArr enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
        STRONGSELF
        if(!dic[@"ittenlianizeNc"] || ![dic[@"ittenlianizeNc"] isKindOfClass:[NSString class]])return;
        NSString *cellType = [NSString stringWithFormat:@"%@",dic[@"ittenlianizeNc"]];
        if([cellType isEqualToString:@"AAAXTEN"]){//大卡牌
            PTHomeLargeEcardModel *cardModel = [PTHomeLargeEcardModel yy_modelWithDictionary:dic];
            cardModel.cellHigh = (kScreenWidth-32)/343*278 + 24;
            cardModel.cellType = cellType;
            [strongSelf.homeDataArray addObject:cardModel];
            if (PTUserManager.sharedUser.isaduit) {
                isShowNav = YES;
            }
            return;
        }
        
        if([cellType isEqualToString:@"AAAYTEN"]){//小卡片
            PTHomeSmallCardModel *smallCardModel = [PTHomeSmallCardModel yy_modelWithDictionary:dic];
            smallCardModel.cellHigh = 202.f;
            smallCardModel.cellType = cellType;
            [strongSelf.homeDataArray addObject:smallCardModel];
            PTHomeSmallCardItemModel *itemModel = [smallCardModel.gutengoyleNc firstObject];
            isShowNav = YES;
            isShowMember = ![PTTools isBlankString:itemModel.detenensiveNc];
            return;
        }
        
        if([cellType isEqualToString:@"AAAVTEN"]){//banner
            PTHomeBannerModel *bannerModel = [PTHomeBannerModel yy_modelWithDictionary:dic];
            bannerModel.cellType = cellType;
            bannerModel.cellHigh = 120;
            [self.homeDataArray addObject:bannerModel];
        }
        if([cellType isEqualToString:@"REPAY_NOTICE"]){//还款
            PTHomeRepayModel *repayModel = [PTHomeRepayModel yy_modelWithDictionary:dic];
            [repayModel.gutengoyleNc enumerateObjectsUsingBlock:^(PTHomeRepayRealModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
                if(idx == 0){
                    model.cellType = cellType;
                    [strongSelf.homeDataArray addObject:model];
                }
            }];
            return;
        }

        if([cellType isEqualToString:@"AAAZTEN"]){//贷超组件
            PTHomeProductModel *productModel = [PTHomeProductModel yy_modelWithDictionary:dic];
            [productModel.gutengoyleNc enumerateObjectsUsingBlock:^(PTHomeProductListModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
                model.cellType = cellType;
                model.cellHigh = 152.f;
                [strongSelf.homeDataArray addObject:model];
            }];
            return;
        }
    }];
    
   
    if(!isShowNav){
        NSMutableIndexSet *indexesToRemove = [NSMutableIndexSet indexSet];
        [self.homeDataArray enumerateObjectsUsingBlock:^(PTHomeBaseModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if([obj.cellType isEqualToString:@"AAAVTEN"]) {
                [indexesToRemove addIndex:idx];
            }
        }];
        [self.homeDataArray removeObjectsAtIndexes:indexesToRemove];
    }
    
    
    if(!isShowNav){
        PTHomeBaseModel *tipModel = [[PTHomeBaseModel alloc] init];
        tipModel.cellType = @"AAABBB";
        tipModel.cellHigh = 264.f;
        tipModel.level = 2.f;
        [self.homeDataArray addObject:tipModel];
    }
    ///添加默认产品图
    PTHomeBaseModel *brandModel = [[PTHomeBaseModel alloc] init];
    brandModel.cellType = @"AAACCC";
    brandModel.cellHigh = 150.f;
    brandModel.level = 8.f;
    [self.homeDataArray addObject:brandModel];
    
    
    
    self.homeDataArray = [[self.homeDataArray sortedArrayUsingComparator:^NSComparisonResult(PTHomeBaseModel*obj1, PTHomeBaseModel *obj2) {
        return [[NSNumber numberWithInteger:obj1.level] compare: [NSNumber numberWithInteger:obj2.level]];
    }] mutableCopy];
   
    if(successBlock){
        successBlock(isShowNav, isShowMember,ietenNcModel);
    }
}


#pragma mark - lazy
-(NSMutableArray<PTHomeBaseModel *> *)homeDataArray{
    if(!_homeDataArray){
        _homeDataArray = [NSMutableArray array];
    }
    
    return _homeDataArray;
}

@end
