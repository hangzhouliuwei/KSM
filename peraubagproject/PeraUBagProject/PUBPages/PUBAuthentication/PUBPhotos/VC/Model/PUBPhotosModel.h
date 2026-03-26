//
//  PUBPhotosModel.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/5.
//

#import "PUBBaseModel.h"
#import "PUBBasicModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface PUBPhotosHorrificEgModel : PUBBaseModel
@property(nonatomic, copy) NSString *financial_eg;
@property(nonatomic, assign) NSInteger grocer_eg;
@property(nonatomic, copy) NSString *trebly_eg;
@end

@interface PUBPhotosDesideratumEgModel : PUBBaseModel
@property(nonatomic, copy) NSArray <PUBBasicSomesuchEgModel*>*somesuch_eg;
@property(nonatomic, copy) NSArray <PUBPhotosHorrificEgModel*>*horrific_eg;
///relation_id
@property(nonatomic, copy) NSString *oversail_eg;
///图片路径
@property(nonatomic, copy) NSString *lobsterman_eg;
@property(nonatomic, assign) NSInteger magnetohydrodynamic_eg;
@property(nonatomic, strong) UIImage *idCardImage;
///回显身份认证KEY
@property(nonatomic, copy) NSString *oerlikon_eg;
@end

@interface PUBPhotosModel : PUBBaseModel
@property(nonatomic, strong) PUBPhotosDesideratumEgModel *desideratum_eg;
///倒计时
@property(nonatomic, assign) NSInteger sdlkfjl_eg;

@end

NS_ASSUME_NONNULL_END
