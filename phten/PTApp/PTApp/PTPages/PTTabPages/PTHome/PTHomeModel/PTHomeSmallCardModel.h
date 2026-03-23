//
//  PTHomeSmallCardModel.h
//  PTApp
//
//  Created by 刘巍 on 2024/8/3.
//

#import "PTHomeBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface PTHomeSmallCardItemModel : PTHomeBaseModel
///产品id
@property(nonatomic, copy) NSString *retengnNc;
///产品名称
@property(nonatomic, copy) NSString *motenosyllabismNc;
///产品logo
@property(nonatomic, copy) NSString *sitenhouetteNc;
///申请按钮文字
@property(nonatomic, copy) NSString *matenanNc;
///申请按钮颜色
@property(nonatomic, copy) NSString *sptenfflicateNc;
///产品额度
@property(nonatomic, copy) NSString *eatenholeNc;
///产品名下面描述文字
@property(nonatomic, copy) NSString *cotentenderNc;
///产品期限
@property(nonatomic, copy) NSString *urtenterNc;
///产品期限标题
@property(nonatomic, copy) NSString *patenadosNc;
///产品利率
@property(nonatomic, copy) NSString *fitenancialNc;
///产品利率标题
@property(nonatomic, copy) NSString *fatentishNc;
///期限logo
@property(nonatomic, copy) NSString *seteniautobiographicalNc;
///利率logo#157B60
@property(nonatomic, copy) NSString *cotendogNc;
///会员图标
@property(nonatomic, copy) NSString *detenensiveNc;
@end

@interface PTHomeSmallCardModel : PTHomeBaseModel
@property(nonatomic, copy) NSString *ittenlianizeNc;
@property(nonatomic, copy) NSArray <PTHomeSmallCardItemModel*>*gutengoyleNc;
@end

NS_ASSUME_NONNULL_END
