//
//  PTIdentifyModel.h
//  PTApp
//
//  Created by Jacky on 2024/8/21.
//

#import "PTBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class PTBasicRowModel;
@interface PTIdentifyListModel : PTBaseModel
@property(nonatomic, copy) NSString *rotenanizeNc;//name
@property(nonatomic, copy) NSString *ovtenrpunchNc;//图url
@property(nonatomic, assign) NSInteger cetenNc;//id

@property(nonatomic, copy) NSString *uptenornNc;
@property(nonatomic, assign) NSInteger ittenlianizeNc;

@end

@interface PTIdentifyDetailModel : PTBaseModel
//row
@property(nonatomic, copy) NSArray <PTBasicRowModel*>*xatenthosisNc;
//身份证类型
@property(nonatomic, copy) NSArray <PTIdentifyListModel*>*tutenbodrillNc;
///relation_id
@property(nonatomic, copy) NSString *datenrymanNc;
///图片路径
@property(nonatomic, copy) NSString *retenloomNc;
//银行id
@property(nonatomic, assign) NSInteger detencaleNc;
@property(nonatomic, strong) UIImage *idCardImage;
//返回的relation_id在"点击next保存该认证项信息"时上传
@property(nonatomic, copy) NSString *patenalympicsNc;
@end

@interface PTIdentifyModel : PTBaseModel
@property(nonatomic, strong) PTIdentifyDetailModel *catensabNc;
///倒计时
@property(nonatomic, assign) NSInteger pateneographerNc;
@end
NS_ASSUME_NONNULL_END
