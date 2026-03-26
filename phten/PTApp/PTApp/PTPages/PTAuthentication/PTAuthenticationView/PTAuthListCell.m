//
//  PTAuthListCell.m
//  PTApp
//
//  Created by Jacky on 2024/8/22.
//

#import "PTAuthListCell.h"
#import "PTAuthenticationModel.h"
@interface PTAuthListCell()
@property (nonatomic, strong) UIImageView *backImage;
@property (nonatomic, strong) QMUIButton *topBtn;
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) QMUILabel *titleLabel;
@property (nonatomic, strong) UIView *progeressBgView;

@property (nonatomic, strong) UIView *progeressView;
@property (nonatomic, strong) QMUILabel *progeressValue;
@property (nonatomic, strong) UIImageView *finisehIcon;

@end
@implementation PTAuthListCell

- (void)setupUI
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = UIColor.clearColor;
    self.contentView.backgroundColor = UIColor.clearColor;
    [self addSubview:self.backImage];
    [self addSubview:self.topBtn];
    [self addSubview:self.iconImage];
    [self addSubview:self.titleLabel];
    [self addSubview:self.progeressBgView];
    [self.progeressBgView addSubview:self.progeressView];
    [self addSubview:self.progeressValue];
    [self addSubview:self.finisehIcon];
    [self.backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(297, 70));
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
    }];
    [self.topBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backImage.mas_top).offset(-3);
        make.left.mas_equalTo(self.backImage);
        make.size.mas_equalTo(CGSizeMake(49, 21));
    }];
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backImage).offset(16);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImage.mas_right).offset(5);
        make.centerY.mas_equalTo(self.iconImage);
    }];
    [self.progeressBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.backImage.mas_bottom).offset(-10);
        make.left.mas_equalTo(self.titleLabel);
        make.right.mas_equalTo(self.backImage.mas_right).offset(-45);
        make.height.mas_equalTo(6);
    }];
    [self.progeressValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.progeressBgView.mas_right).offset(7);
        make.centerY.mas_equalTo(self.progeressBgView);
    }];
    [self.finisehIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.backImage.mas_right).offset(-10);
        make.top.mas_equalTo(self.backImage.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
}
- (void)configUIWithModel:(PTAuthenticationItemModel *)model index:(NSInteger)index
{
    self.titleLabel.text = model.fltendgeNc;
    [self.topBtn setTitle:[NSString stringWithFormat:@"Step %ld",index] forState:UIControlStateNormal];
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.dotenableNc] placeholderImage:[UIImage br_imageWithColor:[UIColor orangeColor]]];
    if (model.frtenllyNc == YES) {
        self.progeressValue.text = @"100%";
        [self.progeressBgView br_setGradientColor:RGBA(190, 251, 10, 1) toColor:RGBA(200, 251, 103, 1) direction:BRDirectionTypeLeftToRight bounds:CGRectMake(0, 0, 297-80-5, 6)];
        _finisehIcon.hidden = NO;
    }else{
        self.progeressValue.text = @"0%";
        _finisehIcon.hidden = YES;
        __block CAGradientLayer *layer = nil;
        [self.progeressBgView.layer.sublayers enumerateObjectsUsingBlock:^(__kindof CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[CAGradientLayer class]]) {
                layer = obj;
            }
        }];
        [layer removeFromSuperlayer];
    }
}
- (UIImageView *)backImage
{
    if (!_backImage) {
        _backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_auth_cell_bg"]];
        _backImage.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backImage;
}
- (QMUIButton *)topBtn{
    if (!_topBtn) {
        _topBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        _topBtn.titleLabel.font = PT_Font(10);
        [_topBtn setTitleColor:PTUIColorFromHex(0x000000) forState:UIControlStateNormal];
        [_topBtn setTitle:@"Step 1" forState:UIControlStateNormal];
        [_topBtn setBackgroundImage:[UIImage imageNamed:@"PT_auth_cell_top"] forState:UIControlStateNormal];
    }
    return _topBtn;
}
- (UIImageView *)iconImage
{
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc] initWithImage:[UIImage br_imageWithColor:[UIColor orangeColor]]];
    }
    return _iconImage;
}
- (UIImageView *)finisehIcon
{
    if (!_finisehIcon) {
        _finisehIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_auth_right"]];
        _finisehIcon.hidden = YES;
    }
    return _finisehIcon;
}
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font_M(14) textColor:PTUIColorFromHex(0x101D37)];
    }
    return _titleLabel;
}
- (UIView *)progeressBgView
{
    if (!_progeressBgView) {
        _progeressBgView = [[UIView alloc] initWithFrame:CGRectZero];
        _progeressBgView.backgroundColor = PTUIColorFromHex(0xDEE8F7);
        _progeressBgView.layer.cornerRadius = 3;
        _progeressBgView.layer.masksToBounds = YES;
    }
    return _progeressBgView;
}
- (UIView *)progeressView
{
    if (!_progeressView) {
        _progeressView = [[UIView alloc] initWithFrame:CGRectZero];
        _progeressView.backgroundColor = PTUIColorFromHex(0xBEFB0A);
    }
    return _progeressView;
}
- (QMUILabel *)progeressValue
{
    if (!_progeressValue) {
        _progeressValue = [[QMUILabel alloc] qmui_initWithFont:PT_Font_B(10) textColor:RGBA(0, 0, 0, 0.79)];
        _progeressValue.text = @"0%";
    }
    return _progeressValue;
}
@end
