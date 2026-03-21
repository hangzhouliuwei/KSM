//
//  BagVerifyBasicEnumCell.h
//  NewBag
//
//  Created by Jacky on 2024/4/6.
//

#import <UIKit/UIKit.h>
@class BagBasicRowModel;
NS_ASSUME_NONNULL_BEGIN

@interface BagVerifyBasicEnumCell : BagBaseTableViewCell
- (void)updateUIWithModel:(BagBasicRowModel *)model;
- (void)click;
@property (nonatomic, copy) dispatch_block_t clickBlock;
@end

NS_ASSUME_NONNULL_END
