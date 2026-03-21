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
@property (nonatomic, copy) NSString *intafourteenntNc;
@property (nonatomic, copy) NSString *kichfourteeniNc;
@end
/**banner**/
@interface BagHomeBannerItemModel : BagBaseModel
@property (nonatomic, copy) NSString *relofourteenomNc;//jump url
@property (nonatomic, copy) NSString *fldgfourteeneNc;// // 标题
@property (nonatomic, copy) NSString *arisfourteenNc;// img url
@end
/**banner**/
@interface BagHomeBannerModel : BagHomeModel
@property (nonatomic, copy) NSString *itlifourteenanizeNc;//type
@property (nonatomic, copy) NSArray <BagHomeBannerItemModel *>*gugofourteenyleNc;// banner array
@end

/**大卡**/
@interface BagHomeBigCardItemModel : BagHomeModel
@property (nonatomic, copy) NSString *regnfourteenNc;////产品id
@property (nonatomic, copy) NSString *moosfourteenyllabismNc;//产品名称
@property (nonatomic, copy) NSString *sihofourteenuetteNc;///产品logo
@property (nonatomic, copy) NSString *maanfourteenNc;//申请按钮文字
@property (nonatomic, copy) NSString *spfffourteenlicateNc;//申请按钮颜色
@property (nonatomic, copy) NSString *eahofourteenleNc;//产品额度
@property (nonatomic, copy) NSString *cotefourteennderNc;//产品名下面描述文字
@property (nonatomic, copy) NSString *urtefourteenrNc;//产品期限
@property (nonatomic, copy) NSString *paadfourteenosNc;//产品期限标题
@property (nonatomic, copy) NSString *fianfourteencialNc;///产品利率
@property (nonatomic, copy) NSString *fatifourteenshNc;//产品利率标题
@property (nonatomic, copy) NSString *seiafourteenutobiographicalNc;// 期限logo
@property (nonatomic, copy) NSString *codofourteengNc;//利率logo
@property (nonatomic, copy) NSString *brvafourteendoNc;//右上角角标
@property (nonatomic, assign) BOOL enpifourteenritNc;//是否显示进度条
@property (nonatomic, assign) BOOL pacafourteenrditisNc;//是否可点击
@end
/**大卡**/
@interface BagHomeBigCardModel : BagHomeModel
@property (nonatomic, copy) NSString *itlifourteenanizeNc;
@property (nonatomic, copy) NSArray <BagHomeBigCardItemModel *>*gugofourteenyleNc;//
@end


@interface BagHomeSmallCardModel : BagHomeBigCardModel
@property (nonatomic, copy) NSString *regnfourteenNc;////产品id
@property (nonatomic, copy) NSString *moosfourteenyllabismNc;//产品名称
@property (nonatomic, copy) NSString *sihofourteenuetteNc;///产品logo
@property (nonatomic, copy) NSString *maanfourteenNc;//申请按钮文字
@property (nonatomic, copy) NSString *spfffourteenlicateNc;//申请按钮颜色
@property (nonatomic, copy) NSString *eahofourteenleNc;//产品额度
@property (nonatomic, copy) NSString *cotefourteennderNc;//产品名下面描述文字
@property (nonatomic, copy) NSString *urtefourteenrNc;//产品期限
@property (nonatomic, copy) NSString *paadfourteenosNc;//产品期限标题
@property (nonatomic, copy) NSString *fianfourteencialNc;///产品利率
@property (nonatomic, copy) NSString *fatifourteenshNc;//产品利率标题
@property (nonatomic, copy) NSString *seiafourteenutobiographicalNc;// 期限logo
@property (nonatomic, copy) NSString *codofourteengNc;//利率logo
@property (nonatomic, copy) NSString *brvafourteendoNc;//右上角角标
@property (nonatomic, copy) NSString *ubmrrlF;//会员

@property (nonatomic, assign) BOOL enpifourteenritNc;//是否显示进度条
@property (nonatomic, assign) BOOL pacafourteenrditisNc;//是否可点击
@end
@interface BagHomeSmallModel : BagHomeModel
@property (nonatomic, copy) NSString *itlifourteenanizeNc;
@property (nonatomic, copy) NSArray <BagHomeSmallCardModel *>*gugofourteenyleNc;//
@end

/**还款**/

@interface BagHomeRepayItemModel : BagHomeModel
@property (nonatomic, copy) NSString *fldgfourteeneNc;////标题
@property (nonatomic, copy) NSString *upeafourteenrNc;// 标题背景色
@property (nonatomic, copy) NSString *frwnfourteenNc;//滚动内容
@property (nonatomic, copy) NSString *relofourteenomNc;//跳转链接
@end
@interface BagHomeRepayModel : BagHomeModel

