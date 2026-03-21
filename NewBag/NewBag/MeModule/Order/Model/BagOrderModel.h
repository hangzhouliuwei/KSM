//
//  BagOrderModel.h
//  NewBag
//
//  Created by Jacky on 2024/4/1.
//

#import "BagBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface BagOrderListModel : BagBaseModel
@property (nonatomic, copy) NSString *moosfourteenyllabismNc;//productName
@property (nonatomic, copy) NSString *sihofourteenuetteNc;//productLogo
@property (nonatomic, assign) NSInteger covifourteenctiveNc;//orderStatus
@property(nonatomic, copy) NSString  *munifourteenumNc;//productid

@property (nonatomic, copy) NSString *laarfourteenckianNc;//订单状态展示字段
@property (nonatomic, copy) NSString *imotfourteenenceNc;//订单状态字体颜色
@property (nonatomic, copy) NSString *istafourteencNc;//订单金额
@property (nonatomic, copy) NSString *aplifourteencableNc;//跳转地址
@property (nonatomic, copy) NSString *maanfourteenNc;//按钮文字展示，为空时不展示按钮
@property (nonatomic, copy) NSString *shkafourteenriNc;//按钮背景色
@property (nonatomic, copy) NSString *exerfourteeniencelessNc;//到期时间，为空不展示
@property (nonatomic, assign) NSInteger detrfourteenogyrateNc;//是否显示认证详情页 0 不显示，1显示

@property (nonatomic, assign) CGFloat cellHeight;//cell高度

@end
@interface BagOrderModel : BagBaseModel
@property (nonatomic, copy) NSArray <BagOrderListModel *>*xathfourteenosisNc;
@end

NS_ASSUME_NONNULL_END
