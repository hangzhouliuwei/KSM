//
//  PTHomeProductModel.h
//  PTApp
//
//  Created by 刘巍 on 2024/8/3.
//

#import "PTHomeBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface PTHomeProductListModel : PTHomeBaseModel
///产品id
@property(nonatomic, copy) NSString *retengnNc;
///产品名称
@property(nonatomic, copy) NSString *motenosyllabismNc;
///产品logo
@property(nonatomic, copy) NSString *sitenhouetteNc;
///产品金额
@property(nonatomic, copy) NSString *eatenholeNc;
///产品额度下面描述文字
@property(nonatomic, copy) NSString *cotentenderNc;
///申请按钮颜色
@property(nonatomic, copy) NSString *sptenfflicateNc;
///申请按钮文字
@property(nonatomic, copy) NSString *matenanNc;
@end


@interface PTHomeProductModel : PTHomeBaseModel
@property(nonatomic, copy) NSString *ittenlianizeNc;
@property(nonatomic, copy) NSArray <PTHomeProductListModel*>*gutengoyleNc;
@end

NS_ASSUME_NONNULL_END
