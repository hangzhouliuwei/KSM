//
//  PesoApplyModel.h
//  PesoApp
//
//  Created by Jacky on 2024/9/11.
//

#import "PesoBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PesoApplyModel : PesoBaseModel
///跳转地址
@property(nonatomic, copy) NSString *relothirteenomNc;
///0 不上报 1上报通讯录数据 2 上报设备数据和通讯录数据
@property(nonatomic, assign) NSInteger  flcNthirteenc;
///是否显示认证详情页 0 不显示，1显示
@property(nonatomic, assign) BOOL detrthirteenogyrateNc;
@end

NS_ASSUME_NONNULL_END
