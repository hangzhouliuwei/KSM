//
//  PTAuthenticationModel.h
//  PTApp
//
//  Created by 刘巍 on 2024/8/13.
//

#import "PTHomeKit.h"

NS_ASSUME_NONNULL_BEGIN
@interface PTAuthenticationItemModel : PTHomeBaseModel
///标题
@property(nonatomic, copy) NSString *fltendgeNc;
///是否已完成
@property(nonatomic, assign) BOOL frtenllyNc;
///logo
@property(nonatomic, copy) NSString *dotenableNc;
///跳转url
@property(nonatomic, copy) NSString *retenloomNc;
@end

@interface PTAuthenticationNextModel : PTHomeBaseModel
///下一步跳转
@property(nonatomic, copy) NSString *retenloomNc;
///标题
@property(nonatomic, copy) NSString *fltendgeNc;
@end

@interface PTAuthenticationLetenonishNcModel : PTHomeBaseModel
///产品id
@property(nonatomic, copy) NSString *retengnNc;
///订单号
@property(nonatomic, copy) NSString *cotenketNc;
@end

@interface PTAuthenticationModel : PTHomeBaseModel
@property(nonatomic, copy) NSArray <PTAuthenticationItemModel*>*attenesiaNc;
@property(nonatomic, strong) PTAuthenticationNextModel *hetenistopNc;
@property(nonatomic, strong) PTAuthenticationLetenonishNcModel *letenonishNc;
@end

NS_ASSUME_NONNULL_END
