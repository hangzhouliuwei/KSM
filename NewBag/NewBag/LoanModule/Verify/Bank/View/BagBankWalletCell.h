//
//  BagBankWalletCell.h
//  NewBag
//
//  Created by Jacky on 2024/4/9.
//

#import "BagBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
@class BagBankItemModel;
@interface BagBankWalletCell : BagBaseTableViewCell
- (void)updateUIWithModel:(BagBankItemModel *)model isSelect:(BOOL)isSelect;

@end

NS_ASSUME_NONNULL_END
