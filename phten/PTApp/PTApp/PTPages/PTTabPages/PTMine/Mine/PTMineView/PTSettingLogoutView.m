//
//  PTSettingLogoutView.m
//  PTApp
//
//  Created by 刘巍 on 2024/8/13.
//

#import "PTSettingLogoutView.h"

@interface PTSettingLogoutView()
@property(nonatomic, strong) QMUILabel *titleLabel;
@property(nonatomic, strong) QMUILabel *subTitleLabel;
@end

@implementation PTSettingLogoutView

-(void)showTitleStr:(NSString*)titleStr subTitleStr:(NSString*)subTitleStr
{
    self.titleLabel.text = PTNotNull(titleStr);
    self.subTitleLabel.text = PTNotNull(subTitleStr);
    [self show];
}

- (instancetype)init
{
    self = [super init];
    if(self){
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        self.backgroundColor = [PTUIColorFromHex(0x010E0B) colorWithAlphaComponent:0.5f];
        [self certUI];
    }
    
    return self;
}

-(void)certUI
{
    UIImageView *backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_setting_logoutBack"]];
    backImageView.userInteractionEnabled = YES;
    [self addSubview:backImageView];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(186.f);
        make.centerX.mas_equalTo(0);
        make.width.height.mas_equalTo(343.f);
    }];
    
    [backImageView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(170.f);
        make.height.mas_equalTo(18.f);
    }];
    
    [backImageView addSubview:self.subTitleLabel];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(198.f);
        make.left.mas_equalTo(20.f);
        make.right.mas_equalTo(-20.f);
    }];
    
    
    
    QMUIButton *confirmBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.backgroundColor = PTUIColorFromHex(0xE6F0FD);
    [confirmBtn showRadius:8.f];
    confirmBtn.titleLabel.font = PT_Font_B(14.f);
    [confirmBtn setTitle:@"Confirm" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:PTUIColorFromHex(0x637182) forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [backImageView addSubview:confirmBtn];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(42.f);
        make.left.mas_equalTo(28.f);
        make.width.mas_equalTo(94.f);
        make.bottom.mas_equalTo(-12.f);
    }];
    
    
    QMUIButton *cancelBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.backgroundColor = PTUIColorFromHex(0xC1FA53);
    [cancelBtn showRadius:8.f];
    cancelBtn.titleLabel.font = PT_Font_B(14.f);;
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(hiddeView) forControlEvents:UIControlEventTouchUpInside];
    [backImageView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-12.f);
        make.height.mas_equalTo(42.f);
        make.right.mas_equalTo(-18.f);
        make.width.mas_equalTo(170.f);
    }];
}

- (void)confirmBtnClick
{
    if(self.confirmClickBlock){
        self.confirmClickBlock();
    }
    [self hiddeView];
}

- (void)show
{
    WEAKSELF
    CGFloat y = 0;
    self.y = kScreenHeight;
    [UIView animateWithDuration:0.3 animations:^{
        STRONGSELF
        strongSelf.y = y;
    } completion:^(BOOL finished) {
        
    }];
    [TOP_WINDOW addSubview:self];
    
}

- (void)hiddeView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - lazy
-(QMUILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font_B(16.f) textColor:[UIColor blackColor]];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

-(QMUILabel *)subTitleLabel{
    if(!_subTitleLabel){
        _subTitleLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font(14.f) textColor:PTUIColorFromHex(0x333333)];
        _subTitleLabel.textAlignment = NSTextAlignmentCenter;
        _subTitleLabel.numberOfLines = 2.f;
    }
    return _subTitleLabel;
}

@end
