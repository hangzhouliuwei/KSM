//
//  PTBasicVerifyModel.h
//  PTApp
//
//  Created by Jacky on 2024/8/21.
//

#import "PTBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTBasicEnumModel : PTBaseModel
@property(nonatomic, copy) NSString *uptenornNc;
@property(nonatomic, assign) NSInteger ittenlianizeNc;
@end
@interface PTBasicRowModel : PTBaseModel
///键盘类型0 ：UIKeyboardTypeDefault 1：UIKeyboardTypeNumberPad
@property(nonatomic, copy) NSString *tetenchedNc;//inputType
@property(nonatomic, copy) NSString *tatenpaxNc;//optional
@property(nonatomic, copy) NSString *orteninarilyNc;//subtitle
@property(nonatomic, copy) NSString *imteneasurabilityNc;//code
@property(nonatomic, copy) NSString *frtenllyNc;//status
///回选字段值
@property(nonatomic, copy) NSString *datenrymanNc;//value
@property(nonatomic, copy) NSString *phtentotoxicityNc;//dateSelect
@property(nonatomic, assign) BOOL sutenfonicNc;//enable
@property(nonatomic, copy) NSString *retengnNc;//id
@property(nonatomic, copy) NSString *letenboardNc;//cate
@property(nonatomic, copy) NSString *fltendgeNc;//title
//@property(nonatomic, copy) NSString *nortriptylineF;//type
@property(nonatomic, copy) NSArray <PTBasicEnumModel*>*tutenbodrillNc;

@property(nonatomic, copy) NSString *cellType;
@property(nonatomic, assign) CGFloat cellHight;
@end

@interface PTBasicItmeModel : PTBaseModel
@property(nonatomic, assign) BOOL more;
@property(nonatomic, copy) NSString *fltendgeNc;//title
@property(nonatomic, copy) NSString *sub_title;
@property(nonatomic, copy) NSArray <PTBasicRowModel*>*xatenthosisNc;
@property(nonatomic, assign) BOOL isSelected;
@end

@interface PTBasicVerifyModel : PTBaseModel
@property(nonatomic, copy) NSArray <PTBasicItmeModel*>*ovtenrfraughtNc;
///倒计时
@property(nonatomic, assign) NSInteger pateneographerNc;
@end

NS_ASSUME_NONNULL_END
