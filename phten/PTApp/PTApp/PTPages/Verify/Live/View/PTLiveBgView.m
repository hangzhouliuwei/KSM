//
//  PTLiveBgView.m
//  PTApp
//
//  Created by Jacky on 2024/8/25.
//

#import "PTLiveBgView.h"

@interface PTLiveBgView ()
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIButton *increaseTitleBtn;

@property (nonatomic, strong) UIView *descBgView;
@property (nonatomic, strong) QMUILabel *descLabel;
@property (nonatomic, strong) UIImageView *descImage;

@property (nonatomic, strong) UIView *errorBgView;
@property (nonatomic, strong) UIButton *errorInfoBtn;
@property (nonatomic, strong) UIImageView *errorImage;



@property (nonatomic, strong) UIButton *startBtn;
@property (nonatomic, strong) UIView *exampleBgView;
@property (nonatomic, strong) UIImageView *epImage1;
@property (nonatomic, strong) UIImageView *epImage2;
@property (nonatomic, strong) UIImageView *epImage3;

@end
@implementation PTLiveBgView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame: frame]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.headerView];
    [self.headerView addSubview:self.increaseTitleBtn];
    [self addSubview:self.descBgView];
    [self.descBgView addSubview:self.errorBgView];
    [self.errorBgView addSubview:self.errorInfoBtn];
    
    [self.descBgView addSubview:self.descLabel];
    [self.descBgView addSubview:self.descImage];
    [self addSubview:self.startBtn];
    [self addSubview:self.exampleBgView];
    [self.exampleBgView addSubview:self.epImage1];
    [self.exampleBgView addSubview:self.epImage2];
    [self.exampleBgView addSubview:self.epImage3];

    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(24);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(56);
    }];
    [self.increaseTitleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(17);
        make.centerY.mas_equalTo(0);
    }];
    [self.descBgView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerView.mas_bottom).offset(23);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(289);
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(16);
        make.centerX.mas_equalTo(0);
    }];
    [self.descImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.descLabel.mas_bottom).offset(24);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(177, 177));
    }];
    [self.errorBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(16);
        make.left.mas_equalTo(21);
        make.right.mas_equalTo(-28);
        make.height.mas_equalTo(30);
    }];
    
    [self.errorInfoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8);
        make.centerY.mas_equalTo(0);
    }];
    
    [self.startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.descBgView.mas_bottom).offset(30);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(42);
    }];
    [self.exampleBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.startBtn.mas_bottom).offset(39);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(81);
    }];
    
    NSArray *array = @[self.epImage1,self.epImage2,self.epImage3];
    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:81 leadSpacing:32 tailSpacing:32];
    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(81, 81));
    }];
    

}
- (void)startAction{
    if (self.startBlock) {
        self.startBlock();
    }
}
- (void)pt_updateUIFail
{
    _descLabel.hidden = YES;
    _errorBgView.hidden = NO;
    _descImage.image = [UIImage imageNamed:@"pt_live_error"];
    [_startBtn setBackgroundImage:[UIImage imageNamed:@"pt_live_try"] forState:UIControlStateNormal];
}
#pragma mark - getter
- (UIView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectZero];
        _headerView.backgroundColor = [UIColor whiteColor];
        _headerView.layer.cornerRadius = 8;
        _headerView.layer.masksToBounds = YES;
    }
    return _headerView;
}
- (UIButton *)increaseTitleBtn
{
    if (!_increaseTitleBtn) {
        _increaseTitleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _increaseTitleBtn.titleLabel.font = PT_Font_B(12);
        [_increaseTitleBtn setTitleColor:PTUIColorFromHex(0x000000) forState:UIControlStateNormal];
        [_increaseTitleBtn setImage:[UIImage imageNamed:@"pt_live_safe"] forState:UIControlStateNormal];
        [_increaseTitleBtn setTitle:@"Increase pass rate by 20%for a limited time!" forState:UIControlStateNormal];
        [_increaseTitleBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
    }
    return _increaseTitleBtn;
}
- (UIView *)descBgView
{
    if (!_descBgView) {
        _descBgView = [[UIView alloc] initWithFrame:CGRectZero];
        _descBgView.backgroundColor = [UIColor whiteColor];
        _descBgView.layer.cornerRadius = 16;
        _descBgView.layer.masksToBounds = YES;
    }
    return _descBgView;
}
- (QMUILabel *)descLabel
{
    if (!_descLabel) {
        _descLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font(14) textColor:PTUIColorFromHex(0x000000)];
        _descLabel.text = @"To ensure it is operated by yourself,we \n needs to verify your identity";
        _descLabel.numberOfLines = 0;
        _descLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _descLabel;
}
- (UIImageView *)descImage
{
    if (!_descImage) {
        _descImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pt_live_check"]];
    }
    return _descImage;
}
- (UIView *)errorBgView
{
    if (!_errorBgView) {
        _errorBgView = [[UIView alloc] initWithFrame:CGRectZero];
        _errorBgView.layer.masksToBounds = YES;
        _errorBgView.layer.cornerRadius = 4;
        _errorBgView.hidden = YES;
        [_errorBgView br_setGradientColor:PTUIColorFromHex(0xFE5879) toColor:RGBA(254, 88, 121, 0) direction:BRDirectionTypeLeftToRight bounds:CGRectMake(0, 0, kScreenWidth-37-44, 30)];
    }
    return _errorBgView;
}
- (UIButton *)errorInfoBtn
{
    if (!_errorInfoBtn) {
        _errorInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _errorInfoBtn.titleLabel.font = PT_Font_B(12);
        [_errorInfoBtn setTitleColor:PTUIColorFromHex(0x000000) forState:UIControlStateNormal];
        [_errorInfoBtn setImage:[UIImage imageNamed:@"pt_live_cry"] forState:UIControlStateNormal];
        [_errorInfoBtn setTitle:@"Authentication failed,please try again" forState:UIControlStateNormal];
        [_errorInfoBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
    }
    return _errorInfoBtn;
}
- (UIButton *)startBtn
{
    if (!_startBtn) {
        _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startBtn setBackgroundImage:[UIImage imageNamed:@"pt_live_start"] forState:UIControlStateNormal];
        [_startBtn addTarget:self action:@selector(startAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startBtn;
}
- (UIView *)exampleBgView
{
    if (!_exampleBgView) {
        _exampleBgView = [[UIView alloc] initWithFrame:CGRectZero];
        _exampleBgView.backgroundColor = [UIColor clearColor];
    }
    return _exampleBgView;
}
- (UIImageView *)epImage1
{
    if (!_epImage1) {
        _epImage1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pt_live_ep1"]];
    }
    return _epImage1;
}
- (UIImageView *)epImage2
{
    if (!_epImage2) {
        _epImage2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pt_live_ep2"]];
    }
    return _epImage2;
}
- (UIImageView *)epImage3
{
    if (!_epImage3) {
        _epImage3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pt_live_ep3"]];
    }
    return _epImage3;
}
@end
