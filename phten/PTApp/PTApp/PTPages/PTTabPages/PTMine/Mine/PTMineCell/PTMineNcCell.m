//
//  PTMineNcCell.m
//  PTApp
//
//  Created by 刘巍 on 2024/8/12.
//

#import "PTMineNcCell.h"
#import "PTMineNcModel.h"
@interface PTMineNcCell ()
@property (nonatomic, strong) UIImageView *backImage;

@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) QMUILabel *titleLabel;
@property (nonatomic, strong) QMUILabel *statusLabel;
@property (nonatomic, strong) QMUILabel *amountLabel;
@property (nonatomic, strong) QMUILabel *amountDescLabel;
@property (nonatomic, strong) QMUILabel *repayDateLabel;
@property (nonatomic, strong) QMUILabel *repayDateDescLabel;
@property (nonatomic, strong) QMUIButton *repayBtn;

@end
@implementation PTMineNcCell

- (void)setupUI
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.backImage];
    [self.contentView addSubview:self.iconImage];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.statusLabel];
    [self.contentView addSubview:self.amountLabel];
    [self.contentView addSubview:self.amountDescLabel];
    [self.contentView addSubview:self.repayDateLabel];
    [self.contentView addSubview:self.repayDateDescLabel];
    [self.contentView addSubview:self.repayBtn];
    
    [self.backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(343, 162));
        make.top.mas_equalTo(8);
        make.centerX.mas_equalTo(0);
    }];
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backImage.mas_top).offset(40);
        make.left.mas_equalTo(self.backImage.mas_left).offset(16);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImage.mas_right).offset(16);
        make.centerY.mas_equalTo(self.iconImage);
    }];
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(27);
        make.left.mas_equalTo(self.backImage.mas_left).offset(16);
    }];
    [self.amountDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backImage.mas_left).offset(16);
        make.top.mas_equalTo(self.amountLabel.mas_bottom).offset(6);
    }];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backImage.mas_top).offset(6);
        make.right.mas_equalTo(self.backImage.mas_right).offset(-10);
    }];
    [self.repayDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.backImage.mas_right).offset(-30);
        make.centerY.mas_equalTo(self.iconImage);
    }];
    [self.repayDateDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.repayDateLabel.mas_bottom).offset(4);
        make.left.mas_equalTo(self.repayDateLabel.mas_left);
    }];
    [self.repayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.backImage.mas_right).offset(-20);
        make.top.mas_equalTo(self.repayDateDescLabel.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(110, 30));
    }];
}

- (void)configUIWithModel:(PTMineNcModel *)model
{
    _titleLabel.text = model.hatenryNc;
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:model.ietenNc]];
    self.amountLabel.text = model.geteneralitatNc;
    self.statusLabel.text = @"Overdue payment";
    self.repayDateLabel.text = model.acteneptablyNc;
}

- (void)repayAction{
    if (self.repayBlock) {
        self.repayBlock();
    }
}

- (UIImageView *)backImage
{
    if (!_backImage) {
        _backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_order_bg"]];
        _backImage.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backImage;
}
- (UIImageView *)iconImage
{
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    }
    return _iconImage;
}
- (QMUILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font(16) textColor:UIColor.blackColor];
    }
    return _titleLabel;
}
- (QMUILabel *)amountLabel
{
    if (!_amountLabel) {
        _amountLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font(16) textColor:UIColor.blackColor];
    }
    return _amountLabel;
}
- (QMUILabel *)amountDescLabel
{
    if (!_amountDescLabel) {
        _amountDescLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font_Light(10) textColor:UIColor.blackColor];
        _amountDescLabel.text = @"Maximum Loan Amount";
    }
    return _amountDescLabel;
}
- (QMUILabel *)repayDateLabel
{
    if (!_repayDateLabel) {
        _repayDateLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font_B(14) textColor:UIColor.blackColor];
    }
    return _repayDateLabel;
}
- (QMUILabel *)repayDateDescLabel
{
    if (!_repayDateDescLabel) {
        _repayDateDescLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font_Light(10) textColor:UIColor.blackColor];
        _repayDateDescLabel.text = @"Repayment date";
    }
    return _repayDateDescLabel;
}
- (QMUILabel *)statusLabel
{
    if (!_statusLabel) {
        _statusLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font(10) textColor:UIColor.blackColor];
        _statusLabel.textAlignment = NSTextAlignmentRight;
        _statusLabel.textColor = PTUIColorFromHex(0xFA220E);
    }
    return _statusLabel;
}
- (QMUIButton *)repayBtn
{
    if (!_repayBtn) {
        _repayBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        _repayBtn.backgroundColor = PTUIColorFromHex(0xec5f4b);
        _repayBtn.titleLabel.font = PT_Font_B(12);
        [_repayBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _repayBtn.layer.cornerRadius = 4;
        _repayBtn.layer.masksToBounds = YES;
        [_repayBtn addTarget:self action:@selector(repayAction) forControlEvents:UIControlEventTouchUpInside];
        [_repayBtn setTitle:@"Refund" forState:UIControlStateNormal];
    }
    return _repayBtn;
}
@end
