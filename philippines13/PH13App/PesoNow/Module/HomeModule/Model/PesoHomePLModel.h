//
//  PesoHomePLModel.h
//  PesoApp
//
//  Created by Jacky on 2024/9/11.
//

#import "PesoHomeBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface PesoHomePLItemModel : PesoHomeBaseModel
///产品id
@property(nonatomic, copy) NSString *regnthirteenNc;
///产品名称
@property(nonatomic, copy) NSString *moosthirteenyllabismNc;
///产品logo
@property(nonatomic, copy) NSString *sihothirteenuetteNc;
///产品金额
@property(nonatomic, copy) NSString *eahothirteenleNc;
///产品额度下面描述文字
@property(nonatomic, copy) NSString *cotethirteennderNc;
///申请按钮颜色
@property(nonatomic, copy) NSString *spffthirteenlicateNc;
///申请按钮文字
@property(nonatomic, copy) NSString *maanthirteenNc;
@end
@interface PesoHomePLModel : PesoHomeBaseModel
@property(nonatomic, copy) NSString *itlithirteenanizeNc;
@property(nonatomic, copy) NSArray <PesoHomePLItemModel*>*gugothirteenyleNc;
@end

NS_ASSUME_NONNULL_END
