//
//  PTHomeBannerModel.h
//  PTApp
//
//  Created by 刘巍 on 2024/8/1.
//

#import "PTHomeBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface PTHomeBannerItemModel : PTHomeBaseModel
///跳转地址
@property(nonatomic, copy) NSString *retenloomNc;
///图片地址
@property(nonatomic, copy) NSString *artenisNc;
@end
@interface PTHomeBannerModel : PTHomeBaseModel
///类型
@property(nonatomic, copy) NSString *ittenlianizeNc;
@property(nonatomic, copy) NSArray <PTHomeBannerItemModel*>*gutengoyleNc;
@end

NS_ASSUME_NONNULL_END
