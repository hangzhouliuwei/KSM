//
//  BagHomeModel.h
//  NewBag
//
//  Created by Jacky on 2024/3/26.
//

#import "BagBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BagHomeModel : BagBaseModel
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, copy) NSString *cellId;//type
@property (nonatomic, assign) NSInteger level;//type

@end

/**客服**/
@interface BagHomeCustomerModel : BagBaseModel
@property (nonatomic, copy) NSString *eskarF;
@property (nonatomic, copy) NSString *voyagerF;
@end
/**banner**/
@interface BagHomeBannerItemModel : BagBaseModel
@property (nonatomic, copy) NSString *nonvoterF;//jump url
@property (nonatomic, copy) NSString *mudslingerF;// // 标题
@property (nonatomic, copy) NSString *oldowanF;// img url
@end
/**banner**/
@interface BagHomeBannerModel : BagHomeModel
@property (nonatomic, copy) NSString *nortriptylineF;//type
@property (nonatomic, copy) NSArray <BagHomeBannerItemModel *>*hematopoiesisF;// banner array
@end

/**大卡**/
@interface BagHomeBigCardItemModel : BagHomeModel
@property (nonatomic, copy) NSString *franticF;////产品id
@property (nonatomic, copy) NSString *shapelinessF;//产品名称
@property (nonatomic, copy) NSString *mantidF;///产品logo
@property (nonatomic, copy) NSString *karakalpakF;//申请按钮文字
@property (nonatomic, copy) NSString *unlanguagedF;//申请按钮颜色
@property (nonatomic, copy) NSString *inconsolablyF;//产品额度
@property (nonatomic, copy) NSString *daysideF;//产品名下面描述文字
@property (nonatomic, copy) NSString *resinoidF;//产品期限
@property (nonatomic, copy) NSString *ruboutF;//产品期限标题
@property (nonatomic, copy) NSString *amobarbitalF;///产品利率
@property (nonatomic, copy) NSString *tenselyF;//产品利率标题
@property (nonatomic, copy) NSString *ginglymusF;// 期限logo
@property (nonatomic, copy) NSString *coollyF;//利率logo
@property (nonatomic, copy) NSString *ectodermF;//右上角角标
@property (nonatomic, assign) BOOL atomicsF;//是否显示进度条
@property (nonatomic, assign) BOOL fishwoodF;//是否可点击
@end
/**大卡**/
@interface BagHomeBigCardModel : BagHomeModel
@property (nonatomic, copy) NSString *nortriptylineF;
@property (nonatomic, copy) NSArray <BagHomeBigCardItemModel *>*hematopoiesisF;//
@end


@interface BagHomeSmallCardModel : BagHomeBigCardModel
@property (nonatomic, copy) NSString *franticF;////产品id
@property (nonatomic, copy) NSString *shapelinessF;//产品名称
@property (nonatomic, copy) NSString *mantidF;///产品logo
@property (nonatomic, copy) NSString *karakalpakF;//申请按钮文字
@property (nonatomic, copy) NSString *unlanguagedF;//申请按钮颜色
@property (nonatomic, copy) NSString *inconsolablyF;//产品额度
@property (nonatomic, copy) NSString *daysideF;//产品名下面描述文字
@property (nonatomic, copy) NSString *resinoidF;//产品期限
@property (nonatomic, copy) NSString *ruboutF;//产品期限标题
@property (nonatomic, copy) NSString *amobarbitalF;///产品利率
@property (nonatomic, copy) NSString *tenselyF;//产品利率标题
@property (nonatomic, copy) NSString *ginglymusF;// 期限logo
@property (nonatomic, copy) NSString *coollyF;//利率logo
@property (nonatomic, copy) NSString *ectodermF;//右上角角标
@property (nonatomic, copy) NSString *ubmrrlF;//会员

@property (nonatomic, assign) BOOL atomicsF;//是否显示进度条
@property (nonatomic, assign) BOOL fishwoodF;//是否可点击
@end
@interface BagHomeSmallModel : BagHomeModel
@property (nonatomic, copy) NSString *nortriptylineF;
@property (nonatomic, copy) NSArray <BagHomeSmallCardModel *>*hematopoiesisF;//
@end

/**还款**/

