//
//  AuthContactViewCell.h
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/9/5.
//

#import "PLPBaseTableViewCell.h"
#import "AuthContactModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AuthContactViewCell : PLPBaseTableViewCell


@property(nonatomic)UILabel *titleLabel,*relationShipLabel;
@property(nonatomic)UIView *lineView;


@property(nonatomic)UITextField *textField;

@property(nonatomic)UIView *bgView;

@property(nonatomic)UIView *infoView;

@property(nonatomic)UILabel *nameLabel,*numberLabel;
@property(nonatomic)UIButton *addButton;
@property(nonatomic)AuthContactModel *model;
@property(nonatomic)void(^tapItemBlk)(NSInteger index);
@end

NS_ASSUME_NONNULL_END
