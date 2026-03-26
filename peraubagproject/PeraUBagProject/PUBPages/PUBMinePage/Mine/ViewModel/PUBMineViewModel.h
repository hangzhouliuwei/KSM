//
//  PUBMineViewModel.h
//  PeraUBagProject
//
//  Created by Jacky on 2024/1/15.
//

#import "PUBBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN
@class PUBMineModel;
@interface PUBMineViewModel : PUBBaseViewModel
- (void)getDataSuccess:(void(^)(PUBMineModel *data))successBlock fail:(void(^)(void))failBlock;
@end

NS_ASSUME_NONNULL_END
