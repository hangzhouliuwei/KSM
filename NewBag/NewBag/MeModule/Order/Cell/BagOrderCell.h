//
//  BagOrderCell.h
//  NewBag
//
//  Created by Jacky on 2024/3/31.
//

#import <UIKit/UIKit.h>
@class BagOrderListModel;
NS_ASSUME_NONNULL_BEGIN

@interface BagOrderCell : UITableViewCell
- (void)updateUIWithModel:(BagOrderListModel *)model;
@property (nonatomic, copy) dispatch_block_t refundBtnClickBlock;
@end

NS_ASSUME_NONNULL_END
