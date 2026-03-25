//
//  PTMineModel.h
//  PTApp
//
//  Created by 刘巍 on 2024/8/12.
//

#import "PTHomeBaseModel.h"
#import "PTMineNcModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface PTMineItemModel : PTHomeBaseModel
///标题
@property(nonatomic, copy) NSString *fltendgeNc;
///图标
@property(nonatomic, copy) NSString *ietenNc;
///跳转地址
@property(nonatomic, copy) NSString *retenloomNc;
@end

@interface PTMineModel : PTHomeBaseModel
///会员图标
@property(nonatomic, copy) NSString *detenensiveNc;
@property(nonatomic, copy) NSArray <PTMineItemModel*>*getenticNc;
///逾期提醒
@property(nonatomic, strong) PTMineNcModel *untenqualizeNc;
@end

NS_ASSUME_NONNULL_END
