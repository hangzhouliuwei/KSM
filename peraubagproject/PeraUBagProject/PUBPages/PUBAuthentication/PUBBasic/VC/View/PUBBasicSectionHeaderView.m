//
//  PUBBasicSectionHeaderView.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/3.
//

#import "PUBBasicSectionHeaderView.h"

@interface PUBBasicSectionHeaderView()
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *subTitleLabel;
@property(nonatomic, strong) QMUIButton *hideBtn;
@end

@implementation PUBBasicSectionHeaderView

- (instancetype)initWithTitle:(NSString *)title Subtitle:(NSString*)subtitle more:(BOOL)more isHidde:(BOOL)isHidde
{
    self = [super init];
    if(self){
        self.backgroundColor = [UIColor qmui_colorWithHexString:@"#313848"];
        [self initSubViews];
        [self initSubFrames];
        [self updataTitle:title Subtitle:subtitle more:more isHidde:isHidde];
    }
    return self;
}

-(void)initSubViews
{
    [self addSubview:self.titleLabel];
    [self addSubview:self.subTitleLabel];
    [self addSubview:self.hideBtn];
}

-(void)initSubFrames
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20.f);
        make.centerY.mas_equalTo(0);
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right).offset(4.f);
        make.centerY.mas_equalTo(self.titleLabel.mas_centerY);
    }];
    
    [self.hideBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-22.f);
        make.centerY.mas_equalTo(self.titleLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60.f, 40.f));
    }];
}
- (void)updataTitle:(NSString *)title Subtitle:(NSString*)subtitle more:(BOOL)more isHidde:(BOOL)isHidde
{
    self.titleLabel.text = NotNull(title);
    if(![PUBTools isBlankString:subtitle]){
        self.subTitleLabel.text = [NSString stringWithFormat:@"%@",subtitle];
    }
    self.hideBtn.hidden = !more;
    self.hideBtn.selected = isHidde;
    [self.hideBtn setTitle:isHidde ? @"Hide" : @"More" forState:UIControlStateNormal];
}

- (void)hideBtnClick:(QMUIButton*)btn
{
    btn.selected = !btn.selected;
    [_hideBtn setTitle:btn.selected ?@"Hide" : @"More" forState:UIControlStateNormal];
    if(self.clicMoreBlock){
        self.clicMoreBlock(btn.selected);
    }
}

#pragma mark - lazy

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] qmui_initWithFont:FONT_MED_SIZE(12.f) textColor:[UIColor qmui_colorWithHexString:@"#01FED7"]];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel{
    if(!_subTitleLabel){
        _subTitleLabel = [[UILabel alloc] qmui_initWithFont:FONT(9.f) textColor:[UIColor qmui_colorWithHexString:@"#01FED7"]];
        _subTitleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _subTitleLabel;
}

-(QMUIButton *)hideBtn{
    if(!_hideBtn){
        _hideBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        _hideBtn.titleLabel.font = FONT_MED_SIZE(14.f);
        [_hideBtn setTitle:@"More" forState:UIControlStateNormal];
        [_hideBtn setTitleColor:[UIColor qmui_colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
        [_hideBtn addTarget:self action:@selector(hideBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _hideBtn;
}

@end
