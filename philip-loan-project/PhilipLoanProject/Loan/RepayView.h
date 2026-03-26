//
//  RepayView.h
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RepayView : UIView
@property(nonatomic)UIImageView *iconImageView;
//@property(nonatomic)UILabel *label1;
//@property(nonatomic)UILabel *label2;
@property(nonatomic)NSDictionary *info;
@property(nonatomic,copy)void(^tapBlk)(void);
@end

NS_ASSUME_NONNULL_END
