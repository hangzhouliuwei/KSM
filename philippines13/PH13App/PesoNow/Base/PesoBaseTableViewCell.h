//
//  PesoBaseTableViewCell.h
//  PesoApp
//
//  Created by Jacky on 2024/9/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PesoBaseTableViewCell : UITableViewCell
- (void)createUI;
- (void)configUIWithModel:(id)model;
@end

NS_ASSUME_NONNULL_END
