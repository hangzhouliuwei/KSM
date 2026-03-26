//
//  PUBLoanViewModel.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/23.
//

#import "PUBLoanViewModel.h"
#import "PUBLoanBannerModel.h"
#import "PUBLoanBgCardModel.h"
#import "PUBLoanMarketModel.h"

#import "PUBLoanApplyModel.h"
#import "PUBProductDetailModel.h"
#import "PUBUnbuildEgModel.h"
#import "PUBHomePopModel.h"

#import "PUBLoanOverdueModel.h"


@implementation PUBLoanViewModel

-(void)getHomeView:(UIView *)view finish:(void (^)(void))successBlock failture:(void (^)(void))failtureBlock
{
    WEAKSELF
    [HttPPUBRequest getWithPath:LoanData params:@{} success:^(NSDictionary * _Nonnull responseDataDic, PUBBaseResponseModel * _Nonnull mode) {
        STRONGSELF
        if(!mode.success){
            [PUBTools showToast:mode.desc];
            return;
        }
        if(!mode.dataDic||![mode.dataDic isKindOfClass:[NSDictionary class]])return;
        [strongSelf handleLoanPageDic:mode.dataDic];
        successBlock();
    } failure:^(NSError * _Nonnull error) {
        failtureBlock();
    }];
}

- (void)getApplyView:(UIView *)view dic:(NSDictionary *)dic finish:(void (^)(PUBLoanApplyModel *model))successBlock failture:(void (^)(void))failtureBlock
{
    [HttPPUBRequest postWithPath:productApply params:dic success:^(NSDictionary * _Nonnull responseDataDic, PUBBaseResponseModel * _Nonnull mode) {
        if(!mode.success){
            [PUBTools showToast:mode.desc];
            return;
        }
        PUBLoanApplyModel *applyModel = [PUBLoanApplyModel yy_modelWithDictionary:mode.dataDic];
        successBlock(applyModel);
        
    } failure:^(NSError * _Nonnull error) {
        if(failtureBlock){
            failtureBlock();
        }
    } showLoading:YES];
    
    
}

/// 上报设备信息
- (void)getUploadDevice
{
    [HttPPUBRequest updateNetWorkStatus];//更新当前用户网络状态
    [HttPPUBRequest postWithPath:uploadDevice params:[PUBTools getNowDeviceInfo] success:^(NSDictionary * _Nonnull responseDataDic, PUBBaseResponseModel * _Nonnull mode) {
        
    } failure:^(NSError * _Nonnull error) {
        
    } showLoading:NO];
    
}


///订单详情
- (void)getProductDetailView:(UIView *)view dic:(NSDictionary *)dic finish:(void (^)(PUBProductDetailModel *detailModel))successBlock failture:(void (^)(void))failtureBlock{
    
    [HttPPUBRequest postWithPath:prodDetail params:dic success:^(NSDictionary * _Nonnull responseDataDic, PUBBaseResponseModel * _Nonnull mode) {
        if(!mode.success){
            [PUBTools showToast:mode.desc];
            return;
        }
        PUBProductDetailModel *detailModel = [PUBProductDetailModel yy_modelWithDictionary:mode.dataDic];
        if(successBlock){
            successBlock(detailModel);
        }
        
    } failure:^(NSError * _Nonnull error) {
        
        if(failtureBlock){
            failtureBlock();
        }
    } showLoading:YES];
}


///跟进订单号获取跳转地址
- (void)getproductPushView:(UIView *)view dic:(NSDictionary *)dic finish:(void (^)(NSString *url))successBlock failture:(void (^)(void))failtureBlock
{
    [HttPPUBRequest postWithPath:productPush params:dic success:^(NSDictionary * _Nonnull responseDataDic, PUBBaseResponseModel * _Nonnull mode) {
        if(!mode.success){
            [PUBTools showToast:mode.desc];
            return;
        }
        NSString *jumpUrl  = [NSString stringWithFormat:@"%@", mode.dataDic[@"lobsterman_eg"]];
        if(successBlock){
            successBlock(jumpUrl);
        }
        
    } failure:^(NSError * _Nonnull error) {
        
        if(failtureBlock){
            failtureBlock();
        }
    } showLoading:YES];
    
}


///获取弹窗
- (void)getPopUpfinish:(void (^)(PUBHomePopModel *popModel))successBlock failture:(void (^)(void))failtureBlock
{
    [HttPPUBRequest getWithPath:getPopUp params:@{} success:^(NSDictionary * _Nonnull responseDataDic, PUBBaseResponseModel * _Nonnull mode) {
        if(!mode.success){
            [PUBTools showToast:mode.desc];
            return;
        }
        PUBHomePopModel *popModel = [PUBHomePopModel yy_modelWithDictionary:mode.dataDic];
        successBlock(popModel);
    } failure:^(NSError * _Nonnull error) {
        failtureBlock();
    }];
}

