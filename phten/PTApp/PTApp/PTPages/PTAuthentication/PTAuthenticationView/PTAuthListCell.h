//
//  PTAuthListCell.h
//  PTApp
//
//  Created by Jacky on 2024/8/22.
//

#import <UIKit/UIKit.h>
#import "PTBaseTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN
@class PTAuthenticationItemModel;
@interface PTAuthListCell : PTBaseTableViewCell
- (void)configUIWithModel:(PTAuthenticationItemModel *)model index:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
