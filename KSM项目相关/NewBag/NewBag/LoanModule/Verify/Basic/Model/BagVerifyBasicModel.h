//
//  BagVerifyBasicModel.h
//  NewBag
//
//  Created by Jacky on 2024/4/6.
//

#import "BagBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface BagBasicEnumModel : BagBaseModel
@property(nonatomic, copy) NSString *uporfourteennNc;
@property(nonatomic, assign) NSInteger itlifourteenanizeNc;
@end
@interface BagBasicRowModel : BagBaseModel
///键盘类型0 ：UIKeyboardTypeDefault 1：UIKeyboardTypeNumberPad
@property(nonatomic, copy) NSString *techfourteenedNc;//inputType
@property(nonatomic, copy) NSString *tapafourteenxNc;//optional
@property(nonatomic, copy) NSString *orinfourteenarilyNc;//subtitle
@property(nonatomic, copy) NSString *imeafourteensurabilityNc;//code
@property(nonatomic, copy) NSString *frllfourteenyNc;//status
///回选字段值
@property(nonatomic, copy) NSString *daryfourteenmanNc;//value
@property(nonatomic, copy) NSString *phtofourteentoxicityNc;//dateSelect
@property(nonatomic, assign) BOOL sufofourteennicNc;//enable
@property(nonatomic, copy) NSString *regnfourteenNc;//id
@property(nonatomic, copy) NSString *lebofourteenardNc;//cate
@property(nonatomic, copy) NSString *fldgfourteeneNc;//title
@property(nonatomic, copy) NSString *itlifourteenanizeNc;//type
@property(nonatomic, copy) NSArray <BagBasicEnumModel*>*tubofourteendrillNc;

@property(nonatomic, copy) NSString *cellType;
@property(nonatomic, assign) CGFloat cellHight;
@end

@interface BagBasicItmeModel : BagBaseModel
@property(nonatomic, assign) BOOL more;
@property(nonatomic, copy) NSString *fldgfourteeneNc;//title
@property(nonatomic, copy) NSString *sub_title;
@property(nonatomic, copy) NSArray <BagBasicRowModel*>*xathfourteenosisNc;
@property(nonatomic, assign) BOOL isSelected;
@end
@interface BagVerifyBasicModel : BagBaseModel
@property(nonatomic, copy) NSArray <BagBasicItmeModel*>*ovrffourteenraughtNc;
///倒计时
@property(nonatomic, assign) NSInteger paeofourteengrapherNc;
@end

NS_ASSUME_NONNULL_END
