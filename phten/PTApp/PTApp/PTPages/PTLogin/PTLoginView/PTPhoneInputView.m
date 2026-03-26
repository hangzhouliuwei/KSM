//
//  PTPhoneInputView.m
//  PTApp
//
//  Created by 刘巍 on 2024/7/29.
//

#import "PTPhoneInputView.h"

@interface PTPhoneInputView()<QMUITextFieldDelegate>
@property(nonatomic, strong) QMUILabel *preLabel;
@property(nonatomic, strong) QMUITextField *textField;
@end
@implementation PTPhoneInputView

-(instancetype)initWithPhoneInputViewFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    [self showRadius:4.f];
    self.layer.borderWidth = 1.f;
    self.layer.borderColor = PTUIColorFromHex(0x0C0C31).CGColor;
    [self addSubview:self.preLabel];
    [self addSubview:self.textField];
}


- (NSString *)text {
    
    return self.textField.text;
}

- (void)setText:(NSString *)text {
    self.textField.text = text;
}

// 获得焦点
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    [PBCommonManager requestZhuCeMaiDian:@"21" phoneStr:@""];
    return YES;
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
    [self.textField becomeFirstResponder];
}

#pragma amrk - lazy

- (QMUILabel *)preLabel {
    if (!_preLabel) {
        _preLabel = [[QMUILabel alloc] initWithFrame:CGRectMake(20, 12, 40, 20)];
        _preLabel.centerY = self.height/2;
        _preLabel.backgroundColor = UIColor.clearColor;
        _preLabel.text = @"+63";
        _preLabel.textColor = [UIColor blackColor];
        _preLabel.font = PT_Font_B(17);
        _preLabel.textAlignment = NSTextAlignmentLeft;
        [_preLabel addLine:PTLineTypeRight color:PTUIColorFromHex(0x0C0C31)];
    }
    return _preLabel;
}

- (QMUITextField *)textField{
    if(!_textField){
        _textField = [[QMUITextField alloc] initWithFrame:CGRectMake(_preLabel.right +10, 0, self.width - _preLabel.right - 12 -10, self.height)];
        _textField.centerY = self.height/2;
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.font = PT_Font_SD(18);
        _textField.textColor = [UIColor blackColor];
        _textField.textAlignment = NSTextAlignmentLeft;
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Phone number" attributes:@{NSFontAttributeName:PT_Font(15) ,NSForegroundColorAttributeName:[UIColor qmui_colorWithHexString:@"#CCCCCC"]}];
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.delegate = self;
    }
    
    return _textField;
}

@end
