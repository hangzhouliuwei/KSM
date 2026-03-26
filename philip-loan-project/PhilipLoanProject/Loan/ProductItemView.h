//
//  ProductItemView.h
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/9/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductItemView : UIView
@property(nonatomic)UILabel *titleLabel, *valueLabel, *tipLabel;
@property(nonatomic)UIButton *payButton;
@property(nonatomic)UIImageView *iconImageView;
@property(nonatomic, copy)void(^tapItemBlk)(void);
@property(nonatomic)NSDictionary *dic;



@end

NS_ASSUME_NONNULL_END
