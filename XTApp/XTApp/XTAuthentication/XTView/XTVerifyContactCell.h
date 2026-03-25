//
//  XTVerifyContactCell.h
//  XTApp
//
//  Created by xia on 2024/9/9.
//

#import "XTCell.h"

NS_ASSUME_NONNULL_BEGIN
@class XTContactItemModel;
@interface XTVerifyContactCell : XTCell
@property(nonatomic,weak) XTContactItemModel *model;
@property(nonatomic,copy) XTSelectBlock block;
@property(nonatomic,copy) XTSelectBlock contactBlock;
@end

NS_ASSUME_NONNULL_END
