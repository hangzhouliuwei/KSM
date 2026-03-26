//
//  PUBContactViewModel.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/4.
//

#import "PUBBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN
@class PUBContactModel;
@interface PUBContactViewModel : PUBBaseViewModel
///紧急联系人初始化接口
- (void)getContactView:(UIView *)view dic:(NSDictionary *)dic
                finish:(void (^)(PUBContactModel *contactModel))successBlock
              failture:(void (^)(void))failtureBlock;

///保存紧急联系人数据 (第二项)
- (void)getSaveEmergencyContactView:(UIView *)view dic:(NSDictionary *)dic
                finish:(void (^)(NSDictionary *dic))successBlock
              failture:(void (^)(void))failtureBlock;

@end

NS_ASSUME_NONNULL_END
