//
//  PUBBasicTxtCell.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PUBBasicSomesuchEgModel;
@interface PUBBasicTxtCell : UITableViewCell
@property (nonatomic,copy) ReturnStrBlock textBlock;
//用户即将输入回调给埋点
@property(nonatomic, copy) ReturnNoneBlock textBeginBlock;
-(void)configModel:(PUBBasicSomesuchEgModel*)model;
/// 添加邮箱输入提示
- (void)configModel:(PUBBasicSomesuchEgModel *)model index:(NSIndexPath*)index tableView:(UITableView*)tableView topY:(CGFloat)topY;
@end

NS_ASSUME_NONNULL_END
