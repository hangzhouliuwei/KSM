//
//  BagVerifyBasicModel.h
//  NewBag
//
//  Created by Jacky on 2024/4/6.
//

#import "BagBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface BagBasicEnumModel : BagBaseModel
@property(nonatomic, copy) NSString *antineoplastonF;
@property(nonatomic, assign) NSInteger nortriptylineF;
@end
@interface BagBasicRowModel : BagBaseModel
///键盘类型0 ：UIKeyboardTypeDefault 1：UIKeyboardTypeNumberPad
@property(nonatomic, copy) NSString *sothisF;//inputType
@property(nonatomic, copy) NSString *escarpmentF;//optional
@property(nonatomic, copy) NSString *stupidF;//subtitle
@property(nonatomic, copy) NSString *taxidermyF;//code
@property(nonatomic, copy) NSString *thermionicF;//status
///回选字段值
@property(nonatomic, copy) NSString *lorrieF;//value
@property(nonatomic, copy) NSString *tweeddaleF;//dateSelect
@property(nonatomic, assign) BOOL centaurusF;//enable
@property(nonatomic, copy) NSString *franticF;//id
@property(nonatomic, copy) NSString *javaneseF;//cate
@property(nonatomic, copy) NSString *mudslingerF;//title
@property(nonatomic, copy) NSString *nortriptylineF;//type
@property(nonatomic, copy) NSArray <BagBasicEnumModel*>*maquisF;

@property(nonatomic, copy) NSString *cellType;
@property(nonatomic, assign) CGFloat cellHight;
@end

@interface BagBasicItmeModel : BagBaseModel
@property(nonatomic, assign) BOOL more;
@property(nonatomic, copy) NSString *mudslingerF;//title
@property(nonatomic, copy) NSString *sub_title;
@property(nonatomic, copy) NSArray <BagBasicRowModel*>*railageF;
@property(nonatomic, assign) BOOL isSelected;
@end
@interface BagVerifyBasicModel : BagBaseModel
@property(nonatomic, copy) NSArray <BagBasicItmeModel*>*heterogenistF;
///倒计时
@property(nonatomic, assign) NSInteger analectaF;
@end

NS_ASSUME_NONNULL_END
