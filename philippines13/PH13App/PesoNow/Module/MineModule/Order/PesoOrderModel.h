//
//  PesoOrderModel.h
//  PesoApp
//
//  Created by Jacky on 2024/9/18.
//

#import "PesoBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface PesoOrderListModel : PesoBaseModel
@property (nonatomic, copy) NSString *moosthirteenyllabismNc;//motenosyllabismNc
@property (nonatomic, copy) NSString *sihothirteenuetteNc;//productLogo
@property (nonatomic, assign) NSInteger covithirteenctiveNc;//orderStatus
@property(nonatomic, copy) NSString  *munithirteenumNc;//productid

@property (nonatomic, copy) NSString *laarthirteenckianNc;//订单状态展示字段
@property (nonatomic, copy) NSString *imotthirteenenceNc;//订单状态字体颜色
@property (nonatomic, copy) NSString *istathirteencNc;//订单金额
@property (nonatomic, copy) NSString *aplithirteencableNc;//跳转地址
@property (nonatomic, copy) NSString *maanthirteenNc;//按钮文字展示，为空时不展示按钮
@property (nonatomic, copy) NSString *shkathirteenriNc;//按钮背景色
@property (nonatomic, copy) NSString *exerthirteeniencelessNc;//到期时间，为空不展示
@property (nonatomic, assign) NSInteger detrthirteenogyrateNc;//是否显示认证详情页 0 不显示，1显示

@end
@interface PesoOrderModel : PesoBaseModel
@property (nonatomic, copy) NSArray <PesoOrderListModel *>*xaththirteenosisNc;

@end

NS_ASSUME_NONNULL_END
