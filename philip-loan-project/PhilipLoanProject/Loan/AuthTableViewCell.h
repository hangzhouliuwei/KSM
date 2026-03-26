//
//  AuthTableViewCell.h
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/9/3.
//

#import "PLPBaseTableViewCell.h"
#import "AuthSectionModel.h"
#import "EmailPopView.h"
NS_ASSUME_NONNULL_BEGIN

@interface AuthTableViewCell : PLPBaseTableViewCell
@property(nonatomic)UILabel *titleLabel;
@property(nonatomic)UITextField *textField;
@property(nonatomic)UIView *bgView;

@property(nonatomic)UIView *arrowView;
@property(nonatomic)UIView *coverView;
@property(nonatomic)EmailPopView *emailView;

@property(nonatomic)AuthOptionalModel *model;

@property(nonatomic)UIButton *cameraButton;
@property(nonatomic)UIImageView *idImageView;
//@property(nonatomic)UIImageView *photoButton;

@property(nonatomic)UIButton *maleButton,*femaleButton;

@property(nonatomic,copy)void(^tapItemBlk)(kAuthCellType type);

@property(nonatomic,copy)void(^tapCameraBlk)(void);

@property(nonatomic,copy)void(^editCompletedBlk)(NSString *text);
@property(nonatomic,copy)void(^editValueChangeBlk)(NSString *text);
@end

NS_ASSUME_NONNULL_END
