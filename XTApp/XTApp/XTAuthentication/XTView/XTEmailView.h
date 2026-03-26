//
//  XTEmailView.h
//  XTApp
//
//  Created by xia on 2024/9/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTEmailView : UIView

@property(nonatomic,copy) XTStrBlock block;

- (void)xt_showTextField:(UITextField *)textField;
- (void)xt_remove;

@end

NS_ASSUME_NONNULL_END
