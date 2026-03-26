//
//  CapsuleButton.h
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PLPCapsuleButton : UIButton
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
- (void)resetGradientBackground;
- (void)setSolidBackgroundColor:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
