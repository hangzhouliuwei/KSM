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
@property(nonatomic, copy) NSString *monitorshipF;//name
@property(nonatomic, copy) NSString *kraterF;//图url
@property(nonatomic, assign) NSInteger conniptionF;//id

@property(nonatomic, copy) NSString *antineoplastonF;//monitorshipF
@property(nonatomic, assign) NSInteger nortriptylineF;//conniptionF
@end

@interface BagIdentifyDetailModel : BagBaseModel
//row
@property(nonatomic, copy) NSArray <BagBasicRowModel*>*railageF;
//身份证类型
@property(nonatomic, copy) NSArray <BagIdentifyListModel*>*maquisF;
///relation_id
@property(nonatomic, copy) NSString *lorrieF;
///图片路径
@property(nonatomic, copy) NSString *nonvoterF;
@property(nonatomic, assign) NSInteger incenterF;
@property(nonatomic, strong) UIImage *idCardImage;
//返回的relation_id在"点击next保存该认证项信息"时上传
@property(nonatomic, copy) NSString *keennessF;
@end

@interface BagIdentifyModel : BagBaseModel
@property(nonatomic, strong) BagIdentifyDetailModel *holeproofF;
///倒计时
@property(nonatomic, assign) NSInteger analectaF;
@end

NS_ASSUME_NONNULL_END
