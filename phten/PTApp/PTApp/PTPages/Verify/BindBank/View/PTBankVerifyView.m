//
//  PTBankVerifyView.m
//  PTApp
//
//  Created by Jacky on 2024/8/26.
//

#import "PTBankVerifyView.h"
#import "PTBankWalletView.h"
#import "PTBankBankView.h"
#import "PTBankModel.h"
@interface PTBankVerifyView()
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *backImage;

@property (nonatomic, strong) UIButton *walletBtn;
@property (nonatomic, strong) UIButton *bankBtn;
@property (nonatomic, strong) QMUILabel *titleLabel;
@property (nonatomic, strong) PTBankModel *model;

@end
@implementation PTBankVerifyView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame: frame]) {
        [self setupUI];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setupUI{
    self.layer.masksToBounds = YES;
    [self addSubview:self.backImage];
    [self addSubview:self.walletBtn];
    [self addSubview:self.bankBtn];
    [self addSubview:self.titleLabel];
    
    [self addSubview:self.scrollView];
    UIView *bgView = [[UIView alloc]init];
    [self.scrollView addSubview:bgView];
    [bgView addSubview:self.walletView];
    [bgView addSubview:self.bankView];
    
    [self.backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo((kScreenWidth-32)/343*480);
    }];
    [@[self.walletBtn, self.bankBtn] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [@[self.walletBtn, self.bankBtn] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(80);
        make.left.mas_equalTo(16);
    }];
//
//    [self addSubview:self.bankView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(117);
        make.left.right.bottom.mas_equalTo(self);
    }];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
        make.height.mas_equalTo(370);

    }];
    [self.walletView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(bgView);
    }];
    [self.bankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(bgView);
    }];
  
}
- (void)updateUI:(PTBankModel *)model
{
    _model = model;
    [self.walletView updateUIWithModel:model.abtenentlyNc];
    [self.bankView updateUIWithModel:model.mutenrayNc];
    
}
- (void)clickWallet:(UIButton *)btn{
    if (self.walletBtn.selected) {
        return;
    }
    self.walletBtn.selected = YES;
    self.selecctIndex = 0;
    self.walletView.hidden = NO;
    self.bankView.hidden = YES;
    if (self.clickBlock) {
        self.clickBlock(0);
    }
    
}
- (void)clickBank:(UIButton *)btn{
    if (self.bankBtn.selected) {
        return;
    }
    self.scrollView.contentOffset = CGPointMake(0, 0);
    self.bankBtn.selected = YES;
    self.selecctIndex = 1;
    self.walletView.hidden = YES;
    self.bankView.hidden = NO;
    if (self.clickBlock) {
        self.clickBlock(1);
    }
}
- (void)setSelecctIndex:(NSInteger)selecctIndex
{
    _selecctIndex = selecctIndex;
    if (selecctIndex == 0) {
        self.titleLabel.text = @"Select E-Wallet";
        self.walletBtn.selected = YES;
        self.bankBtn.selected = NO;
        self.backImage.image = [UIImage imageNamed:@"pt_bank_bg"];
        [self.backImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo((kScreenWidth-32)/343*480);
        }];
        [self layoutIfNeeded];
        self.scrollView.scrollEnabled = YES;
    }else{
        self.titleLabel.text = @"Select Bank";
        self.walletBtn.selected = NO;
        self.bankBtn.selected = YES;
        self.backImage.image = [UIImage imageNamed:@"pt_bank_bg_small"];
        [self.backImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo((kScreenWidth-32)/343*344);
        }];
        [self layoutIfNeeded];
        self.scrollView.scrollEnabled = NO;
    }
}
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.layer.masksToBounds = YES;
    }
    return _scrollView;
}
- (UIImageView *)backImage
{
    if (!_backImage) {
        _backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pt_bank_bg"]];
        _backImage.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _backImage;
}
- (UIButton *)walletBtn
{
    if (!_walletBtn) {
        _walletBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_walletBtn setTitleColor:RGBA(17, 17, 17, 0.38) forState:UIControlStateNormal];
        [_walletBtn setTitleColor:RGBA(0, 0, 0, 1) forState:UIControlStateSelected];
        [_walletBtn setTitle:@"E-Wallet" forState:UIControlStateNormal];
        _walletBtn.titleLabel.font = PT_Font_M(16);
        [_walletBtn addTarget:self action:@selector(clickWallet:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _walletBtn;
}
- (UIButton *)bankBtn
{
    if (!_bankBtn) {
        _bankBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bankBtn setTitleColor:RGBA(17, 17, 17, 0.38) forState:UIControlStateNormal];
        [_bankBtn setTitleColor:RGBA(0, 0, 0, 1) forState:UIControlStateSelected];
        [_bankBtn setTitle:@"Bank" forState:UIControlStateNormal];
        _bankBtn.titleLabel.font = PT_Font_M(16);
        [_bankBtn addTarget:self action:@selector(clickBank:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bankBtn;
}
- (QMUILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font_B(16) textColor:PTUIColorFromHex(0x000000)];
    }
    return _titleLabel;
}
- (PTBankWalletView *)walletView
{
    if (!_walletView) {
        _walletView = [[PTBankWalletView alloc] initWithFrame:CGRectZero];
    }
    return _walletView;
}
- (PTBankBankView *)bankView
{
    if (!_bankView) {
        _bankView = [[PTBankBankView alloc] initWithFrame:CGRectZero];
        _bankView.hidden = YES;
    }
    return _bankView;
}
@end
