//
//  BagMeOverdueCell.h
//  NewBag
//
//  Created by Jacky on 2024/3/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BagMeOverdueCell : UITableViewCell
- (void)updateUIWithProductName:(NSString *)name logoUrl:(NSString *)logo amount:(NSString *)amount repayDate:(NSString *)repayDate;
@property (nonatomic, copy) dispatch_block_t overdueClickBlock;
@end

NS_ASSUME_NONNULL_END
