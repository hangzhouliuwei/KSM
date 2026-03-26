//
//  PesoMineVM.m
//  PesoApp
//
//  Created by Jacky on 2024/9/18.
//

#import "PesoMineVM.h"
#import "PesoMineModel.h"
#import "PesoMineAPI.h"
@implementation PesoMineVM
- (void)loadMineAPI:(void (^)(id _Nonnull))callback
{
    PesoMineAPI *api = [[PesoMineAPI alloc]init];
    [api startWithCompletionBlockWithSuccess:^(__kindof PesoBaseAPI * _Nonnull request) {
        if (request.responseCode == 0) {
            PesoMineModel *mineModel = [PesoMineModel yy_modelWithJSON:request.responseDic];
            __block NSMutableArray *array = [NSMutableArray array];
            [mineModel.getithirteencNc enumerateObjectsUsingBlock:^(PesoMineItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if(obj){
                    obj.type = @"list";
                    obj.height = 60;
                    [array addObject:obj];
                }
            }];
            if(mineModel.unquthirteenalizeNc){
                mineModel.unquthirteenalizeNc.height = 171.f;
                mineModel.unquthirteenalizeNc.type = @"repay";
                [array insertObject:mineModel.unquthirteenalizeNc atIndex:0];
            }
//            PesoMineRepayModel *model =  PesoMineRepayModel.new;
//            model.height = 171.f;
//            model.type = @"repay";
//            [array insertObject:model atIndex:0];
            if (callback) {
                callback(array.copy);
            }
        }else{
            [PesoUtil showToast:request.responseMessage];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
@end
