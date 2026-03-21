//
//  XTWalletCell.h
//  XTApp
//
//  Created by xia on 2024/9/11.
//

#import "XTCell.h"

NS_ASSUME_NONNULL_BEGIN
@class XTNoteModel;
@interface XTWalletCell : XTCell
@property(nonatomic,weak) XTNoteModel *model;
@property(nonatomic) BOOL isSelect;
@end

NS_ASSUME_NONNULL_END
