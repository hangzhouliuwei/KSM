//
//  XTSelectCell.h
//  XTApp
//
//  Created by xia on 2024/9/8.
//

#import "XTCell.h"

NS_ASSUME_NONNULL_BEGIN
@class XTListModel;

@interface XTSelectCell : XTCell

@property(nonatomic,weak) XTListModel *model;
@property(nonatomic,copy) XTSelectBlock selectBlock;

-(void)becomeFirst;

@end

NS_ASSUME_NONNULL_END
