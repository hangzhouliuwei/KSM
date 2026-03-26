//
//  PUBBasicViewModel.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/29.
//

#import "PUBBasicViewModel.h"
#import "PUBBasicModel.h"

@implementation PUBBasicViewModel


///初始化基础信息
- (void)getbasicInfoView:(UIView *)view dic:(NSDictionary *)dic finish:(void (^)(PUBBasicModel *basicModel))successBlock failture:(void (^)(void))failtureBlock
{
    
    [HttPPUBRequest postWithPath:certifyInfo params:dic success:^(NSDictionary * _Nonnull responseDataDic, PUBBaseResponseModel * _Nonnull mode) {
        if(!mode.success){
            [PUBTools showToast:mode.desc];
            return;
        }
        PUBBasicModel *basicModel = [PUBBasicModel yy_modelWithDictionary:mode.dataDic];
        if(successBlock){
            successBlock(basicModel);
        }
        
    } failure:^(NSError * _Nonnull error) {
        
        if(failtureBlock){
            failtureBlock();
        }
    } showLoading:YES];
    
}

///保存基础信息
- (void)getSaveBasicInfoView:(UIView *)view dic:(NSDictionary *)dic finish:(void (^)(NSDictionary *dic))successBlock failture:(void (^)(void))failtureBlock
{
    
    [HttPPUBRequest postWithPath:saveBasicInfo params:dic success:^(NSDictionary * _Nonnull responseDataDic, PUBBaseResponseModel * _Nonnull mode) {
        if(!mode.success){
            [PUBTools showToast:mode.desc];
            return;
        }
        if(successBlock){
            successBlock(mode.dataDic);
        }
    } failure:^(NSError * _Nonnull error) {
        
        if(failtureBlock){
            failtureBlock();
        }
    } showLoading:YES];
}

@end
