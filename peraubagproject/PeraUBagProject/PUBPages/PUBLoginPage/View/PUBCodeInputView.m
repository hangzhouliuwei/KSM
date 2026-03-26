//
//  PUBCodeInputView.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/22.
//

#import "PUBCodeInputView.h"
#import "UITextField+VerCodeTF.h"
#define Count 6 //一共有多少个输入框
#define Secure NO //是否密文
#define Width 46*WScale //输入框的宽度，这边我比较懒，都做成正方形了
 
//输入框输入时边框颜色
#define RedColor [UIColor redColor].CGColor
//输入框未输入时边框颜色
#define GrayColor [UIColor grayColor].CGColor

#define AuthCodeFont 24
@interface PUBCodeInputView ()<UITextFieldDelegate>
@property(nonatomic,strong)NSMutableArray *tfArr;
@property(nonatomic,copy)NSString *lastTFText;//最有一个TextField的内容
@end

@implementation PUBCodeInputView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        self.lastTFText = @"";
        self.tfArr = [NSMutableArray array];
        [self reloadUI];
    }
    return self;
}

- (void)reloadUI {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if(self.tfArr.count>0){
        [self.tfArr removeAllObjects];
    }
    // 创建五个圆形背景框
        for (int i = 0; i < 6; i++) {
            CGFloat x = 9*(i+1) + i * Width;
            // 创建UITextField
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(x, 0, Width, Width)];
            textField.textAlignment = NSTextAlignmentCenter;
            textField.keyboardType = UIKeyboardTypeNumberPad;
            textField.textColor = [UIColor whiteColor];
            textField.font = FONT_Semibold(28);
            textField.tag = i+1;
            textField.layer.borderWidth = 1.0f;
            textField.layer.cornerRadius = 14.f * WScale;
            textField.delegate = self;
            if(i==0){
                [textField becomeFirstResponder];
                textField.userInteractionEnabled = YES;
                textField.layer.borderColor = [UIColor qmui_colorWithHexString:@"#00FFD7"].CGColor;
                textField.backgroundColor = MainBgColor;
            }else{
//                textField.userInteractionEnabled = NO;
                textField.layer.borderColor = [UIColor qmui_colorWithHexString:@"#252735"].CGColor;
                textField.backgroundColor = MainBgColor;
            }
            // 监听输入变化事件
            [textField addTarget:self action:@selector(tfChange:) forControlEvents:UIControlEventEditingChanged];
            
            [self addSubview:textField];
            [self.tfArr addObject:textField];
        }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //>0说明我输入了一个字符
    if(textField.text.length > 0){
        textField.text = [textField.text substringToIndex:textField.text.length-1];
    }
    return YES;
}

-(void)tfChange:(UITextField *)textField{
     
    if(textField.tag == Count){
        self.lastTFText = textField.text;
        textField.layer.borderColor = [UIColor qmui_colorWithHexString:@"#00FFD7"].CGColor;
        textField.backgroundColor = MainBgColor;
    }
     
    if(textField.text.length > 0){
        if(textField.tag < self.tfArr.count){
            UITextField *tf = self.tfArr[textField.tag];
            tf.userInteractionEnabled = YES;
            [tf becomeFirstResponder];
            textField.layer.borderColor = [UIColor qmui_colorWithHexString:@"#00FFD7"].CGColor;
            textField.backgroundColor = MainBgColor;
//            textField.userInteractionEnabled = NO;
        }else{
            //四个输入框输入完毕,
//                        [self endEditing:YES];
            NSString *verificationCode = @"";
            // 拼接所有UITextField的内容
            for (UITextField *textField in self.tfArr) {
                verificationCode = [verificationCode stringByAppendingString:textField.text];
            }
            if(self.finishBlock){
                self.text = verificationCode;
                self.finishBlock(verificationCode);
            }
            NSLog(@"----%@======",verificationCode);
        }
    }
}
 
- (void)textFieldDidDeleteBackward:(UITextField *)textField{
    if(textField.tag == Count && self.lastTFText.length > 0){
        [textField becomeFirstResponder];
        self.lastTFText = @"";
    }else{
        //因为第一个UITextField的tag值为1
        if(textField.tag > 1){
            UITextField *tf = self.tfArr[textField.tag-2];
            tf.userInteractionEnabled = YES;
            tf.text = @"";
            [tf becomeFirstResponder];
//            textField.userInteractionEnabled = NO;
            textField.layer.borderColor = [UIColor qmui_colorWithHexString:@"#252735"].CGColor;
            textField.backgroundColor = MainBgColor;
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    // 根据tag值找到对应的UITextField并将其边框颜色设置为灰色
    for (UITextField *tf in self.tfArr) {
        if (tf.tag == textField.tag) {
            tf.layer.borderColor = [UIColor qmui_colorWithHexString:@"#252735"].CGColor;
            tf.backgroundColor = MainBgColor;
            break;
        }
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    // 将第一个UITextField的边框颜色设置为红色
    if (textField.tag == 1) {
        textField.layer.borderColor = [UIColor qmui_colorWithHexString:@"#00FFD7"].CGColor;
        textField.backgroundColor = MainBgColor;
    }
    return YES;
}

@end
