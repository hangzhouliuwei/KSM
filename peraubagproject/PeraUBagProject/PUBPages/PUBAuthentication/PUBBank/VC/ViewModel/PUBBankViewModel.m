//
//  PUBBankViewModel.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/10.
//

#import "PUBBankViewModel.h"
#import "PUBBankModel.h"

@implementation PUBBankViewModel

///银行卡初始化接口（第五项）
- (void)getBindCardInitView:(UIView *)view dic:(NSDictionary *)dic finish:(void (^)(PUBBankModel *bankModel))successBlock failture:(void (^)(void))failtureBlock
{
    
    
    [HttPPUBRequest postWithPath:bindCardInit params:dic success:^(NSDictionary * _Nonnull responseDataDic, PUBBaseResponseModel * _Nonnull mode) {
        if(!mode.success){
            [PUBTools showToast:mode.desc];
            return;
        }
        PUBBankModel *bankModel = [PUBBankModel yy_modelWithDictionary:mode.dataDic];
        if(successBlock){
            successBlock(bankModel);
        }
        
    } failure:^(NSError * _Nonnull error) {
        
        if(failtureBlock){
            failtureBlock();
        }
    } showLoading:YES];
    
}

///保存银行卡信息（第五项）
- (void)getSaveBindCardView:(UIView *)view dic:(NSDictionary *)dic finish:(void (^)(NSDictionary *dic))successBlock failture:(void (^)(void))failtureBlock
{
    
    [HttPPUBRequest postWithPath:saveBindCard params:dic success:^(NSDictionary * _Nonnull responseDataDic, PUBBaseResponseModel * _Nonnull mode) {
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