- (void)handleLoanPageDic:(NSDictionary*)dic
{
    if(dic[@"unbuild_eg"]){
        self.unbuildEgModel = [PUBUnbuildEgModel yy_modelWithDictionary:dic[@"unbuild_eg"]];
    }
    if(!dic[@"somesuch_eg"] || ![dic[@"somesuch_eg"]isKindOfClass:[NSArray class]])return;
    [self.dataArray removeAllObjects];
    NSArray *dataArr = dic[@"somesuch_eg"];
    WEAKSELF
    __block BOOL isShowBrand = NO;
    [dataArr enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
        STRONGSELF
        if(!dic[@"vibronic_eg"] || ![dic[@"vibronic_eg"] isKindOfClass:[NSString class]])return;
        NSString *cellType = [NSString stringWithFormat:@"%@",dic[@"vibronic_eg"]];
        if([cellType isEqualToString:@"AAAA"]){//banner
            PUBLoanBannerModel *bannerModel = [PUBLoanBannerModel yy_modelWithDictionary:dic];
            bannerModel.cellHight = 150.f;
            bannerModel.cellId = @"bannerCellId";
            bannerModel.level = 1.f;
            [strongSelf.dataArray addObject:bannerModel];
            return;
        }
        
        if([cellType isEqualToString:@"CCCC"]){//大卡位
            PUBLoanBgCardModel *bgCardModel = [PUBLoanBgCardModel yy_modelWithDictionary:dic];
            if(bgCardModel.obliterate_eg.count > 0){
                PUBLoanBgCardItemModel *bgCardItemModel = [bgCardModel.obliterate_eg firstObject];
                bgCardItemModel.cellHight = 260.f;
                bgCardItemModel.cellId = @"bgCardCellId";
                bgCardItemModel.level = 2.f;
                [strongSelf.dataArray addObject:bgCardItemModel];
                isShowBrand = YES;
                return;
            }
        }
        
        if([cellType isEqualToString:@"DDDD"]){//小卡位DDDD
            PUBLoanBgCardModel *SMCardModel = [PUBLoanBgCardModel yy_modelWithDictionary:dic];
            if(SMCardModel.obliterate_eg.count > 0){
                PUBLoanBgCardItemModel *SMCardItemModel = [SMCardModel.obliterate_eg firstObject];
                SMCardItemModel.cellHight = 260.f;
                SMCardItemModel.cellId = @"SamllCardCellId";
                SMCardItemModel.level = 3.f;
                [strongSelf.dataArray addObject:SMCardItemModel];
                isShowBrand = NO;
                return;
            }
        }
        
        if([cellType isEqualToString:@"ABCDE"]){//逾期提醒组件
            PUBLoanOverdueModel *overdueModel = [PUBLoanOverdueModel yy_modelWithDictionary:dic];
            if(overdueModel.obliterate_eg.count > 0){
                PUBLoanOverdueItmeModel *overdueItmeModel = [overdueModel.obliterate_eg firstObject];
                overdueItmeModel.cellHight = 84.f;
                overdueItmeModel.cellId = @"overdueCellId";
                overdueItmeModel.level = 4.f;
                [strongSelf.dataArray addObject:overdueItmeModel];
            }
            return;
        }
        
        if([cellType isEqualToString:@"EEEE"]){//贷超列表EEEE
            PUBLoanMarketModel *markModel = [PUBLoanMarketModel yy_modelWithDictionary:dic];
            [markModel.obliterate_eg enumerateObjectsUsingBlock:^(PUBLoanMarketItemModel * _Nonnull itemModel, NSUInteger idx, BOOL * _Nonnull stop) {
                itemModel.cellId = @"markItemId";
                itemModel.cellHight = 122.f;
                itemModel.level = 5.f;
                [strongSelf.dataArray addObject:itemModel];
            }];
            return;
        }
        
    }];
    
    if(isShowBrand){//添加默认产品图
        PUBLoanBaseModel *brandModel = [[PUBLoanBaseModel alloc] init];
        brandModel.cellId = @"brandCellId";
        brandModel.cellHight = 280.f;
        brandModel.level = 6.f;
        [self.dataArray addObject:brandModel];
    }
    
    self.dataArray = [[self.dataArray sortedArrayUsingComparator:^NSComparisonResult(PUBLoanBaseModel*obj1, PUBLoanBaseModel *obj2) {
        return [[NSNumber numberWithInteger:obj1.level] compare: [NSNumber numberWithInteger:obj2.level]];
        
    }] mutableCopy];
}


#pragma mark - lzay
- (NSMutableArray<PUBLoanBaseModel *> *)dataArray{
    if(!_dataArray){
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
