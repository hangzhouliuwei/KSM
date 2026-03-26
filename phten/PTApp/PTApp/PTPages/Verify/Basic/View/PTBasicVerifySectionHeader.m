//
//  PTBasicVerifySectionHeader.m
//  PTApp
//
//  Created by Jacky on 2024/8/22.
//

#import "PTBasicVerifySectionHeader.h"

@interface PTBasicVerifySectionHeader ()
@property(nonatomic, copy) QMUILabel *titleLabel;
@property(nonatomic, copy) QMUILabel *subTitleLabel;
@property(nonatomic, copy) UIButton *hiddenBtn;

@end
@implementation PTBasicVerifySectionHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
//        self.backgroundColor = PTUIColorFromHex(0xDCF9AA);
    }
    return self;
}
- (void)setupUI{
    [self br_setGradientColor:PTUIColorFromHex(0xDCF9AA) toColor:PTUIColorFromHex(0xffffff) direction:BRDirectionTypeTopToBottom bounds:CGRectMake(0, 0, kScreenWidth, 46)];

    [self addSubview:self.titleLabel];
    [self addSubview:self.subTitleLabel];
    [self addSubview:self.hiddenBtn];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(13);
        make.height.mas_equalTo(20);
    }];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right);
        make.centerY.mas_equalTo(self.titleLabel);
    }];
    [self.hiddenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-16);
        make.size.mas_equalTo(CGSizeMake(16, 16));
        make.centerY.mas_equalTo(self.subTitleLabel);
    }];
}
- (void)updateUIWithTitle:(NSString *)title Subtitle:(NSString*)subtitle more:(BOOL)more isSelected:(BOOL)isSelected
{
    self.titleLabel.text = title;
    self.subTitleLabel.text = subtitle;
    _hiddenBtn.hidden = !more;
    _hiddenBtn.selected = isSelected;
}
- (void)onMoreClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (self.click) {
        self.click(btn.selected);
    }
}
#pragma -
- (QMUILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font_B(16) textColor: PTUIColorFromHex(0x000000)];
        _titleLabel.backgroundColor = PTUIColorFromHex(0x64F6FE);
    }
    return _titleLabel;
}
- (QMUILabel *)subTitleLabel
{
    if (!_subTitleLabel) {
        _subTitleLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font(12) textColor: PTUIColorFromHex(0x9CA7B4)];
    }
    return _subTitleLabel;
}
- (UIButton *)hiddenBtn
{
    if(!_hiddenBtn){
        _hiddenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_hiddenBtn setImage:[UIImage imageNamed:@"PT_basic_more_arrow_down"] forState:UIControlStateNormal];
        [_hiddenBtn setImage:[UIImage imageNamed:@"PT_basic_more_arrow_up"] forState:UIControlStateSelected];
        [_hiddenBtn addTarget:self action:@selector(onMoreClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _hiddenBtn;
}
@end
