//
//  PesoBankWalletCell.h
//  PesoApp
//
//  Created by Jacky on 2024/9/16.
//

#import "PesoBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
@class PesoBankItemModel;
@interface PesoBankWalletCell : PesoBaseTableViewCell
- (void)updateUIWithModel:(PesoBankItemModel *)model isSelect:(BOOL)isSelect;
@end

NS_ASSUME_NONNULL_END