@property (nonatomic, copy) NSString *itlifourteenanizeNc;//type

//@property (nonatomic, copy) NSString *fldgfourteeneNc;////标题
//@property (nonatomic, copy) NSString *upeafourteenrNc;// 标题背景色
//@property (nonatomic, copy) NSString *frwnfourteenNc;//滚动内容
//@property (nonatomic, copy) NSString *relofourteenomNc;//跳转链接
@end
/**走马灯**/
@interface BagHomeHorseItemModel : BagBaseModel
@property (nonatomic, copy) NSString *thckfourteenleafNc;////标题
@property (nonatomic, copy) NSString *epgyfourteennyNc;// 标题背景色
@end

@interface BagHomeHorseModel : BagHomeModel
@property (nonatomic, copy) NSString *itlifourteenanizeNc;
@property (nonatomic, copy) NSArray <BagHomeHorseItemModel *>*gugofourteenyleNc;// banner array
@end
/**代超列表**/
@interface BagHomeProductListItemModel : BagBaseModel
@property (nonatomic, copy) NSString *regnfourteenNc;////产品id
@property (nonatomic, copy) NSString *moosfourteenyllabismNc;// 产品名称
@property (nonatomic, copy) NSString *eahofourteenleNc;// 产品金额
@property (nonatomic, copy) NSArray *sefifourteenshNc;//tag
@property (nonatomic, copy) NSString *liotfourteenesNc;//产品描述
@property (nonatomic, copy) NSString *sihofourteenuetteNc;///产品logo
@property (nonatomic, copy) NSString *maanfourteenNc;// 申请按钮文字
@property (nonatomic, copy) NSString *spfffourteenlicateNc;//申请按钮颜色
@property (nonatomic, copy) NSString *cotefourteennderNc;// 产品额度下面描述文字
@property (nonatomic, copy) NSString *fatifourteenshNc;// 产品利率描述
@property (nonatomic, assign) NSInteger godofourteenlaNc;//产品状态
@property (nonatomic, assign) NSInteger magifourteennNc;//产品类型 1 API 2 H5
@property (nonatomic, copy) NSString *sesifourteentisationNc;// 产品利率
@property (nonatomic, copy) NSString *urtefourteenrNc;// 产品期限
@property (nonatomic, assign) NSInteger stthfourteenoscopyNc;//今天是否点击 0否 1是
@property (nonatomic, copy) NSString *brvafourteendoNc;// 右上角角标
@property (nonatomic, copy) NSString *noilfourteenladaNc;// 最大额度
@property (nonatomic, assign) BOOL enpifourteenritNc;//是否显示进度条
@property (nonatomic, assign) BOOL pacafourteenrditisNc;// 是否可点击
@property (nonatomic, assign) BOOL covifourteenctiveNc;//订单状态（174,180表示有待还款的订单。具体取值见EntryOrderEnum-进件单状态枚
@end
/**代超**/
@interface BagHomeProductListModel : BagHomeModel
@property (nonatomic, copy) NSString *itlifourteenanizeNc;//type
@property (nonatomic, copy) NSArray <BagHomeProductListItemModel *>*gugofourteenyleNc;// array
@end
/**品牌**/
@interface BagHomeBrandModel : BagHomeModel
@property (nonatomic, copy) NSString *itlifourteenanizeNc;//type
@end

@interface BagHomeApplyInfoModel : BagHomeModel
@property(nonatomic, copy) NSString *qunqfourteenuevalentNc;
@property(nonatomic, copy) NSString *armNfourteenc;
@property(nonatomic, copy) NSString *crngfourteeninglyNc;
@property(nonatomic, copy) NSString *relofourteenomNc;//跳转 url

@property(nonatomic, assign) NSInteger zicafourteenloyNc;// 0 不跳详情 1 跳转详情
@property(nonatomic, copy) NSString *miipfourteenigNc;//advance accessKey
@property(nonatomic, copy) NSString *ebNcfourteen;//advance  secretKey
@property(nonatomic, assign) NSInteger flcNfourteenc;//0 不上报 1上报通讯录数据 2 上报设备数据和通讯录数据
@property(nonatomic, assign) BOOL detrfourteenogyrateNc;//是否显示认证详情页 0 不显示，1显示
@end

@interface BagHomePopModel : BagBaseModel
///图片地地址
@property(nonatomic, copy) NSString *meulfourteenloblastomaNc;
///url
@property(nonatomic, copy) NSString *relofourteenomNc;
///buttonText
@property(nonatomic, copy) NSString *maanfourteenNc;
@end

NS_ASSUME_NONNULL_END
