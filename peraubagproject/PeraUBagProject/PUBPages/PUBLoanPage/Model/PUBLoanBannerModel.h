//
//  PUBLoanBannerModel.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/23.
//

#import "PUBLoanBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface PUBLoanBannerItemModel : PUBLoanBaseModel
///跳转地址
@property(nonatomic, copy) NSString *lobsterman_eg;
/// 新图片地址
@property(nonatomic, copy) NSString *sequestrum_eg;
///排序
@property(nonatomic, assign) NSInteger shipshape_eg;
///fixedbanner
@property(nonatomic, copy) NSString *listenership_eg;
/// 新图片地址
@property(nonatomic, copy) NSString *sequestrumnew_eg;
@end
@interface PUBLoanBannerModel : PUBLoanBaseModel
@property(nonatomic, copy) NSString *vibronic_eg;
@property(nonatomic, copy) NSArray <PUBLoanBannerItemModel*>*obliterate_eg;

@end

NS_ASSUME_NONNULL_END
