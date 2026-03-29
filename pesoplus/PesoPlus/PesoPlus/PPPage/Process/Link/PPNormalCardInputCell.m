//
//  PPNormalCardInputCell.m
// FIexiLend
//
//  Created by jacky on 2024/11/19.
//

#import "PPNormalCardInputCell.h"

@interface PPNormalCardInputCell () <UITextFieldDelegate>

@property (nonatomic, strong) UILabel *titleValiedLabel;
@property (nonatomic, copy) NSDictionary *dic;

@end

@implementation PPNormalCardInputCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleValiedLabel = [[UILabel alloc] initWithFrame:CGRectMake(LeftMargin, 0, SafeWidth - 110, 40)];
        _titleValiedLabel.textColor = TextBlackColor;
        _titleValiedLabel.font = Font(12);
        _titleValiedLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_titleValiedLabel];

        _text = [[UITextField alloc] initWithFrame:CGRectMake(_titleValiedLabel.right - 50, 0, 158, 40)];
        _text.textColor = UIColor.blackColor;

        _text.borderStyle = UITextBorderStyleNone;
        _text.font = Font(12);

        _text.delegate = self;
        [self.contentView addSubview:_text];
        _text.textAlignment = NSTextAlignmentRight;
        _text.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _text.clearButtonMode = UITextFieldViewModeWhileEditing;

        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(LeftMargin, 40, SafeWidth, 1)];
        lineView.backgroundColor = LineGrayColor;
        [self.contentView addSubview:lineView];
    }
    return self;
}

- (void)loadData:(NSDictionary *)dic {
    _dic = dic;
    _titleValiedLabel.text = dic[p_title];
    
    NSString *subtitle =  dic[p_subtitle];
    NSInteger inputType = [dic[p_inputType] integerValue];
    NSString *codestr = [dic[p_code] stringValue];
    NSString *valuestr = _needSaveDicData[codestr];
    _text.placeholder = notNull(subtitle);
    if (inputType == 1) {
        _text.keyboardType = UIKeyboardTypeNumberPad;
    }else {
        _text.keyboardType = UIKeyboardTypeDefault;
    }
    _text.text = notNull(valuestr);
    
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    NSString *code = _dic[p_code];
    self.needSaveDicData[code] = @"";
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self refreshEmailList:@""];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSString *code = _dic[p_code];
    if ([code isEqualToString:@"email"]) {
        [self refreshEmailList:newString];
    }
    if (newString.length >= 100) {
        newString = [newString substringToIndex:100];
    }
    textField.text = newString;
    self.needSaveDicData[code] = newString;
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(self.textBeginBlock){
        self.textBeginBlock();
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(self.textBlock){
        self.textBlock(textField.text);
    }
}

- (void)refreshEmailList:(NSString *)text {
    if (text.length == 0) {
        _emailView.hidden = YES;
        return;
    }
    _emailView.hidden = NO;
    [_emailView removeAllViews];
    
    _emailView.hidden = NO;
    NSArray *leadItemArr = [text componentsSeparatedByString:@"@"];
    NSArray *emailItemArr = @[@"@gmail.com", @"@icloud.com", @"@yahoo.com", @"@outlook.com"];
    NSMutableArray *validArr = [NSMutableArray array];
    if (leadItemArr.count == 1) {
        validArr = [NSMutableArray arrayWithArray:emailItemArr];
    }else if (leadItemArr.count == 2) {
        for (NSString *email in emailItemArr) {
            if ([email hasPrefix:StrFormat(@"@%@", leadItemArr[1])]){
                [validArr addObject:email];
            }
        }
    }else {
        _emailView.hidden = YES;
        return;
    }
    
    if (validArr.count == 0) {
        _emailView.hidden = YES;
        return;
    }
    
    for (int i = 0; i < validArr.count; i++) {
        UIButton *emailItemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        emailItemBtn.titleLabel.font = Font(12);
        emailItemBtn.frame = CGRectMake(0, i*30, _emailView.w, 30);
        emailItemBtn.tag = i;
        [emailItemBtn setTitleColor:TextGrayColor forState:UIControlStateNormal];
        [_emailView addSubview:emailItemBtn];
        
        [emailItemBtn addTarget:self action:@selector(emailClick:) forControlEvents:UIControlEventTouchUpInside];
        [emailItemBtn setTitle:StrFormat(@"%@%@", leadItemArr[0], validArr[i]) forState:UIControlStateNormal];
    }
}

- (void)emailClick:(UIButton *)sender {
    self.text.text = [sender titleForState:UIControlStateNormal];
    NSString *code = _dic[p_code];
    self.needSaveDicData[code] = self.text.text;
    [self.text endEditing:YES];
}

@end
