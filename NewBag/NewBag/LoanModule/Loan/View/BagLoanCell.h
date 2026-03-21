//
//  BagLoanCell.h
//  NewBag
//
//  Created by Jacky on 2024/4/5.
//

#import <UIKit/UIKit.h>
@class BagVerifyItemModel;
NS_ASSUME_NONNULL_BEGIN

@interface BagLoanCell : UITableViewCell
- (void)updateUIWithModel:(BagVerifyItemModel *)model isLast:(BOOL)isLast;
@end

NS_ASSUME_NONNULL_END
