//
//  PesoDetailModel.h
//  PesoApp
//
//  Created by Jacky on 2024/9/12.
//

#import "PesoBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface PesoVerifyListModel : PesoBaseModel
///标题
@property(nonatomic, copy) NSString *fldgthirteeneNc;
///是否已完成
@property(nonatomic, assign) BOOL frllthirteenyNc;
///logo
@property(nonatomic, copy) NSString *doabthirteenleNc;
///跳转url
@property(nonatomic, copy) NSString *relothirteenomNc;
@end
@interface PesoVerifyNextModel : PesoBaseModel
///下一步跳转
@property(nonatomic, copy) NSString *relothirteenomNc;
///标题
@property(nonatomic, copy) NSString *fldgthirteeneNc;
@end
@interface PesoProductInfoModel : PesoBaseModel
///产品id
@property(nonatomic, copy) NSString *regnthirteenNc;
///订单号
@property(nonatomic, copy) NSString *cokethirteentNc;
@end

@interface PesoDetailModel : PesoBaseModel
@property(nonatomic, copy) NSArray <PesoVerifyListModel*>*atesthirteeniaNc;
@property(nonatomic, strong) PesoVerifyNextModel *heisthirteentopNc;
@property(nonatomic, strong) PesoProductInfoModel *leonthirteenishNc;
@end

NS_ASSUME_NONNULL_END
