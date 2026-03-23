//
//  PTBankBankView.m
//  PTApp
//
//  Created by Jacky on 2024/8/26.
//

#import "PTBankBankView.h"
#import "PTBankModel.h"
#import "PTVerifyPickerView.h"
@interface PTBankBankView()<QMUITextFieldDelegate>
@property (nonatomic, strong) PTBankBankModel *model;
@property (nonatomic, strong) UIView *bankNameBg;
@property (nonatomic, strong) QMUILabel *bankNameTitleLabel;
@property (nonatomic, strong) QMUILabel *bankNameValueLabel;
@property (nonatomic, strong) UIImageView *arrow;
@property (nonatomic, strong) UIView *line1;


@property (nonatomic, strong) UIView *bankAccountBg;
@property (nonatomic, strong) QMUILabel *bankAccountTitle;
@property (nonatomic, strong) QMUITextField *bankAccountTextfield;

@property (nonatomic, strong) UIView *line2;
@property (nonatomic, strong) UILabel *bottomTitle;


@end
@implementation PTBankBankView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    [self addSubview:self.bankNameBg];
    [self.bankNameBg addSubview:self.bankNameTitleLabel];
    [self.bankNameBg addSubview:self.bankNameValueLabel];
    [self.bankNameBg addSubview:self.arrow];
    [self.bankNameBg addSubview:self.line1];
    
    [self addSubview:self.bankAccountBg];
    [self.bankAccountBg addSubview:self.bankAccountTitle];
    [self.bankAccountBg addSubview:self.bankAccountTextfield];
    [self.bankAccountBg addSubview:self.line2];
    [self addSubview:self.bottomTitle];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onCardTypeSelect)];
    [self.bankNameBg addGestureRecognizer:tap];
    [self.bankNameBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(65);
    }];
    [self.bankNameTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(16);
    }];
    [self.bankNameValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(self.bankNameTitleLabel.mas_bottom).offset(13);
    }];
    [self.arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bankNameValueLabel);
        make.right.mas_equalTo(-16);
        make.size.mas_equalTo(CGSizeMake(10, 10));
    }];
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.bottom.mas_equalTo(self.bankNameBg.mas_bottom).offset(-1);
        make.height.mas_equalTo(1);
    }];
    [self.bankAccountBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bankNameBg.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(65);
    }];
    [self.bankAccountTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(16);
    }];
    [self.bankAccountTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bankAccountTitle.mas_bottom);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(40);
    }];
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.bottom.mas_equalTo(self.bankAccountBg.mas_bottom).offset(0);
        make.height.mas_equalTo(1);
    }];
    [self.bottomTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bankAccountBg.mas_bottom).offset(24);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
    }];

}
- (void)updateUIWithModel:(PTBankBankModel *)model
{
    _model = model;
    if (![model.kotenNc.ovtenrcutNc br_isBlankString] && model.kotenNc.bltenthelyNc != 0) {
        self.bankAccountTextfield.text = model.kotenNc.ovtenrcutNc;
        self.bankText = model.kotenNc.ovtenrcutNc;
        WEAKSELF
        [model.untenrderlyNc enumerateObjectsUsingBlock:^(PTBankItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            STRONGSELF
            if(obj.retengnNc == model.kotenNc.bltenthelyNc){
                strongSelf.selectModel = obj;
                strongSelf.bankNameValueLabel.text = PTNotNull(obj.uptenornNc);
                strongSelf.bankNameValueLabel.textColor = PTUIColorFromHex(0x000000);
                *stop = YES;
            }
        }];
    }
}
- (void)onCardTypeSelect{
    PTVerifyPickerView *picker = [[PTVerifyPickerView alloc] initWithTitleArray:self.model.untenrderlyNc headerTitle:@"Bank card selectio"];
    picker.clickBlock = ^(id  _Nonnull model) {
        self.selectModel = model;
        self.bankNameValueLabel.text = self.selectModel.uptenornNc;
        self.bankNameValueLabel.textColor = PTUIColorFromHex(0x000000);
    };
    [picker showWithAnimation];
}
#pragma mark - textfield
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    //文本彻底结束编辑时调用
    self.bankText = textField.text;
