//
//  PTBankConfirmView.m
//  PTApp
//
//  Created by Jacky on 2024/8/26.
//

#import "PTBankConfirmView.h"

@interface PTBankConfirmView ()<QMUITextFieldDelegate>
@property (nonatomic, strong) UIImageView *bgImage;
@property (nonatomic, strong) QMUILabel *bankNameTitleLabel;
@property (nonatomic, strong) QMUITextField *bankNameValueTextfield;
@property (nonatomic, strong) QMUILabel *bankAccountTitle;
@property (nonatomic, strong) QMUITextField *bankAccountTextfield;

@property (nonatomic, strong) QMUIButton *cancelBtn;
@property (nonatomic, strong) QMUIButton *confirmBtn;
@end
@implementation PTBankConfirmView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        self.backgroundColor = RGBA(0, 0, 0, 0.61);
    }
    return  self;
}
- (void)show
{
    [[UIApplication sharedApplication].windows.firstObject addSubview:self];
}
- (void)setupUI{
    [self addSubview:self.bgImage];
    [self addSubview:self.bankNameTitleLabel];
    [self addSubview:self.bankNameValueTextfield];
    [self addSubview:self.bankAccountTitle];
    [self addSubview:self.bankAccountTextfield];
    [self addSubview:self.cancelBtn];
    [self addSubview:self.confirmBtn];
    
    [self.bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(343, 343));
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(-30);
    }];
    [self.bankNameTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgImage.mas_top).offset(125);
        make.left.mas_equalTo(self.bgImage.mas_left).offset(16);
    }];
    [self.bankNameValueTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bankNameTitleLabel.mas_bottom).offset(14);
        make.left.mas_equalTo(self.bgImage.mas_left).offset(16);
        make.right.mas_equalTo(self.bgImage.mas_right).offset(-16);
        make.height.mas_equalTo(36);
    }];
    [self.bankAccountTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bankNameValueTextfield.mas_bottom).offset(20);
        make.left.mas_equalTo(self.bgImage.mas_left).offset(16);
    }];
    [self.bankAccountTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bankAccountTitle.mas_bottom).offset(14);
        make.left.mas_equalTo(self.bgImage.mas_left).offset(16);
        make.right.mas_equalTo(self.bgImage.mas_right).offset(-16);
        make.height.mas_equalTo(36);
    }];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bankAccountTextfield.mas_bottom).offset(19);
        make.left.mas_equalTo(self.bgImage.mas_left).offset(28);
        make.size.mas_equalTo(CGSizeMake(94, 42));
    }];
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bankAccountTextfield.mas_bottom).offset(19);
        make.right.mas_equalTo(self.bgImage.mas_right).offset(-35);
        make.size.mas_equalTo(CGSizeMake(170, 42));
    }];
}
- (void)cancelAction{
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    [self removeFromSuperview];
}
- (void)confirmAction{
    if (self.confirmBlock) {
        self.confirmBlock();
    }
    [self removeFromSuperview];
}
- (void)setBank:(NSString *)bank
{
    _bank = bank;
    _bankNameValueTextfield.text = bank;
}
- (void)setBankNumber:(NSString *)bankNumber
{
    _bankNumber = bankNumber;
    _bankAccountTextfield.text = bankNumber;
}
- (UIImageView *)bgImage
{
    if (!_bgImage) {
        _bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pt_bank_confirm_bg"]];
    }
    return  _bgImage;
}
- (QMUILabel *)bankNameTitleLabel
{
    if (!_bankNameTitleLabel) {
        _bankNameTitleLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font(12) textColor:PTUIColorFromHex(0x545B62)];
        _bankNameTitleLabel.text = @"Channel/Bank:";
    }
    return _bankNameTitleLabel;
}
- (QMUITextField *)bankNameValueTextfield
{
    if (!_bankNameValueTextfield) {
        _bankNameValueTextfield = [[QMUITextField alloc] init];
        _bankNameValueTextfield.backgroundColor = RGBA(245, 249, 255, 1);
        _bankNameValueTextfield.placeholder = @"Input";
        _bankNameValueTextfield.placeholderColor = RGBA(100, 122, 64, 0.32);
        _bankNameValueTextfield.keyboardType = UIKeyboardTypeNumberPad;
        UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.f, 40.f)];
        _bankNameValueTextfield.leftView = leftview;
        _bankNameValueTextfield.leftViewMode = UITextFieldViewModeAlways;
        _bankNameValueTextfield.font = PT_Font_M(14);
        _bankNameValueTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
        _bankNameValueTextfield.textColor = [UIColor qmui_colorWithHexString:@"#000000"];
        _bankNameValueTextfield.delegate = self;
        _bankNameValueTextfield.enabled = NO;
        _bankNameValueTextfield.qmui_borderWidth = 1;
        _bankNameValueTextfield.qmui_borderColor = RGBA(221, 235, 255, 1);
        _bankNameValueTextfield.qmui_borderPosition = QMUIViewBorderPositionTop | QMUIViewBorderPositionLeft | QMUIViewBorderPositionRight | QMUIViewBorderPositionBottom;
    }
    return _bankNameValueTextfield;
}
- (QMUILabel *)bankAccountTitle
{
    if (!_bankAccountTitle) {
        _bankAccountTitle = [[QMUILabel alloc] qmui_initWithFont:PT_Font(12) textColor:PTUIColorFromHex(0x545B62)];
        _bankAccountTitle.text = @"Account number:";
    }
    return _bankAccountTitle;
}
- (QMUITextField *)bankAccountTextfield
{
    if (!_bankAccountTextfield) {
        _bankAccountTextfield = [[QMUITextField alloc] init];
        _bankAccountTextfield.backgroundColor = RGBA(245, 249, 255, 1);
        _bankAccountTextfield.placeholder = @"Input";
        _bankAccountTextfield.placeholderColor = RGBA(100, 122, 64, 0.32);
        _bankAccountTextfield.keyboardType = UIKeyboardTypeNumberPad;
        UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.f, 40.f)];
        _bankAccountTextfield.leftView = leftview;
        _bankAccountTextfield.leftViewMode = UITextFieldViewModeAlways;
        _bankAccountTextfield.font = PT_Font_M(14);
        _bankAccountTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
        _bankAccountTextfield.textColor = [UIColor qmui_colorWithHexString:@"#000000"];
        _bankAccountTextfield.delegate = self;
        _bankAccountTextfield.enabled = NO;
        _bankAccountTextfield.qmui_borderWidth = 1;
        _bankAccountTextfield.qmui_borderColor = RGBA(221, 235, 255, 1);
        _bankAccountTextfield.qmui_borderPosition = QMUIViewBorderPositionTop | QMUIViewBorderPositionLeft | QMUIViewBorderPositionRight | QMUIViewBorderPositionBottom;
    }
    return _bankAccountTextfield;
}
- (QMUIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.backgroundColor = RGBA(230, 240, 253, 0.53);
        _cancelBtn.titleLabel.font = PT_Font_M(14);
        [_cancelBtn setTitleColor:RGBA(99, 113, 130, 1) forState:UIControlStateNormal];
        [_cancelBtn setTitle:@"Back" forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        _cancelBtn.layer.cornerRadius = 8;
        _cancelBtn.layer.masksToBounds = YES;
    }
    return _cancelBtn;
}
- (QMUIButton *)confirmBtn
{
    if (!_confirmBtn) {
        _confirmBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.backgroundColor = RGBA(193, 250, 83, 1);
        _confirmBtn.titleLabel.font = PT_Font_M(14);
        [_confirmBtn setTitle:@"Confirm" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:RGBA(0, 0, 0, 1) forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
        _confirmBtn.layer.cornerRadius = 8;
        _confirmBtn.layer.masksToBounds = YES;
    }
    return _confirmBtn;
}

@end
