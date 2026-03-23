//
//  AuthBankViewCell.h
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/9/10.
//

#import "PLPBaseTableViewCell.h"
#import "AuthBankModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface AuthBankViewCell : PLPBaseTableViewCell

@property(nonatomic)UIView *bgView;
@property(nonatomic)UIButton *button;
@property(nonatomic)UIImageView *iconImageView;
@property(nonatomic)UILabel *nameLabel;
@property(nonatomic)UIView *lineView;
@property(nonatomic)AuthBankModel *model;
@end

NS_ASSUME_NONNULL_END
