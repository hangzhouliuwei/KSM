//
//  BagVerifyInputTableViewCell.h
//  NewBag
//
//  Created by Jacky on 2024/4/7.
//

#import "BagBaseTableViewCell.h"
@class BagBasicRowModel;
NS_ASSUME_NONNULL_BEGIN

@interface BagVerifyInputTableViewCell : BagBaseTableViewCell
- (void)updateUIWithModel:(BagBasicRowModel *)model;
/// 添加邮箱输入提示
- (void)updateUIWithModel:(BagBasicRowModel *)model index:(NSIndexPath*)index tableView:(UITableView*)tableView topY:(CGFloat)topY;

@property (nonatomic,copy) void(^textBlock)(NSString *str);
//用户即将输入回调给埋点
@property (nonatomic,copy) void(^textBeginBlock)(void);

@end

NS_ASSUME_NONNULL_END
