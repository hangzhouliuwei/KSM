//
//  PesoBasicInputCell.h
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import "PesoBaseTableViewCell.h"
@class PesoBasicRowModel;
NS_ASSUME_NONNULL_BEGIN

@interface PesoBasicInputCell : PesoBaseTableViewCell
- (void)configUI:(PesoBasicRowModel *)model index:(NSIndexPath*)index tableView:(UITableView*)tableView Y:(CGFloat)y;

@property (nonatomic,copy) void(^textBlock)(NSString *text);
@property (nonatomic,copy) dispatch_block_t textBeginBlock;
@end

NS_ASSUME_NONNULL_END
