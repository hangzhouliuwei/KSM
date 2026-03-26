//
//  SmallCardView.h
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SmallCardView : UIView
@property(nonatomic)UIImageView *bgImageView,*logoImageView;
@property(nonatomic)UILabel *titleLabel,*nameLabel;
@property(nonatomic)UILabel *valueLabel;
@property(nonatomic)UIButton *applyButton;

@property(nonatomic, copy)void(^tapAppleyBlk)(void);

-(void)configureCardInfo:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
