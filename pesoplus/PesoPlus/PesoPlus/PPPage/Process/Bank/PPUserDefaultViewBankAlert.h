//
//  PPUserDefaultViewBankAlert.h
// FIexiLend
//
//  Created by jacky on 2024/11/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PPUserDefaultViewBankAlert : UIView
@property (nonatomic, copy) CallBackNone confirmBlock;
@property (nonatomic, copy) CallBackNone cancelBlock;
- (id)initWithBank:(NSString *)bank account:(NSString *)account;
- (void)show;
- (void)hide;
@end

NS_ASSUME_NONNULL_END
