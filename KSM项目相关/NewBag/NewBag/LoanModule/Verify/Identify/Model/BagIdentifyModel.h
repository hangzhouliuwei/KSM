//
//  BagIdentifyModel.h
//  NewBag
//
//  Created by Jacky on 2024/4/9.
//

#import "BagBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@class BagBasicRowModel;
@interface BagIdentifyListModel : BagBaseModel
@property(nonatomic, copy) NSString *roanfourteenizeNc;//name
@property(nonatomic, copy) NSString *ovrpfourteenunchNc;//图url
@property(nonatomic, assign) NSInteger ceNcfourteen;//id

@property(nonatomic, copy) NSString *uporfourteennNc;//roanfourteenizeNc
@property(nonatomic, assign) NSInteger itlifourteenanizeNc;//conniptionF
@end

@interface BagIdentifyDetailModel : BagBaseModel
//row
@property(nonatomic, copy) NSArray <BagBasicRowModel*>*xathfourteenosisNc;
//身份证类型
@property(nonatomic, copy) NSArray <BagIdentifyListModel*>*tubofourteendrillNc;
///relation_id
@property(nonatomic, copy) NSString *daryfourteenmanNc;
///图片路径
@property(nonatomic, copy) NSString *relofourteenomNc;
@property(nonatomic, assign) NSInteger decafourteenleNc;
@property(nonatomic, strong) UIImage *idCardImage;
//返回的relation_id在"点击next保存该认证项信息"时上传
@property(nonatomic, copy) NSString *paalfourteenympicsNc;
@end

@interface BagIdentifyModel : BagBaseModel
@property(nonatomic, strong) BagIdentifyDetailModel *casafourteenbNc;
///倒计时
@property(nonatomic, assign) NSInteger paeofourteengrapherNc;
@end

NS_ASSUME_NONNULL_END
