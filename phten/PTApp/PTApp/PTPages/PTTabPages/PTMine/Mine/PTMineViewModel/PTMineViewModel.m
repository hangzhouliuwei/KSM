//
//  PTMineViewModel.m
//  PTApp
//
//  Created by 刘巍 on 2024/8/9.
//

#import "PTMineViewModel.h"
#import "PTMineIndexService.h"
#import "PTHomeBaseModel.h"
#import "PTMineModel.h"

@interface PTMineViewModel()
@property(nonatomic, strong) NSMutableArray <PTHomeBaseModel*>*dataArray;
@end

@implementation PTMineViewModel

-(void)getMianeIndexFinish:(void(^)(NSArray<PTHomeBaseModel*>*dataArray,NSString *memberUrl))successBlock failture:(void (^)(void))failtureBlock
{
    PTMineIndexService *mineIndexService = [[PTMineIndexService alloc] initWithMineIndex];
    WEAKSELF
    [mineIndexService startWithCompletionBlockWithSuccess:^(__kindof PTBaseRequest * _Nonnull request) {
        STRONGSELF
        if(request.response_code != 0){
            [PTTools showToast:request.response_message];
            return;
        }
        
        PTMineModel *mineModel = [PTMineModel yy_modelWithJSON:request.response_dic];
        [strongSelf.dataArray removeAllObjects];
        [mineModel.getenticNc enumerateObjectsUsingBlock:^(PTMineItemModel * _Nonnull itemModel, NSUInteger idx, BOOL * _Nonnull stop) {
            if(itemModel){
                itemModel.cellType = @"itemCellID";
                itemModel.cellHigh = 65.f;
                [strongSelf.dataArray addObject:itemModel];
            }
        }];
        
        if(mineModel.untenqualizeNc){
            mineModel.untenqualizeNc.cellHigh = 188.f;
            mineModel.untenqualizeNc.cellType = @"unCellID";
            [strongSelf.dataArray insertObject:mineModel.untenqualizeNc atIndex:0];
        }
        
//        PTMineNcModel *untenqualizeNc = [[PTMineNcModel alloc] init];
//        untenqualizeNc.cellHigh = 188.f;
//        untenqualizeNc.cellType = @"unCellID";
//        [strongSelf.dataArray insertObject:untenqualizeNc atIndex:0];
        
        if(successBlock){
            successBlock(strongSelf.dataArray,mineModel.detenensiveNc);
        }
    
    } failure:^(__kindof PTBaseRequest * _Nonnull request) {
        
        [PTTools showToast:request.response_message];
        if(failtureBlock){
            failtureBlock();
        }
    }];
    
}

#pragma mark - lazy
-(NSMutableArray<PTHomeBaseModel *> *)dataArray{
    if(!_dataArray){
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


@end
