//
//  PUBBasicViewModel.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/29.
//

#import "PUBBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN
@class PUBBasicModel;
@interface PUBBasicViewModel : PUBBaseViewModel

///初始化基础信息
- (void)getbasicInfoView:(UIView *)view
                       dic:(NSDictionary *)dic
                      finish:(void (^)(PUBBasicModel *basicModel))successBlock
                    failture:(void (^)(void))failtureBlock;


///保存基础信息
- (void)getSaveBasicInfoView:(UIView *)view
                       dic:(NSDictionary *)dic
                      finish:(void (^)(NSDictionary *dic))successBlock
                    failture:(void (^)(void))failtureBlock;
@end

NS_ASSUME_NONNULL_END