@interface BagHomeRepayItemModel : BagHomeModel
@property (nonatomic, copy) NSString *mudslingerF;////标题
@property (nonatomic, copy) NSString *endplateF;// 标题背景色
@property (nonatomic, copy) NSString *camoufleurF;//滚动内容
@property (nonatomic, copy) NSString *nonvoterF;//跳转链接
@end
@interface BagHomeRepayModel : BagHomeModel

@property (nonatomic, copy) NSString *nortriptylineF;//type

//@property (nonatomic, copy) NSString *mudslingerF;////标题
//@property (nonatomic, copy) NSString *endplateF;// 标题背景色
//@property (nonatomic, copy) NSString *camoufleurF;//滚动内容
//@property (nonatomic, copy) NSString *nonvoterF;//跳转链接
@end
/**走马灯**/
@interface BagHomeHorseItemModel : BagBaseModel
@property (nonatomic, copy) NSString *sluttishF;////标题
@property (nonatomic, copy) NSString *fairytaleF;// 标题背景色
@end

@interface BagHomeHorseModel : BagHomeModel
@property (nonatomic, copy) NSString *nortriptylineF;
@property (nonatomic, copy) NSArray <BagHomeHorseItemModel *>*hematopoiesisF;// banner array
@end
/**代超列表**/
@interface BagHomeProductListItemModel : BagBaseModel
@property (nonatomic, copy) NSString *franticF;////产品id
@property (nonatomic, copy) NSString *shapelinessF;// 产品名称
@property (nonatomic, copy) NSString *inconsolablyF;// 产品金额
@property (nonatomic, copy) NSArray *lexiconizeF;//tag
@property (nonatomic, copy) NSString *misrememberF;//产品描述
@property (nonatomic, copy) NSString *mantidF;///产品logo
@property (nonatomic, copy) NSString *karakalpakF;// 申请按钮文字
@property (nonatomic, copy) NSString *unlanguagedF;//申请按钮颜色
@property (nonatomic, copy) NSString *daysideF;// 产品额度下面描述文字
@property (nonatomic, copy) NSString *tenselyF;// 产品利率描述
@property (nonatomic, assign) NSInteger topsideF;//产品状态
@property (nonatomic, assign) NSInteger marianaoF;//产品类型 1 API 2 H5
@property (nonatomic, copy) NSString *notationF;// 产品利率
@property (nonatomic, copy) NSString *resinoidF;// 产品期限
@property (nonatomic, assign) NSInteger legworkF;//今天是否点击 0否 1是
@property (nonatomic, copy) NSString *ectodermF;// 右上角角标
@property (nonatomic, copy) NSString *denatureF;// 最大额度
@property (nonatomic, assign) BOOL atomicsF;//是否显示进度条
@property (nonatomic, assign) BOOL fishwoodF;// 是否可点击
@property (nonatomic, assign) BOOL bhaktaF;//订单状态（174,180表示有待还款的订单。具体取值见EntryOrderEnum-进件单状态枚
@end
/**代超**/
@interface BagHomeProductListModel : BagHomeModel
@property (nonatomic, copy) NSString *nortriptylineF;//type
@property (nonatomic, copy) NSArray <BagHomeProductListItemModel *>*hematopoiesisF;// array
@end
/**品牌**/
@interface BagHomeBrandModel : BagHomeModel
@property (nonatomic, copy) NSString *nortriptylineF;//type
@end

@interface BagHomeApplyInfoModel : BagHomeModel
@property(nonatomic, copy) NSString *downwashF;
@property(nonatomic, copy) NSString *emblemF;
@property(nonatomic, copy) NSString *eryngoF;
@property(nonatomic, copy) NSString *nonvoterF;//跳转 url

@property(nonatomic, assign) NSInteger failinglyF;// 0 不跳详情 1 跳转详情
@property(nonatomic, copy) NSString *homothetyF;//advance accessKey
@property(nonatomic, copy) NSString *testcrossF;//advance  secretKey
@property(nonatomic, assign) NSInteger pricerF;//0 不上报 1上报通讯录数据 2 上报设备数据和通讯录数据
@property(nonatomic, assign) BOOL iberiaF;//是否显示认证详情页 0 不显示，1显示
@end

@interface BagHomePopModel : BagBaseModel
///图片地地址
@property(nonatomic, copy) NSString *bishopF;
///url
@property(nonatomic, copy) NSString *nonvoterF;
///buttonText
@property(nonatomic, copy) NSString *karakalpakF;
@end

NS_ASSUME_NONNULL_END
