//
//  PTOrderNoDaraView.m
//  PTApp
//
//  Created by Jacky on 2024/8/28.
//

#import "PTOrderNoDaraView.h"

@interface PTOrderNoDaraView ()
@property (nonatomic, strong) UIImageView *backImage;
@property (nonatomic, strong) QMUILabel *titleLabel;
@property (nonatomic, strong) QMUIButton *applyBtn;

@end
@implementation PTOrderNoDaraView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    [self addSubview:self.backImage];
    [self addSubview:self.titleLabel];
    [self addSubview:self.applyBtn];
    [self.backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(117);
        make.size.mas_equalTo(CGSizeMake(130, 130));
        make.centerX.mas_equalTo(self);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backImage.mas_bottom).offset(13);
        make.centerX.mas_equalTo(self);
    }];
    [self.applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(80);
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(220, 42));

    }];
}
- (void)applyAction{
    if (self.applyClick) {
        self.applyClick();
    }
}
- (UIImageView *)backImage
{
    if (!_backImage) {
        _backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_order_nodata"]];
    }
    return _backImage;
}
- (QMUILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font(12) textColor:PTUIColorFromHex(0x545B62)];
        _titleLabel.text = @"No Records";
    }
    return _titleLabel;
}
- (QMUIButton *)applyBtn
{
    if (!_applyBtn) {
        _applyBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        _applyBtn.backgroundColor = PTUIColorFromHex(0xC1FA53);
        _applyBtn.titleLabel.font = PT_Font_M(16);
        [_applyBtn setTitleColor:PTUIColorFromHex(0x000000) forState:UIControlStateNormal];
        _applyBtn.layer.cornerRadius = 21;
        _applyBtn.layer.masksToBounds = YES;
        [_applyBtn setTitle:@"Apply now" forState:UIControlStateNormal];
        [_applyBtn addTarget:self action:@selector(applyAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _applyBtn;
}
@end
