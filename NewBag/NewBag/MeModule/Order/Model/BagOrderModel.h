//
//  BagOrderModel.h
//  NewBag
//
//  Created by Jacky on 2024/4/1.
//

#import "BagBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface BagOrderListModel : BagBaseModel
@property (nonatomic, copy) NSString *shapelinessF;//productName
@property (nonatomic, copy) NSString *mantidF;//productLogo
@property (nonatomic, assign) NSInteger bhaktaF;//orderStatus
@property(nonatomic, copy) NSString  *biolysisF;//productid

@property (nonatomic, copy) NSString *fuguF;//订单状态展示字段
@property (nonatomic, copy) NSString *demoticistF;//订单状态字体颜色
@property (nonatomic, copy) NSString *adzeF;//订单金额
@property (nonatomic, copy) NSString *stypticalF;//跳转地址
@property (nonatomic, copy) NSString *karakalpakF;//按钮文字展示，为空时不展示按钮
@property (nonatomic, copy) NSString *unbarkF;//按钮背景色
@property (nonatomic, copy) NSString *barrowmanF;//到期时间，为空不展示
@property (nonatomic, assign) NSInteger iberiaF;//是否显示认证详情页 0 不显示，1显示

@property (nonatomic, assign) CGFloat cellHeight;//cell高度

@end
@interface BagOrderModel : BagBaseModel
@property (nonatomic, copy) NSArray <BagOrderListModel *>*railageF;
@end

NS_ASSUME_NONNULL_END
