//
//  PUBContactModel.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/4.
//

#import "PUBBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PUBContactFeatherstitchEgModel : PUBBaseModel
///名字
@property(nonatomic, copy) NSString *rhodo_eg;
///关系
@property(nonatomic, assign) NSInteger skeeter_eg;
@end

@interface PUBContactMgrimEgModel : PUBBaseModel
///名字
@property(nonatomic, copy) NSString *rhodo_eg;
///号码
@property(nonatomic, copy) NSString *xat_eg;
///关系
@property(nonatomic, assign) NSInteger featherstitch_eg;
@end

@interface PUBContactItmeModel : PUBBaseModel
@property(nonatomic, copy) NSArray <PUBContactFeatherstitchEgModel*>*featherstitch_eg;
@property(nonatomic, strong) PUBContactMgrimEgModel *megrim_eg;
@property(nonatomic, copy) NSArray <NSDictionary*>*endothelium_eg;;
///标题
@property(nonatomic, copy) NSString *neanderthaloid_eg;
@end

@interface PUBContactModel : PUBBaseModel

@property(nonatomic, copy) NSArray <PUBContactItmeModel*>*draffy_eg;
///倒计时
@property(nonatomic, assign) NSInteger sdlkfjl_eg;

@end

NS_ASSUME_NONNULL_END
