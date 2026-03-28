//
//  BagHomeProductListCell.h
//  NewBag
//
//  Created by Jacky on 2024/3/27.
//

#import <UIKit/UIKit.h>
@class BagHomeProductListItemModel;
NS_ASSUME_NONNULL_BEGIN

@interface BagHomeProductListCell : UITableViewCell
- (void)updateUIWithModel:(BagHomeProductListItemModel *)model;

@property (nonatomic, copy) dispatch_block_t applyClickBlock;

@end

NS_ASSUME_NONNULL_END
