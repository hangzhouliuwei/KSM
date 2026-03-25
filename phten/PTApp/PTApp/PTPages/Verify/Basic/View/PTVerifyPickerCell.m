//
//  PTVerifyPickerCell.m
//  PTApp
//
//  Created by Jacky on 2024/8/22.
//

#import "PTVerifyPickerCell.h"

@interface PTVerifyPickerCell ()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) QMUILabel *titleLabel;
@property (nonatomic, strong) UIImageView *selectIcon;

@end
@implementation PTVerifyPickerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return  self;
}
- (void)setupUI
{
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.selectIcon];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(49);
        make.centerY.mas_equalTo(0);
    }];
    [self.selectIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-17);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    [self.bgView br_setRoundedCorners:UIRectCornerAllCorners withRadius:CGSizeMake(8, 8) viewRect:CGRectMake(0, 0, kScreenWidth-30, 52)];
}
- (void)updateUIWithModel:(NSString *)title isSelected:(BOOL)isSelected
{
    _titleLabel.text = title;
    self.selectIcon.hidden = !isSelected;
    self.bgView.backgroundColor = isSelected ? RGBA(100, 236, 254, 0.26) : [UIColor whiteColor];
}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [UIView.alloc initWithFrame:CGRectZero];
    }
    return _bgView;
}
- (QMUILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font_M(16) textColor:PTUIColorFromHex(0x000000)];
//        _titleLabel.
    }
    return _titleLabel;
}
- (UIImageView *)selectIcon
{
    if (!_selectIcon) {
        _selectIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_basic_picker_arrow"]];
        _selectIcon.hidden = YES;
    }
    return  _selectIcon;
}

@end
