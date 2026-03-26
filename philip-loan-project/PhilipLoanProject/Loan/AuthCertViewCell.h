//
//  AuthCertViewCell.h
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/9/6.
//

#import <UIKit/UIKit.h>
#import "AuthCertModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface AuthCertViewCell : UICollectionViewCell

@property(nonatomic)UIImageView *iconImageView;
@property(nonatomic)UIImageView *statusImageView;
@property(nonatomic)UILabel *nameLabel;
@property(nonatomic)UIView *bgView;
@property(nonatomic)AuthCertModel *model;
@end

NS_ASSUME_NONNULL_END
