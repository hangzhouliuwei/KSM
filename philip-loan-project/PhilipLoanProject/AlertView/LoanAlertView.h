//
//  LoanAlertView.h
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/9/11.
//

#import "PLPBaseAlertView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoanAlertView : PLPBaseAlertView

@property(nonatomic)UIImageView *imageView;

@property(nonatomic)void(^tapBlk)(void);
@end

NS_ASSUME_NONNULL_END
