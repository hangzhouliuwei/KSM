//
//  BigCardView.h
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BigCardView : UIView

@property(nonatomic)UIImageView *bgImageView,*logoImageView;
@property(nonatomic)UILabel *titleLabel,*nameLabel;
@property(nonatomic)UILabel *valueLabel,*rateLabel, *termLabel;
@property(nonatomic)UIButton *applyButton;

@property(nonatomic, copy)void(^tapAppleyBlk)(void);

-(void)configureCardInfo:(NSDictionary *)dic isBigCard:(BOOL)isBigCard;


@end

NS_ASSUME_NONNULL_END
