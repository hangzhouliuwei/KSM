//
//  XTOrderCell.h
//  XTApp
//
//  Created by xia on 2024/9/13.
//

#import "XTCell.h"

NS_ASSUME_NONNULL_BEGIN
@class XTOrderModel;
@interface XTOrderCell : XTCell

@property(nonatomic,weak) XTOrderModel *model;

@end

NS_ASSUME_NONNULL_END
