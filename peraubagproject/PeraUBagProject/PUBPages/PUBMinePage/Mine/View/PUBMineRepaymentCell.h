//
//  PUBMineRepaymentCell.h
//  PeraUBagProject
//
//  Created by Jacky on 2024/1/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PUBMineModel;
@interface PUBMineRepaymentCell : UITableViewCell

@property (nonatomic, copy) dispatch_block_t goRepayBlock;

- (void)updateUIWithProductName:(NSString *)name logo:(NSString *)logo amount:(NSString *)amount repay_date:(NSString *)repay_date;
@end

NS_ASSUME_NONNULL_END
