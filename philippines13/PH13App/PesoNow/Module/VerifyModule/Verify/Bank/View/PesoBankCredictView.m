//
//  PesoBankCredictView.m
//  PesoApp
//
//  Created by Jacky on 2024/9/16.
//

#import "PesoBankCredictView.h"
#import "PesoBankWalletView.h"
#import "PesoBankBankView.h"
#import "PesoBankModel.h"
@interface PesoBankCredictView()
@property (nonatomic, strong) UIImageView *backImage;
@property (nonatomic, strong) UIButton *walletBtn;
@property (nonatomic, strong) UIButton *bankBtn;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *titleBg;
@property (nonatomic, strong) QMUILabel *titleL;
@property (nonatomic, strong) PesoBankModel *model;
@end
@implementation PesoBankCredictView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.scrollView.frame = CGRectMake(0, _titleBg.bottom, kScreenWidth, self.height - _titleBg.bottom );    
}
- (void)createUI{
    self.backgroundColor = [UIColor clearColor];
    UIImageView *backImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bank_back_1"]];
    backImage.contentMode = UIViewContentModeScaleAspectFill;
    backImage.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth/375*46);
    backImage.userInteractionEnabled = YES;
    [self addSubview:backImage];
    _backImage = backImage;
    
    self.walletBtn.frame = CGRectMake(0, 0, kScreenWidth/2, backImage.width);
    [backImage addSubview:self.walletBtn];
    self.bankBtn.frame = CGRectMake(kScreenWidth/2, 0, kScreenWidth/2, backImage.width);
    [backImage addSubview:self.bankBtn];
    
    UIView *titleBg = [[UIView alloc] initWithFrame:CGRectMake(0, backImage.bottom, kScreenWidth, 60)];
    titleBg.backgroundColor = UIColor.whiteColor;
    [self addSubview:titleBg];
    _titleBg = titleBg;
    
    UIView *left = [[UIView alloc] initWithFrame:CGRectMake(15, 0, 4, 20)];
    left.backgroundColor = ColorFromHex(0x0A7635);
    left.layer.cornerRadius = 3;
    left.centerY = 30;
    left.layer.masksToBounds = YES;
    [titleBg addSubview:left];
    
    QMUILabel *titleL = [[QMUILabel alloc] qmui_initWithFont:PH_Font_B(15) textColor:ColorFromHex(0x0B2C04)];
    titleL.frame = CGRectMake(left.right+8, 0, 200, 20);
    titleL.text = @"Select E-Wallet";
    titleL.numberOfLines = 0;
    titleL.centerY = 30;
    [titleBg addSubview:titleL];
    _titleL = titleL;
    
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, titleBg.bottom-20, kScreenWidth, self.height  - titleBg.bottom )];
    scrollview.backgroundColor = [UIColor whiteColor];
    scrollview.showsVerticalScrollIndicator = NO;
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.scrollEnabled = YES;
    scrollview.contentSize = CGSizeMake(0, scrollview.height+50);
    [self addSubview:scrollview];
    _scrollView = scrollview;
    
    _walletView = [[PesoBankWalletView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.height  - titleBg.bottom)];
    [scrollview addSubview:_walletView];
//
    _bankView = [[PesoBankBankView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.height  - titleBg.bottom)];
    [scrollview addSubview:_bankView];
    _bankView.hidden = YES;
    
}
- (void)updateUI:(PesoBankModel *)model
{
    _model = model;
    [self.walletView updateUIWithModel:model.abenthirteentlyNc];
    [self.bankView updateUIWithModel:model.murathirteenyNc];
}
- (void)setSelecctIndex:(NSInteger)selecctIndex
{
    _selecctIndex = selecctIndex;
    if (selecctIndex == 0) {
        self.titleL.text = @"Select E-Wallet";
        self.walletBtn.selected = YES;
        self.bankBtn.selected = NO;
        _backImage.image = [UIImage imageNamed:@"bank_back_1"];
        self.walletView.hidden = NO;
        self.bankView.hidden = YES;

        self.scrollView.scrollEnabled = YES;
    }else{
        self.titleL.text = @"Select Bank";
        self.walletBtn.selected = NO;
        self.bankBtn.selected = YES;
        _backImage.image = [UIImage imageNamed:@"bank_back_2"];
//        self.scrollView.scrollEnabled = NO;
        self.walletView.hidden = YES;
        self.bankView.hidden = NO;
    }
}
- (void)clickWallet:(UIButton *)btn{
    if (btn.selected) {
        return;;
    }
    self.selecctIndex = 0;
    if (self.clickBlock) {
        self.clickBlock(0);
    }
    if([QMUIHelper isKeyboardVisible]){
        [self endEditing:YES];
    }
}
- (void)clickBank:(UIButton *)btn{
    if (btn.selected) {
        return;;
    }
    if([QMUIHelper isKeyboardVisible]){
        [self endEditing:YES];
    }
    self.selecctIndex = 1;
    if (self.clickBlock) {
        self.clickBlock(1);
    }

}
- (UIButton *)walletBtn
{
    if (!_walletBtn) {
        _walletBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_walletBtn addTarget:self action:@selector(clickWallet:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _walletBtn;
}
- (UIButton *)bankBtn
{
    if (!_bankBtn) {
        _bankBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bankBtn addTarget:self action:@selector(clickBank:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bankBtn;
}
@end
