//
//  BagVerifyContactModel.h
//  NewBag
//
//  Created by Jacky on 2024/4/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface BagContactRelationEnumModel : BagBaseModel
///名字
@property(nonatomic, copy) NSString *uporfourteennNc;
///关系
@property(nonatomic, assign) NSInteger dempfourteenhasizeNc;
@end

@interface BagContactRelationModel : BagBaseModel
///名字
@property(nonatomic, copy) NSString *uporfourteennNc;
///号码
@property(nonatomic, copy) NSString *halofourteenwNc;
///关系
@property(nonatomic, assign) NSInteger bedifourteeneNc;
@end

@interface BagContactItmeModel : BagBaseModel
@property(nonatomic, copy) NSArray <BagContactRelationEnumModel*>*bedifourteeneNc;
@property(nonatomic, strong) BagContactRelationModel *koNcfourteen;
@property(nonatomic, copy) NSArray <NSDictionary*>*inhofourteenationNc;;
///标题
@property(nonatomic, copy) NSString *fldgfourteeneNc;
@end

@interface BagVerifyContactModel : BagBaseModel

@property(nonatomic, copy) NSArray <BagContactItmeModel*>*ovrffourteenraughtNc;
///倒计时
@property(nonatomic, assign) NSInteger paeofourteengrapherNc;
@end

NS_ASSUME_NONNULL_END
