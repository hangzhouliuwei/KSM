//
//  PTOrderModel.h
//  PTApp
//
//  Created by Jacky on 2024/8/28.
//

#import "PTBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTOrderListModel : PTBaseModel
@property (nonatomic, copy) NSString *motenosyllabismNc;//motenosyllabismNc
@property (nonatomic, copy) NSString *sitenhouetteNc;//productLogo
@property (nonatomic, assign) NSInteger cotenvictiveNc;//orderStatus
@property(nonatomic, copy) NSString  *mutenniumNc;//productid

@property (nonatomic, copy) NSString *latenarckianNc;//订单状态展示字段
@property (nonatomic, copy) NSString *imtenotenceNc;//订单状态字体颜色
@property (nonatomic, copy) NSString *istentacNc;//订单金额
@property (nonatomic, copy) NSString *aptenlicableNc;//跳转地址
@property (nonatomic, copy) NSString *matenanNc;//按钮文字展示，为空时不展示按钮
@property (nonatomic, copy) NSString *shtenkariNc;//按钮背景色
@property (nonatomic, copy) NSString *exteneriencelessNc;//到期时间，为空不展示
@property (nonatomic, assign) NSInteger detentrogyrateNc;//是否显示认证详情页 0 不显示，1显示

//@property (nonatomic, assign) CGFloat cellHeight;//cell高度

@end
@interface PTOrderModel : PTBaseModel
@property (nonatomic, copy) NSArray <PTOrderListModel *>*xatenthosisNc;
@end
NS_ASSUME_NONNULL_END
