//
//  BagIdentifyDateCell.h
//  NewBag
//
//  Created by Jacky on 2024/4/10.
//

#import "BagBaseTableViewCell.h"
@class BagBasicRowModel;
NS_ASSUME_NONNULL_BEGIN

@interface BagIdentifyDateCell : BagBaseTableViewCell
- (void)updateUIWithModel:(BagBasicRowModel *)model;
- (void)click;
@property (nonatomic, copy) dispatch_block_t clickBlock;
@end

NS_ASSUME_NONNULL_END
