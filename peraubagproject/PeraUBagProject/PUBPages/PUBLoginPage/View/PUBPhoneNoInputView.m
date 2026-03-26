//
//  PUBPhoneNoInputView.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/19.
//

#import "PUBPhoneNoInputView.h"

@interface PUBPhoneNoInputView ()<UITextFieldDelegate>
@property (nonatomic, strong) UILabel *preLabel;
@property (nonatomic, strong) UITextField *textView;
@end

@implementation PUBPhoneNoInputView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = MainBgColor;
        [self reloadUI];
    }
    return self;
}

- (void)reloadUI {
    [self addSubview:self.preLabel];
    [self addSubview:self.textView];
}

- (UILabel *)preLabel {
    if (!_preLabel) {
        _preLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 12, 40, 20)];
        _preLabel.centerY = self.height/2;
        _preLabel.backgroundColor = UIColor.clearColor;
        _preLabel.text = @"+63";
        _preLabel.textColor = [UIColor whiteColor];
        _preLabel.font = FONT_BOLD(17);
        _preLabel.textAlignment = NSTextAlignmentLeft;
        [_preLabel addLine:LineTypeRight color:[UIColor whiteColor]];
        [self addSubview:_preLabel];
    }
    return _preLabel;
}

- (UITextField *)textView {
    if (!_textView) {
        _textView = [[UITextField alloc] initWithFrame:CGRectMake(_preLabel.right +10, 0, self.width - _preLabel.right - 12 -10, self.height)];
        _textView.centerY = self.height/2;
        _textView.borderStyle = UITextBorderStyleNone;
        _textView.font = FONT_Semibold(18);
        _textView.textColor = [UIColor whiteColor];
        _textView.textAlignment = NSTextAlignmentLeft;
        _textView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textView.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textView.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Phone number" attributes:@{NSFontAttributeName:FONT(15) ,     NSForegroundColorAttributeName:[UIColor getColorWithColorString:@"#CCCCCC"]}];
        _textView.keyboardType = UIKeyboardTypeNumberPad;
        _textView.delegate = self;
    }
    return _textView;
}

- (NSString *)text {
    
    return self.textView.text;
}

- (void)setText:(NSString *)text {
    self.textView.text = text;
}

// 获得焦点
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    [PBCommonManager requestZhuCeMaiDian:@"21" phoneStr:@""];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    [PBCommonManager requestZhuCeMaiDian:@"30" phoneStr:@""];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (![self isAllNum:string]) {
        return NO;
    }
       NSString *text = [textField text];
       NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
       string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
       if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
           return NO;
       }
       text = [text stringByReplacingCharactersInRange:range withString:string];
       text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];

//       // 如果是电话号码格式化，需要添加这三行代码
//       NSMutableString *temString = [NSMutableString stringWithString:text];
//       [temString insertString:@" " atIndex:0];
//       text = temString;
       NSString *newString = @"";
       while (text.length > 0) {
           NSString *subString = [text substringToIndex:MIN(text.length, 4)];
           newString = [newString stringByAppendingString:subString];
           if (subString.length == 4) {
               newString = [newString stringByAppendingString:@" "];
           }
           text = [text substringFromIndex:MIN(text.length, 4)];
       }

       newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
       if (newString.length >= 19) {
           return NO;
       }
       [textField setText:newString];
        if (self.inputBlock) {
            self.inputBlock(newString.length);
        }
    
    return NO;
}


- (BOOL)isAllNum:(NSString *)string {
    unichar c;
    for (int i = 0; i < string.length; i++) {
        c = [string characterAtIndex:i];
        if (!isdigit(c)) {
            return NO;
        }
    }
    return YES;
}

- (void)becomeFirstResponder {
    [self.textView becomeFirstResponder];
}

@end
