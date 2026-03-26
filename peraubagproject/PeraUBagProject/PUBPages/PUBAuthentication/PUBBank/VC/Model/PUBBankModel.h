//
//  PUBBankModel.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/10.
//

#import "PUBBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface PUBBankMegrimEg : PUBBaseModel
@property(nonatomic, assign) NSInteger jeanne_eg;
@property(nonatomic, copy) NSString *rbds_eg;
@end
@interface PUBBankLysinEgModel : PUBBaseModel
@property(nonatomic, copy) NSString *rhodo_eg;
@property(nonatomic, copy) NSString *unbuild_eg;
@property(nonatomic, assign) NSInteger quilting_eg;
@end
@interface PUBBankValuedEgModel : PUBBaseModel
@property(nonatomic, copy) NSArray <PUBBankLysinEgModel*>*lysine_eg;
@property(nonatomic, strong) PUBBankMegrimEg *megrim_eg;
@end

@interface PUBBankWiltEgModel : PUBBaseModel
@property(nonatomic, copy) NSArray <PUBBankLysinEgModel*>*lysine_eg;
@property(nonatomic, strong) PUBBankMegrimEg *megrim_eg;
@end

@interface PUBBankModel : PUBBaseModel
@property(nonatomic, assign) NSInteger sdlkfjl_eg;
@property(nonatomic, strong) PUBBankValuedEgModel *valued_eg;
@property(nonatomic, strong) PUBBankWiltEgModel *wilt_eg;
@end

NS_ASSUME_NONNULL_END
