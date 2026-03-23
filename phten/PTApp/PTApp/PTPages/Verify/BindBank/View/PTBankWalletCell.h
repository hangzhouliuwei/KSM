//
//  PTBankWalletCell.h
//  PTApp
//
//  Created by Jacky on 2024/8/26.
//

#import <UIKit/UIKit.h>
#import "PTBaseTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN
@class PTBankItemModel;
@interface PTBankWalletCell : PTBaseTableViewCell
- (void)updateUIWithModel:(PTBankItemModel *)model isSelect:(BOOL)isSelect;
@end



NS_ASSUME_NONNULL_END
