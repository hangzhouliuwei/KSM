//
//  PTContactVerifyModel.h
//  PTApp
//
//  Created by Jacky on 2024/8/21.
//

#import "PTBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTContactRelationEnumModel : PTBaseModel
///名字
@property(nonatomic, copy) NSString *uptenornNc;
///关系
@property(nonatomic, assign) NSInteger detenmphasizeNc;
@end

@interface PTContactRelationModel : PTBaseModel
///名字
@property(nonatomic, copy) NSString *uptenornNc;
///号码
@property(nonatomic, copy) NSString *hatenlowNc;
///关系
@property(nonatomic, assign) NSInteger betendieNc;
@end

@interface PTContactItmeModel : PTBaseModel
@property(nonatomic, copy) NSArray <PTContactRelationEnumModel*>*betendieNc;
@property(nonatomic, strong) PTContactRelationModel *kotenNc;
@property(nonatomic, copy) NSArray <NSDictionary*>*intenhoationNc;;
///标题
@property(nonatomic, copy) NSString *fltendgeNc;
@end

@interface PTContactVerifyModel : PTBaseModel

@property(nonatomic, copy) NSArray <PTContactItmeModel*>*ovtenrfraughtNc;
///倒计时
@property(nonatomic, assign) NSInteger pateneographerNc;
@end

NS_ASSUME_NONNULL_END
