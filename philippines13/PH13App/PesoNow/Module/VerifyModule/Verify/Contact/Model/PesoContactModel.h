//
//  PesoContactModel.h
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import "PesoBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface PesoContactRelationEnumModel : PesoBaseModel
///关系
@property(nonatomic, copy) NSString *uporthirteennNc;
///关系 id
@property(nonatomic, assign) NSInteger dempthirteenhasizeNc;
@end

@interface PesoContactRelationModel : PesoBaseModel
///名字
@property(nonatomic, copy) NSString *uporthirteennNc;
///号码
@property(nonatomic, copy) NSString *halothirteenwNc;
///关系
@property(nonatomic, assign) NSInteger bedithirteeneNc;
@end

@interface PesoContactItmeModel : PesoBaseModel
@property(nonatomic, copy) NSArray <PesoContactRelationEnumModel*>*bedithirteeneNc;
@property(nonatomic, strong) PesoContactRelationModel *koNcthirteen;
@property(nonatomic, copy) NSArray <NSDictionary*>*inhothirteenationNc;;
///标题
@property(nonatomic, copy) NSString *fldgthirteeneNc;
@end

@interface PesoContactModel : PesoBaseModel
@property(nonatomic, copy) NSArray <PesoContactItmeModel*>*ovrfthirteenraughtNc;
///倒计时
@property(nonatomic, assign) NSInteger paeothirteengrapherNc;
@end

NS_ASSUME_NONNULL_END
