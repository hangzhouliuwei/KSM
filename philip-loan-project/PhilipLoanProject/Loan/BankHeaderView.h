//
//  BankHeaderView.h
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/9/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BankHeaderView : UIView

@property(nonatomic)UIView *tipView;

@property(nonatomic)NSInteger index;

@property(nonatomic,copy)void(^tapIndex)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
