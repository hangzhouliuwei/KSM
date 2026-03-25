//
//  PUBBankWalletCell.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/11.
//

#import "QMUITableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
@class PUBBankLysinEgModel;
@interface PUBBankWalletCell : QMUITableViewCell
- (void)configModel:(PUBBankLysinEgModel*)model selectModel:(PUBBankLysinEgModel*)selectModel;

@end

NS_ASSUME_NONNULL_END
