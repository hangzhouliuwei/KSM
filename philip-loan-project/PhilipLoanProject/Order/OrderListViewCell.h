//
//  OrderListViewCell.h
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/29.
//

#import "PLPBaseTableViewCell.h"
#import "MoneyDateView.h"
NS_ASSUME_NONNULL_BEGIN

@interface OrderListViewCell : PLPBaseTableViewCell
@property(nonatomic)OrderListModel *model;
@property(nonatomic)UIView *bgView;
@property(nonatomic)UIImageView *iconImageView;
@property(nonatomic)UILabel *nameLabel, *statusLabel;
@property(nonatomic)MoneyDateView *tempView;
@property(nonatomic)UIButton *refundButton;
@property(nonatomic)void(^tapBlk)(void);
@end

NS_ASSUME_NONNULL_END
