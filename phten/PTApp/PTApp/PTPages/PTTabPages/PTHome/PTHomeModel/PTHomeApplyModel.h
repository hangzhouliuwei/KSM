//
//  PTHomeApplyModel.h
//  PTApp
//
//  Created by Jacky on 2024/8/23.
//

#import "PTBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTHomeApplyModel : PTBaseModel
///跳转地址
@property(nonatomic, copy) NSString *retenloomNc;
///0 不上报 1上报通讯录数据 2 上报设备数据和通讯录数据
@property(nonatomic, assign) NSInteger  fltencNc;
///是否显示认证详情页 0 不显示，1显示
@property(nonatomic, assign) BOOL detentrogyrateNc;
@end

NS_ASSUME_NONNULL_END
