//
//  PPUserDefaultViewBankItem.m
// FIexiLend
//
//  Created by jacky on 2024/11/20.
//

#import "PPUserDefaultViewBankItem.h"
#import "PPNormalCardInfoAlert.h"

@interface PPUserDefaultViewBankItem () <UITextFieldDelegate>
@property (nonatomic, strong) UITextField *bankBagToTheTextField;
@property (nonatomic, strong) UITextField *accountTextField;
@property (nonatomic, copy) NSArray *bankToTheListItems;
@property (nonatomic, strong) PPNormalCardInfoAlert *alert;
@end

@implementation PPUserDefaultViewBankItem


- (NSString *)account {
    return _accountTextField.text;
}


- (id)initWithFrame:(CGRect)frame banks:(NSArray *)arr data:(NSMutableDictionary *)saveDic {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        self.saveDic = saveDic;
        self.bankToTheListItems = arr;
        [self loadUI];
        [self showAddToRadius:10];

    }
    return self;
}

- (void)loadUI {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.w, 38)];
    titleLabel.textColor = rgba(51, 51, 51, 1);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = FontBold(14);
    titleLabel.backgroundColor = rgba(236, 245, 255, 1);
    titleLabel.text = @"Select Bank";

    [self addSubview:titleLabel];
    
    
    UILabel *bankTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(LeftMargin, titleLabel.bottom + 14, 100, 42)];
    bankTitleLabel.text = @"Bank";

    [self addSubview:bankTitleLabel];
    bankTitleLabel.textColor = rgba(51, 51, 51, 1);
    bankTitleLabel.font = Font(12);
    
    _bankBagToTheTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.w - 140, titleLabel.bottom + 14, 100, 42)];
    _bankBagToTheTextField.borderStyle = UITextBorderStyleNone;
    _bankBagToTheTextField.textAlignment = NSTextAlignmentRight;
    _bankBagToTheTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _bankBagToTheTextField.enabled = NO;
    _bankBagToTheTextField.font = Font(12);
    
    _bankBagToTheTextField.textColor = rgba(51, 51, 51, 1);
    _bankBagToTheTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

    _bankBagToTheTextField.placeholder = @"Please select";
    [self addSubview:_bankBagToTheTextField];
    
    UIImageView *right = [[UIImageView alloc] initWithFrame:CGRectMake(_bankBagToTheTextField.right + 10, _bankBagToTheTextField.y + 13, 16, 16)];
    [self addSubview:right];
    right.image = ImageWithName(@"arrow_bot");

    UIButton *actionItemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    actionItemBtn.frame = CGRectMake(LeftMargin, titleLabel.bottom + 14, SafeWidth, 42);
    [self addSubview:actionItemBtn];
    [actionItemBtn addTarget:self action:@selector(bankSelect:) forControlEvents:UIControlEventTouchUpInside];

    UIView *lineBottom = [[UIView alloc] initWithFrame:CGRectMake(LeftMargin, actionItemBtn.bottom, SafeWidth, 1)];
    [self addSubview:lineBottom];
    lineBottom.backgroundColor = rgba(187, 187, 187, 1);

    UILabel *accountitleLeading = [[UILabel alloc] initWithFrame:CGRectMake(LeftMargin, lineBottom.bottom, 100, 42)];
    accountitleLeading.text = @"Bank Account";
    accountitleLeading.font = Font(12);
    [self addSubview:accountitleLeading];
    accountitleLeading.textColor = rgba(51, 51, 51, 1);

    _accountTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.w - 116, lineBottom.bottom, 100, 42)];
    _accountTextField.placeholder = @"Please enter";

    _accountTextField.textAlignment = NSTextAlignmentRight;
    _accountTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _accountTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _accountTextField.borderStyle = UITextBorderStyleNone;

    _accountTextField.keyboardType = UIKeyboardTypeAlphabet;
    _accountTextField.font = Font(12);
    _accountTextField.textColor = UIColor.blackColor;

    _accountTextField.delegate = self;
    [_accountTextField showAddToRadius:10];
    [self addSubview:_accountTextField];
    
    lineBottom = [[UIView alloc] initWithFrame:CGRectMake(LeftMargin, accountitleLeading.bottom, SafeWidth, 1)];
    lineBottom.backgroundColor = rgba(187, 187, 187, 1);
    [self addSubview:lineBottom];
    
    UILabel *desc = [[UILabel alloc] initWithFrame:CGRectMake(LeftMargin, self.h - 46, SafeWidth, 30)];
    
    NSString *aString = @"Please confirm the account belon";
    NSString *bString = @"gs to yourself and is correct, it will be used";
    NSString *cString = @" as a receipt account to receive the funds";
    NSString *valueString = StrFormat(@"%@%@%@", aString, bString, cString);

    
    desc.text = valueString;
    desc.font = Font(12);
    desc.numberOfLines = 0;
    desc.textColor = rgba(102, 102, 102, 1);

    [self addSubview:desc];
    
    [self refreshData];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (newString.length >= 100) {
        newString = [newString substringToIndex:100];
    }
    textField.text = newString;
    return NO;
}


- (void)bankSelect:(UIButton *)sender {
    kWeakself;
    [self endEditing:YES];
    _alert = [[PPNormalCardInfoAlert alloc] initWithData:self.bankToTheListItems selected:[_saveDic[p_channel] stringValue] title:@"Select Bank"];
    _alert.selectBlock = ^(NSDictionary *dic) {
        weakSelf.bankBagToTheTextField.text = notNull(dic[p_name]);
        NSString *channel = [dic[p_id] stringValue];
        weakSelf.saveDic[p_channel] = notNull(channel);
        
        weakSelf.bankName = notNull(dic[p_name]);
        
    };
    [_alert show];
}

- (void)refreshData {
    NSInteger selectChannel = [_saveDic[p_channel] integerValue];
    for (int i = 0; i < self.bankToTheListItems.count; i++) {
        NSDictionary *dic = self.bankToTheListItems[i];
        NSInteger channel = [dic[p_id] integerValue];
        if (channel == selectChannel) {
            _bankBagToTheTextField.text = notNull(dic[p_name]);
            self.bankName = notNull(dic[p_name]);
        }
    }
    _accountTextField.text = notNull(_saveDic[p_account]);
}


@end
