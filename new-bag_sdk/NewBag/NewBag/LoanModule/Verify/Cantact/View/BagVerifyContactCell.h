//
//  BagVerifyContactCell.h
//  NewBag
//
//  Created by Jacky on 2024/4/8.
//

#import "BagBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface BagVerifyContactCell : BagBaseTableViewCell
- (void)updateUIWithModel:(id)model;
@property (nonatomic, copy) dispatch_block_t relationClick;
@property (nonatomic, copy) dispatch_block_t contactClick;

@end

NS_ASSUME_NONNULL_END
