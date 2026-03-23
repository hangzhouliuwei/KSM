//
//  HoldAlertView.h
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/29.
//

#import "PLPBaseAlertView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HoldAlertView : PLPBaseAlertView

@property(nonatomic)UILabel *titleLabel;
@property(nonatomic)UILabel *infoLabel;
@property(nonatomic)UIButton *cancelButton, *confirmButton;
@property(nonatomic)void(^confirmButtonAction)(void);
@property(nonatomic)void(^cancelButtonAction)(void);


-(instancetype)initWithFrame:(CGRect)frame info:(NSString *)info;


@end

NS_ASSUME_NONNULL_END
