//
//  PPSelfConfigCenterAlert.h
// FIexiLend
//
//  Created by jacky on 2024/11/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PPSelfConfigCenterAlert : UIView
- (id)initWithPPCenterCustomView:(UIView *)customView;
- (void)show;
- (void)hide;
@end

NS_ASSUME_NONNULL_END
