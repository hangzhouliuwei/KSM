//
//  PUBContactViewModel.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/4.
//

#import "PUBContactViewModel.h"
#import "PUBContactModel.h"
@implementation PUBContactViewModel


- (void)getContactView:(UIView *)view dic:(NSDictionary *)dic finish:(void (^)(PUBContactModel *contactModel))successBlock failture:(void (^)(void))failtureBlock
{
    [HttPPUBRequest postWithPath:certifyContact params:dic success:^(NSDictionary * _Nonnull responseDataDic, PUBBaseResponseModel * _Nonnull mode) {
        if(!mode.success){
            [PUBTools showToast:mode.desc];
            return;
        }
        PUBContactModel *contactModel = [PUBContactModel yy_modelWithDictionary:mode.dataDic];
        if(successBlock){
            successBlock(contactModel);
        }
        
    } failure:^(NSError * _Nonnull error) {
        
        if(failtureBlock){
            failtureBlock();
        }
    } showLoading:YES];
    
}


- (void)getSaveEmergencyContactView:(UIView *)view dic:(NSDictionary *)dic finish:(void (^)(NSDictionary *dic))successBlock failture:(void (^)(void))failtureBlock
{
    
    [HttPPUBRequest postWithPath:saveEmergencyContact params:dic success:^(NSDictionary * _Nonnull responseDataDic, PUBBaseResponseModel * _Nonnull mode) {
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
