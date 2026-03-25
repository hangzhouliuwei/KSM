//
//  PTBankWalletCell.m
//  PTApp
//
//  Created by Jacky on 2024/8/26.
//

#import "PTBankWalletCell.h"
#import "PTBankModel.h"
@interface PTBankWalletCell ()
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) QMUILabel *titleLabel;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UIView *line;
@end
@implementation PTBankWalletCell

- (void)setupUI
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.iconImage];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.selectBtn];
    [self.contentView addSubview:self.line];

    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(16);
        make.size.mas_equalTo(CGSizeMake(38, 38));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(self.iconImage.mas_right).offset(8);
    }];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-16);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-1);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(1);
    }];
}
- (void)updateUIWithModel:(PTBankItemModel *)model isSelect:(BOOL)isSelect
{
    _titleLabel.text = model.uptenornNc;
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:model.ietenNc]];
    self.selectBtn.selected = isSelect;
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
        _titleLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font(16) textColor:PTUIColorFromHex(0x000000)];
    }
    return _titleLabel;
}
- (UIButton *)selectBtn
{
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectBtn.userInteractionEnabled = NO;
        [_selectBtn setImage:[UIImage imageNamed:@"pt_bank_normal"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"pt_bank_select"] forState:UIControlStateSelected];
    }
    return _selectBtn;
}
- (UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = PTUIColorFromHex(0xE6F0FD);
    }
    return _line;
}
@end
