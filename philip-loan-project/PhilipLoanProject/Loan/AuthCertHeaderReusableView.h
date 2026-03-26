//
//  AuthCertHeaderReusableView.h
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/9/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AuthCertHeaderReusableView : UICollectionReusableView

@property(nonatomic)UILabel *titleLabel;
@property(nonatomic)UIImageView *iconImageView;
@property(nonatomic)UIImageView *bgImageView;
@property(nonatomic)UILabel *valueLabel;
@property(nonatomic)UILabel *tipLabel;
@end

NS_ASSUME_NONNULL_END
