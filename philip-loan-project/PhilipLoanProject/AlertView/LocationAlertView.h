//
//  LocationAlertView.h
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/29.
//

#import "PLPBaseAlertView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LocationAlertView : PLPBaseAlertView

@property(nonatomic)UILabel *infoLabel;
@property(nonatomic)UIButton *closeButton,*okButton;

@property(nonatomic)void(^okBlk)(void);
@end

NS_ASSUME_NONNULL_END
