//
//  XTPhotoCell.h
//  XTApp
//
//  Created by xia on 2024/9/10.
//

#import "XTCell.h"

NS_ASSUME_NONNULL_BEGIN
@class XTPhotoModel;
@interface XTPhotoCell : XTCell

@property(nonatomic,weak) XTPhotoModel *model;

@property(nonatomic,copy) XTSelectBlock block;
@property(nonatomic,copy) XTBlock photoBlock;

@end

NS_ASSUME_NONNULL_END
