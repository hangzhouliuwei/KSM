//
//  PUBMineViewModel.m
//  PeraUBagProject
//
//  Created by Jacky on 2024/1/15.
//

#import "PUBMineViewModel.h"
#import "PUBMineModel.h"
@implementation PUBMineViewModel
- (void)getDataSuccess:(void (^)(PUBMineModel *))successBlock fail:(void (^)(void))failBlock
{
    WEAKSELF
    [HttPPUBRequest getWithPath:mine params:@{} success:^(NSDictionary * _Nonnull responseDataDic, PUBBaseResponseModel * _Nonnull mode) {
        
        if(!mode.success){
            [PUBTools showToast:mode.desc];
            return;
        }
        if(!mode.dataDic||![mode.dataDic isKindOfClass:[NSDictionary class]])return;
        PUBMineModel *model = [PUBMineModel yy_modelWithDictionary:mode.dataDic];
        successBlock(model);
    } failure:^(NSError * _Nonnull error) {
        failBlock();
    }];
}
@end
