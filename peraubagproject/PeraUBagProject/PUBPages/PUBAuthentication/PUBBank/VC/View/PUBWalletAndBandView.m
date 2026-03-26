//
//  PUBWalletAndBandView.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/10.
//

#import "PUBWalletAndBandView.h"

@interface PUBWalletAndBandView()
@property(nonatomic, strong) QMUIButton *walletBtn;
@property(nonatomic, strong) QMUIButton *bankBtn;
@end


@implementation PUBWalletAndBandView


- (void)selecIndexBtn:(NSInteger)selecIndex
{
    if(selecIndex == 0){
        [self btnCkiclk:self.walletBtn];
    }else if (selecIndex == 1){
        [self btnCkiclk:self.bankBtn];
    }
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor qmui_colorWithHexString:@"#1E1E2B"];
        [self initSubViews];
        [self initSubFrames];
        [self btnCkiclk:self.walletBtn];
        self.selecIndex = 0;
    }
    return self;
}

- (void)initSubViews
{
    [self addSubview:self.walletBtn];
    [self addSubview:self.bankBtn];
}

- (void)initSubFrames
{
    [self.walletBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake((KSCREEN_WIDTH - 50.f)/2.f, 48.f));
    }];
    
    [self.bankBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake((KSCREEN_WIDTH - 50.f)/2.f, 48.f));
    }];
    
}

- (void)btnCkiclk:(QMUIButton*)btn
{
    if(btn == self.walletBtn){
        self.walletBtn.backgroundColor = [UIColor qmui_colorWithHexString:@"#00FFD7"];
        [self.walletBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        self.bankBtn.backgroundColor =  [[UIColor qmui_colorWithHexString:@"#FFFFFF"]colorWithAlphaComponent:0.5f];
        [self.bankBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        if(self.clickBtnBlock && self.selecIndex != 0){
            self.selecIndex = 0;
            self.clickBtnBlock(0);
        }
        
    }else if (btn == self.bankBtn){
        self.bankBtn.backgroundColor = [UIColor qmui_colorWithHexString:@"#00FFD7"];
        [self.bankBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        self.walletBtn.backgroundColor = [[UIColor qmui_colorWithHexString:@"#FFFFFF"]colorWithAlphaComponent:0.5f];
        [self.walletBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        if(self.clickBtnBlock && self.selecIndex != 1){
            self.selecIndex = 1;
            self.clickBtnBlock(1);
        }
        
    }
}

#pragma mark - lazy
-(QMUIButton *)walletBtn{
    if(!_walletBtn){
        _walletBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        _walletBtn.cornerRadius = 24.f;
        _walletBtn.backgroundColor = [UIColor qmui_colorWithHexString:@"#00FFD7"];
        [_walletBtn setTitle:@"E-Wallet" forState:UIControlStateNormal];
        _walletBtn.titleLabel.font = FONT(17.f);
        [_walletBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [_walletBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_walletBtn addTarget:self action:@selector(btnCkiclk:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _walletBtn;
}

-(QMUIButton *)bankBtn{
    if(!_bankBtn){
        _bankBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        _bankBtn.cornerRadius = 24.f;
        _bankBtn.backgroundColor = [[UIColor qmui_colorWithHexString:@"#FFFFFF"]colorWithAlphaComponent:0.5f];
        [_bankBtn setTitle:@"Bank" forState:UIControlStateNormal];
        _bankBtn.titleLabel.font = FONT(17.f);
        [_bankBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_bankBtn addTarget:self action:@selector(btnCkiclk:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bankBtn;
}

@end
