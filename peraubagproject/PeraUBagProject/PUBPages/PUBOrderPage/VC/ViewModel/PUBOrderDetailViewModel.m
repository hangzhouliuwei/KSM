//
//  PUBOrderDetailViewModel.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/15.
//

#import "PUBOrderDetailViewModel.h"
#import "PUBOrederModel.h"

@implementation PUBOrderDetailViewModel

///订单列表
- (void)getOrderListView:(UIView *)view dic:(NSDictionary *)dic isFist:(BOOL)isFist  finish:(void (^)(void))successBlock failture:(void (^)(void))failtureBlock showFoot:(void (^)(BOOL showFoot))showFoot
{
    WEAKSELF
    [HttPPUBRequest postWithPath:orderList params:dic success:^(NSDictionary * _Nonnull responseDataDic, PUBBaseResponseModel * _Nonnull mode) {
        STRONGSELF
        if(!mode.success){
            [PUBTools showToast:mode.desc];
            return;
        }
        PUBOrederModel *orederModel = [PUBOrederModel yy_modelWithDictionary:mode.dataDic];
        if(showFoot){
            showFoot(orederModel.somesuch_eg.count == 20 ? YES : NO);
        }
        
        if(isFist){
            [strongSelf.dataArray removeAllObjects];
            [strongSelf.dataArray addObjectsFromArray:orederModel.somesuch_eg];
//            PUBOrederItemModel *model = orederModel.somesuch_eg[0];
//            PUBOrederItemModel *ItemModel1 = [PUBOrederItemModel new];
//            ItemModel1.presenile_eg = model.presenile_eg;
//            ItemModel1.parvus_eg = model.parvus_eg;
//            ItemModel1.diphenylketone_eg = model.diphenylketone_eg;
//            ItemModel1.proconsulate_eg = model.proconsulate_eg;
//            ItemModel1.pinxit_eg = @"17.08.2020";
//            [strongSelf.dataArray addObject:ItemModel1];
//            
//            PUBOrederItemModel *ItemModel2 = [PUBOrederItemModel new];
//            ItemModel2.presenile_eg = model.presenile_eg;
//            ItemModel2.parvus_eg = model.parvus_eg;
//            ItemModel2.diphenylketone_eg = model.diphenylketone_eg;
//            ItemModel2.proconsulate_eg = model.proconsulate_eg;
//            ItemModel2.pinxit_eg = @"17.08.2020";
//            ItemModel2.flinders_eg = @"Rufund";
//            ItemModel2.ninogan_eg = @"#00FFD7";
//            //ItemModel2.bale_eg = @"https://www.baidu.com";
//            [strongSelf.dataArray addObject:ItemModel2];
            
        }else{
            [strongSelf.dataArray addObjectsFromArray:orederModel.somesuch_eg];
        }
        
        
        if(successBlock){
            successBlock();
        }
    } failure:^(NSError * _Nonnull error) {
        if(showFoot){
            showFoot(NO);
        }
        if(failtureBlock){
            failtureBlock();
        }
    } showLoading:YES];
    
}



#pragma mark - lazy
-(NSMutableArray<PUBOrederItemModel *> *)dataArray{
    
    if(!_dataArray){
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
