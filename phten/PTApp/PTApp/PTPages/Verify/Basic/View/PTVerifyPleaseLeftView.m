//
//  PTVerifyPleaseLeftView.m
//  PTApp
//
//  Created by Jacky on 2024/8/22.
//

#import "PTVerifyPleaseLeftView.h"
@interface PTVerifyPleaseLeftView()
@property (nonatomic, strong) UIImageView *bgImage;
@property (nonatomic, strong) QMUILabel *titleLabel;
@property (nonatomic, strong) QMUILabel *contentLabel;
@property (nonatomic, strong) QMUIButton *cancelBtn;
@property (nonatomic, strong) QMUIButton *confirmBtn;
@end
@implementation PTVerifyPleaseLeftView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        self.backgroundColor = RGBA(0, 0, 0, 0.61);
    }
    return self;
}

- (void)setupUI{
    [self addSubview:self.bgImage];
    [self addSubview:self.titleLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.cancelBtn];
    [self addSubview:self.confirmBtn];
    [self.bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(-40);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(343, 343));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgImage.mas_top).offset(174);
        make.centerX.mas_equalTo(0);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(self.bgImage.mas_left).offset(28);
        make.right.mas_equalTo(self.bgImage.mas_right).offset(-28);

    }];
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bgImage.mas_bottom).offset(-12);
        make.left.mas_equalTo(self.bgImage.mas_left).offset(28);
        make.size.mas_equalTo(CGSizeMake(94, 42));
    }];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bgImage.mas_bottom).offset(-12);
        make.right.mas_equalTo(self.bgImage.mas_right).offset(-28);
        make.left.mas_equalTo(self.confirmBtn.mas_right).offset(16);
        make.height.mas_equalTo(42);
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
- (void)show
{
    [KEYWINDOW addSubview:self];
}
- (void)setContent:(NSString *)content
{
    _content = content;
    self.contentLabel.text = content;
}
- (void)setStep:(NSInteger)step
{
    _step = step;
    NSString *str = @"";
    switch (step) {
        case 1:
            self.bgImage.image = [UIImage imageNamed:@"pt_verify_basic_wanliu"];
            str = @"Complete the form to apply for a loan,and we'll tailor a loan amount just for you.";
            break;
        case 2:
            self.bgImage.image = [UIImage imageNamed:@"pt_verify_contact_wanliu"];
            str = @"Enhance your loan approval chances by providing your emergency contact information now.";
            break;
        case 3:
            self.bgImage.image = [UIImage imageNamed:@"pt_verify_identify_wanliu"];
            str = @"Complete your identification now for a chance to increase your loan limit.";

            break;
        case 4:
            self.bgImage.image = [UIImage imageNamed:@"pt_verify_face_wanliu"];
            str = @"Boost your credit score by completing facial recognition now.";
            break;
        case 5:
            self.bgImage.image = [UIImage imageNamed:@"pt_verify_bank_wanliu"];
            str = @"Take the final step to apply for your loan- submitting now will enhance your approval rate.";
            break;
        default:
            break;
    }
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 8;
    _contentLabel.attributedText = [[NSAttributedString alloc] initWithString:PTNotNull(str)  attributes:@{NSParagraphStyleAttributeName:style,NSFontAttributeName:PT_Font(14)}];
}
- (UIImageView *)bgImage
{
    if (!_bgImage) {
        _bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pt_verify_basic_wanliu"]];
    }
    return  _bgImage;
}
- (QMUILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font_B(16) textColor:PTUIColorFromHex(0x000000)];
        _titleLabel.text = @"Are you sure you want to leave?";
    }
    return _titleLabel;
}
- (QMUILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font(14) textColor:PTUIColorFromHex(0x000000)];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}
- (QMUIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.backgroundColor = RGBA(193, 250, 83, 1);
        _cancelBtn.titleLabel.font = PT_Font_B(14);
        [_cancelBtn setTitleColor:RGBA(0, 0, 0, 1) forState:UIControlStateNormal];
        [_cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
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
        _confirmBtn.backgroundColor = RGBA(230, 240, 253, 0.53);
        _confirmBtn.titleLabel.font = PT_Font_M(14);
        [_confirmBtn setTitleColor:RGBA(99, 113, 130, 1) forState:UIControlStateNormal];
        [_confirmBtn setTitle:@"Confirm" forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
        _confirmBtn.layer.cornerRadius = 8;
        _confirmBtn.layer.masksToBounds = YES;
    }
    return _confirmBtn;
}
@end
