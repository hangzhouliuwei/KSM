//
//  PesoEnumPickerCell.h
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import <UIKit/UIKit.h>
#import "PesoBaseTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface PesoEnumPickerCell : PesoBaseTableViewCell
- (void)updateUIWithModel:(NSString *)title isSelected:(BOOL)isSelected;
@end

NS_ASSUME_NONNULL_END
