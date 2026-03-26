//
//  PTVerifyTextInputCell.h
//  PTApp
//
//  Created by Jacky on 2024/8/22.
//

#import "PTBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
@class PTBasicRowModel;
@interface PTVerifyTextInputCell : PTBaseTableViewCell
- (void)configUI:(PTBasicRowModel *)model index:(NSIndexPath*)index tableView:(UITableView*)tableView Y:(CGFloat)y;

@property (nonatomic,copy) PTStrBlock textBlock;
@property (nonatomic,copy) PTBlock textBeginBlock;

@end

NS_ASSUME_NONNULL_END
