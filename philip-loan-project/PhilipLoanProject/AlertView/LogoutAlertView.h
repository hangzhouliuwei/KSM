//
//  LogoutAlertView.h
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/9/10.
//

#import "PLPBaseAlertView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LogoutAlertView : PLPBaseAlertView


@property(nonatomic,copy)void(^tapBlk)(NSInteger index);

@property(nonatomic,strong)UILabel *infoLabel;

@end

NS_ASSUME_NONNULL_END
