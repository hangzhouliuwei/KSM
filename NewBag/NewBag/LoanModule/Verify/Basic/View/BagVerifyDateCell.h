//
//  BagVerifyDateCell.h
//  NewBag
//
//  Created by Jacky on 2024/4/7.
//

#import "BagBaseTableViewCell.h"
@class BagBasicRowModel;
NS_ASSUME_NONNULL_BEGIN

@interface BagVerifyDateCell : BagBaseTableViewCell
- (void)updateUIWithModel:(BagBasicRowModel *)model;
- (void)click;
@property (nonatomic, copy) dispatch_block_t clickBlock;
@end

NS_ASSUME_NONNULL_END
