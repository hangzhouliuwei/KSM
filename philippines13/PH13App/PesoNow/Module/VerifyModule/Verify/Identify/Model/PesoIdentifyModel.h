//
//  PesoIdentifyModel.h
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import "PesoBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@class PesoBasicRowModel;
@interface PesoIdentifyListModel : PesoBaseModel
@property(nonatomic, copy) NSString *roanthirteenizeNc;//name
@property(nonatomic, copy) NSString *ovrpthirteenunchNc;//图url
@property(nonatomic, assign) NSInteger ceNcthirteen;//id

@property(nonatomic, copy) NSString *uporthirteennNc;
@property(nonatomic, assign) NSInteger itlithirteenanizeNc;
@end

@interface PesoIdentifyDetailModel : PesoBaseModel
//row
@property(nonatomic, copy) NSArray <PesoBasicRowModel*>*xaththirteenosisNc;
//身份证类型
@property(nonatomic, copy) NSArray <PesoIdentifyListModel*>*tubothirteendrillNc;
///relation_id
@property(nonatomic, copy) NSString *darythirteenmanNc;
///图片路径
@property(nonatomic, copy) NSString *relothirteenomNc;
//银行id
@property(nonatomic, assign) NSInteger decathirteenleNc;
@property(nonatomic, strong) UIImage *idCardImage;
//返回的relation_id在"点击next保存该认证项信息"时上传
@property(nonatomic, copy) NSString *paalthirteenympicsNc;
@end

@interface PesoIdentifyModel : PesoBaseModel
@property(nonatomic, strong) PesoIdentifyDetailModel *casathirteenbNc;
///倒计时
@property(nonatomic, assign) NSInteger paeothirteengrapherNc;
@end

NS_ASSUME_NONNULL_END
