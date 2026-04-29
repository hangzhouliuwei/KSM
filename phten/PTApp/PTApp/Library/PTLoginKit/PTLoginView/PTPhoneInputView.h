//
//  PTPhoneInputView.h
//  PTApp
//
//  Created by 刘巍 on 2024/7/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTPhoneInputView : UIView
@property (nonatomic, copy) NSString *text;
@property(nonatomic, copy) PTIntBlock inputBlock;
-(instancetype)initWithPhoneInputViewFrame:(CGRect)frame;
- (void)becomeFirstResponder;
@end

NS_ASSUME_NONNULL_END
