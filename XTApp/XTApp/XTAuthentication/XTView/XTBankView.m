//
//  XTBankView.m
//  XTApp
//
//  Created by xia on 2024/9/11.
//

#import "XTBankView.h"
#import "XTBankItemModel.h"

@interface XTBankView()

@property(nonatomic,strong) UILabel *bankLab;
@property(nonatomic,strong) UITextField *bankTextField;

@property(nonatomic,strong) UILabel *accountLab;


@end

@implementation XTBankView

- (instancetype)init {
    self = [super init];
    if(self) {
        UILabel *titLab = [UILabel xt_lab:CGRectZero text:@"Select Bank" font:XT_Font_SD(17) textColor:XT_RGB(0x333333, 1.0f) alignment:NSTextAlignmentLeft tag:0];
        [self addSubview:titLab];
        [titLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(14);
            make.top.equalTo(self.mas_top);
            make.height.equalTo(@24);
        }];
        
        [self addSubview:self.bankLab];
        [self.bankLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(14);
            make.top.equalTo(titLab.mas_bottom).offset(16);
            make.height.equalTo(@21);
        }];
        
        [self addSubview:self.bankTextField];
        [self.bankTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(14);
            make.right.equalTo(self.mas_right).offset(-14);
            make.top.equalTo(self.bankLab.mas_bottom).offset(6);
            make.height.equalTo(@48);
        }];
        
        UIButton *btn = [UIButton new];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self.bankTextField);
        }];
        @weakify(self)
        btn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            if(self.block) {
                self.block(^(NSDictionary *dic) {
                    @strongify(self)
                    self.name = dic[@"name"];
                    self.value = dic[@"value"];
                    self.bankTextField.text = self.name;
                });
            }
            return [RACSignal empty];
        }];
        
        [self addSubview:self.accountLab];
        [self.accountLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(14);
            make.top.equalTo(self.bankTextField.mas_bottom).offset(12);
            make.height.equalTo(@21);
        }];
        
        [self addSubview:self.accountTextField];
        [self.accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(14);
            make.right.equalTo(self.mas_right).offset(-14);
            make.top.equalTo(self.accountLab.mas_bottom).offset(6);
            make.height.equalTo(@48);
        }];
        
        UILabel *subLab = [UILabel xt_lab:CGRectZero text:@"Please confirm the account belongs to yourself and be correct, it will be used as a receipt account to receice the funds." font:XT_Font(11) textColor:XT_RGB(0x999999, 1.0f) alignment:NSTextAlignmentLeft tag:0];
        subLab.numberOfLines = 0;
        [self addSubview:subLab];
        [subLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(14);
            make.right.equalTo(self.mas_right).offset(-14);
            make.top.equalTo(self.accountTextField.mas_bottom).offset(16);
        }];
    }
    return self;
}

- (void)setModel:(XTBankItemModel *)model {
    _model = model;
    if(![NSString xt_isEmpty:model.xt_channel]) {
        self.bankTextField.text = model.xt_channel_name;
        self.accountTextField.text = model.xt_account;
        self.name = model.xt_channel_name;
        self.value = model.xt_channel;
    }

}

- (UILabel *)bankLab {
    if(!_bankLab) {
        _bankLab = [UILabel xt_lab:CGRectZero text:@"Bank" font:XT_Font(15) textColor:[UIColor blackColor] alignment:NSTextAlignmentLeft tag:0];
    }
    return _bankLab;
}

- (UITextField *)bankTextField {
    if(!_bankTextField) {
        _bankTextField = [UITextField xt_textField:NO placeholder:@"Please select your bank" font:XT_Font(15) textColor:[UIColor blackColor] withdelegate:self];
        _bankTextField.backgroundColor = [UIColor whiteColor];
        _bankTextField.layer.cornerRadius = 10;
        _bankTextField.layer.borderColor = XT_RGB(0xdddddd, 1.0f).CGColor;
        _bankTextField.layer.borderWidth = 1;
        
        _bankTextField.leftViewMode = UITextFieldViewModeAlways;
        _bankTextField.leftView = [UIView xt_frame:CGRectMake(0, 0, 12, 48) color:[UIColor clearColor]];
        
        UIView *rightView = [UIView xt_frame:CGRectMake(0, 0, 27, 48) color:[UIColor clearColor]];
        
        UIImageView *rightImg = [UIImageView xt_img:@"xt_cell_acc_down" tag:0];
        [rightView addSubview:rightImg];
        rightImg.frame = CGRectMake(0, 0, 10, 6);
        rightImg.centerY = rightView.centerY;

        
        _bankTextField.rightViewMode = UITextFieldViewModeAlways;
        _bankTextField.rightView = rightView;
        
        _bankTextField.userInteractionEnabled = NO;
    }
    return _bankTextField;
}

- (UILabel *)accountLab {
    if(!_accountLab) {
        _accountLab = [UILabel xt_lab:CGRectZero text:@"Bank Account" font:XT_Font(15) textColor:[UIColor blackColor] alignment:NSTextAlignmentLeft tag:0];
    }
    return _accountLab;
}

- (UITextField *)accountTextField {
    if(!_accountTextField) {
        _accountTextField = [UITextField xt_textField:NO placeholder:@"Please enter your bank account number" font:XT_Font(15) textColor:[UIColor blackColor] withdelegate:self];
        _accountTextField.backgroundColor = [UIColor whiteColor];
        _accountTextField.layer.cornerRadius = 10;
        _accountTextField.layer.borderColor = XT_RGB(0xdddddd, 1.0f).CGColor;
        _accountTextField.layer.borderWidth = 1;
        _accountTextField.keyboardType = UIKeyboardTypeDefault;
        _accountTextField.leftViewMode = UITextFieldViewModeAlways;
        _accountTextField.leftView = [UIView xt_frame:CGRectMake(0, 0, 12, 48) color:[UIColor clearColor]];
    }
    return _accountTextField;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
