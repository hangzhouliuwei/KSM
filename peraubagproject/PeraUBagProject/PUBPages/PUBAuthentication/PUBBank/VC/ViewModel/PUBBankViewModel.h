//
//  PUBBankViewModel.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/10.
//

#import "PUBBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN
@class PUBBankModel;
@interface PUBBankViewModel : PUBBaseViewModel
///银行卡初始化接口（第五项）
- (void)getBindCardInitView:(UIView *)view dic:(NSDictionary *)dic
                finish:(void (^)(PUBBankModel *bankModel))successBlock
              failture:(void (^)(void))failtureBlock;

///保存银行卡信息（第五项）
- (void)getSaveBindCardView:(UIView *)view dic:(NSDictionary *)dic
                finish:(void (^)(NSDictionary *dic))successBlock
              failture:(void (^)(void))failtureBlock;
@end

NS_ASSUME_NONNULL_END
