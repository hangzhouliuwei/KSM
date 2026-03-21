//
//  BagVerifyPickerCell.h
//  NewBag
//
//  Created by Jacky on 2024/4/7.
//

#import "BagBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface BagVerifyPickerCell : BagBaseTableViewCell
- (void)updateUIWithModel:(NSString *)title isSelected:(BOOL)isSelected;
 
@end

NS_ASSUME_NONNULL_END
