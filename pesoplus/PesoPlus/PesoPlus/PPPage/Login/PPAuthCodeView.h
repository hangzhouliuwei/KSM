//
//  PPAuthCodeView.h
// FIexiLend
//
//  Created by jacky on 2024/11/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PPAuthCodeView : UIView <UITextFieldDelegate>
@property (nonatomic, strong) UITextField *textView;
@property (nonatomic, strong) NSDictionary *attrsDic;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) CallBackNone changeBlock;
- (id)initWithFrame:(CGRect)frame;
- (void)toResponder;
@end

NS_ASSUME_NONNULL_END
