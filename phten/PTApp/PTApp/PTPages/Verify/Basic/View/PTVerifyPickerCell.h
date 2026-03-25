//
//  PTVerifyPickerCell.h
//  PTApp
//
//  Created by Jacky on 2024/8/22.
//

#import "PTBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTVerifyPickerCell : PTBaseTableViewCell
- (void)updateUIWithModel:(NSString *)title isSelected:(BOOL)isSelected;
@end

NS_ASSUME_NONNULL_END
