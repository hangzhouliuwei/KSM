//
//  BagHomeBigCardTableViewCell.h
//  NewBag
//
//  Created by Jacky on 2024/3/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class BagHomeBigCardItemModel;
@interface BagHomeBigCardTableViewCell : UITableViewCell

@property (nonatomic, copy) dispatch_block_t applyClickBlock;

- (void)updateUIWithModel:(BagHomeBigCardItemModel *)model;

@end

NS_ASSUME_NONNULL_END
