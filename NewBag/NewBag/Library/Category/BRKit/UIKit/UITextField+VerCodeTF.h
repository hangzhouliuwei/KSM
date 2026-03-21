//
//  UITextField+VerCodeTF.h
//  Test1
//
//  Created by cxn on 2023/7/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol VerCodeTFDelegate <UITextFieldDelegate>
 
@optional
- (void)textFieldDidDeleteBackward:(UITextField *)textField;
@end

@interface UITextField (VerCodeTF)
@property (weak, nonatomic) id <VerCodeTFDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
