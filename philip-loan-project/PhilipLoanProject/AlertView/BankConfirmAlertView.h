//
//  BankConfirmAlertView.h
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/9/10.
//

#import "PLPBaseAlertView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BankConfirmAlertView : PLPBaseAlertView

@property(nonatomic)UIButton *replaceButton,*confirmButton;


@property(nonatomic)UILabel *label1,*label2;
@property(nonatomic)void(^tapBtnBlk)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