//    [BagTrackHandleManager trackAppEventName:@"af_cc_result_card_item" withElementParam:@{@"tag":@"wallet", @"content": NotNull(textField.text)}];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
//    [BagTrackHandleManager trackAppEventName:@"af_cc_click_card_item" withElementParam:@{@"tag":@"wallet"}];
}
- (UIView *)bankNameBg
{
    if (!_bankNameBg) {
        _bankNameBg = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _bankNameBg;
}
- (QMUILabel *)bankNameTitleLabel
{
    if (!_bankNameTitleLabel) {
        _bankNameTitleLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font(12) textColor:PTUIColorFromHex(0x545B62)];
        _bankNameTitleLabel.text = @"Bank";
    }
    return _bankNameTitleLabel;
}
- (QMUILabel *)bankNameValueLabel
{
    if (!_bankNameValueLabel) {
        _bankNameValueLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font(12) textColor: RGBA(100, 122, 64, 0.32)];
        _bankNameValueLabel.text = @"Please Select";
    }
    return _bankNameValueLabel;
}
- (UIImageView *)arrow
{
    if (!_arrow) {
        _arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pt_basic_arrow_down"]];
    }
    return _arrow;
}
- (UIView *)line1
{
    if (!_line1) {
        _line1 = [[UIView alloc] initWithFrame:CGRectZero];
        _line1.backgroundColor = PTUIColorFromHex(0xE6F0FD);
    }
    return _line1;
}
- (UIView *)bankAccountBg
{
    if (!_bankAccountBg) {
        _bankAccountBg = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _bankAccountBg;
}
- (QMUILabel *)bankAccountTitle
{
    if (!_bankAccountTitle) {
        _bankAccountTitle = [[QMUILabel alloc] qmui_initWithFont:PT_Font(12) textColor:PTUIColorFromHex(0x545B62)];
        _bankAccountTitle.text = @"Bank Account";
    }
    return _bankAccountTitle;
}
- (QMUITextField *)bankAccountTextfield
{
    if (!_bankAccountTextfield) {
        _bankAccountTextfield = [[QMUITextField alloc] init];
        _bankAccountTextfield.placeholder = @"Input";
        _bankAccountTextfield.placeholderColor = RGBA(100, 122, 64, 0.32);
//        _bankAccountTextfield.keyboardType = UIKeyboardTypeNumberPad;//不一定为数字 可能有字母
//        UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.f, 40.f)];
//        _textfield.leftView = leftview;
        _bankAccountTextfield.leftViewMode = UITextFieldViewModeAlways;
        _bankAccountTextfield.font = [UIFont systemFontOfSize:12];
        _bankAccountTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
        _bankAccountTextfield.textColor = [UIColor qmui_colorWithHexString:@"#000000"];
        _bankAccountTextfield.delegate = self;
    }
    return _bankAccountTextfield;
}
- (UIView *)line2
{
    if (!_line2) {
        _line2 = [[UIView alloc] initWithFrame:CGRectZero];
        _line2.backgroundColor = PTUIColorFromHex(0xE6F0FD);
    }
    return _line2;
}
-(UILabel *)bottomTitle
{
    if (!_bottomTitle) {
        _bottomTitle = [[UILabel alloc] qmui_initWithFont:[UIFont systemFontOfSize:12] textColor:[UIColor qmui_colorWithHexString:@"#9CA7B4"]];
        _bottomTitle.numberOfLines = 0;
        _bottomTitle.text = @"Please confirm the account belongs to yourself and is correct,it will be used as a receipt account to receive the funds";
    }
    return _bottomTitle;
}
@end
