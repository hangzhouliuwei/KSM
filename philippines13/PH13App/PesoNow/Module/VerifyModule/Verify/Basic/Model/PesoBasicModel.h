//
//  PesoBasicModel.h
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import "PesoBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface PesoBasicEnumModel : PesoBaseModel
@property(nonatomic, copy) NSString *uporthirteennNc;
@property(nonatomic, assign) NSInteger itlithirteenanizeNc;
@end
@interface PesoBasicRowModel : PesoBaseModel
///键盘类型0 ：UIKeyboardTypeDefault 1：UIKeyboardTypeNumberPad
@property(nonatomic, copy) NSString *techthirteenedNc;//inputType
@property(nonatomic, copy) NSString *tapathirteenxNc;//optional
@property(nonatomic, copy) NSString *orinthirteenarilyNc;//subtitle
@property(nonatomic, copy) NSString *imeathirteensurabilityNc;//code
@property(nonatomic, copy) NSString *frllthirteenyNc;//status
///回选字段值
@property(nonatomic, copy) NSString *darythirteenmanNc;//value
@property(nonatomic, copy) NSString *phtothirteentoxicityNc;//dateSelect
@property(nonatomic, assign) BOOL sufothirteennicNc;//enable
@property(nonatomic, copy) NSString *regnthirteenNc;//id
@property(nonatomic, copy) NSString *lebothirteenardNc;//cate
@property(nonatomic, copy) NSString *fldgthirteeneNc;//title
@property(nonatomic, copy) NSArray <PesoBasicEnumModel*>*tubothirteendrillNc;

@property(nonatomic, copy) NSString *cellType;
@property(nonatomic, assign) CGFloat cellHight;
@end

@interface PesoBasicItmeModel : PesoBaseModel
@property(nonatomic, assign) BOOL more;
@property(nonatomic, copy) NSString *fldgthirteeneNc;//title
@property(nonatomic, copy) NSString *sub_title;
@property(nonatomic, copy) NSArray <PesoBasicRowModel*>*xaththirteenosisNc;
@property(nonatomic, assign) BOOL isSelected;
@end
@interface PesoBasicModel : PesoBaseModel
@property(nonatomic, copy) NSArray <PesoBasicItmeModel*>*ovrfthirteenraughtNc;
///倒计时
@property(nonatomic, assign) NSInteger paeothirteengrapherNc;
@end

NS_ASSUME_NONNULL_END
