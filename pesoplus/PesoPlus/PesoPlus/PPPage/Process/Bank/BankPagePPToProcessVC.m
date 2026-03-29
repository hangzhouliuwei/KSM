//
//  BankPagePPToProcessVC.m
// FIexiLend
//
//  Created by jacky on 2024/11/20.
//

#import "BankPagePPToProcessVC.h"
#import "PPUserTopViewTimeView.h"
#import "PPUserDefaultViewBankAlert.h"
#import "PPUserDefaultViewWalletItem.h"
#import "PPUserDefaultViewBankItem.h"

@interface BankPagePPToProcessVC ()
@property (nonatomic, strong) PPUserTopViewTimeView *timeView;

@property (nonatomic, strong) PPUserDefaultViewBankAlert *confirmAlert;
@property (nonatomic, strong) UIButton *walletItemConfigTheItemView;
@property (nonatomic, strong) UIButton *bankAccountToItemBtn;
@property (nonatomic, strong) PPUserDefaultViewWalletItem *waPPLetBagView;
@property (nonatomic, copy) NSArray *walletInfoListArray;
@property (nonatomic, strong) NSMutableDictionary *walletPPNiceToInfoData;
@property (nonatomic, strong) NSMutableDictionary *needSaveDicData;
@property (nonatomic, assign) NSInteger countingSecTimes;
@property (nonatomic, strong) NSMutableDictionary *bankPPNiceToInfoData;
@property (nonatomic, strong) PPUserDefaultViewBankItem *myItemView;
@property (nonatomic, strong) PPUserDefaultViewBankItem *bankBagToSomeItemView;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy) NSArray *bankInfoListArray;
@end

@implementation BankPagePPToProcessVC

- (void)saveResult:(NSDictionary *)dic  {
    NSMutableDictionary *needSaveDicData = [NSMutableDictionary dictionaryWithDictionary:dic];
    needSaveDicData[p_point] = [self track];
    kWeakself;
    [Http post:R_save_bank params:needSaveDicData success:^(Response *response) {
        if (response.success) {
            weakSelf.canDiss = YES;
            [Route ppTextjumpToWithProdutId:weakSelf.productId];
        }else {
            [PPMiddleCenterToastView show:response.msg];
        }
    } failure:^(NSError *error) {
    } showLoading:YES];

}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    if (!self.canDiss) {
        return;
    }
    UINavigationController *navigationController = self.navigationController;
    if (navigationController && ![navigationController.viewControllers containsObject:self]) {
        return;
    }
    
    if (navigationController) {
        NSMutableArray *viewControllers = [navigationController.viewControllers mutableCopy];
        [viewControllers removeObject:self];
        navigationController.viewControllers = [viewControllers copy];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.step = 4;
    self.index = 0;
    self.title = @"Withdrawal account";
    self.content.backgroundColor = rgba(247, 251, 255, 1);
    self.needSaveDicData = [NSMutableDictionary dictionary];
    [self loadData];
}

- (PPUserTopViewTimeView*)timeView {
    if(!_timeView) {
        kWeakself;
        _timeView = [[PPUserTopViewTimeView alloc] initWithFrame:CGRectMake(0, StatusBarHeight + 24, ScreenWidth, 60)];
        _timeView.finishBlock = ^{
            weakSelf.countingSecTimes = 0;
            weakSelf.timeView.hidden = YES;
            [weakSelf.timeView removeFromSuperview];
        };
        [_timeView showPPReallyRadiusBottom:16];
        [_timeView ppConfigAddViewShadow];
    }
    return _timeView;
}

- (void)walletAction {
    self.bankAccountToItemBtn.backgroundColor = rgba(212, 231, 255, 1);

    [self.view endEditing:YES];
    self.waPPLetBagView.hidden = NO;
    self.walletItemConfigTheItemView.selected = YES;
    self.bankAccountToItemBtn.selected = NO;
    self.walletItemConfigTheItemView.backgroundColor = MainColor;
    self.bankBagToSomeItemView.hidden = YES;
    self.index = 0;

}
- (void)loadUI {
    if (self.countingSecTimes > 0) {
        [self.navBar insertSubview:self.timeView atIndex:0];
        [self.timeView start:self.countingSecTimes];
    }
    
    _walletItemConfigTheItemView = [UIButton buttonWithType:UIButtonTypeCustom];
    _walletItemConfigTheItemView.frame = CGRectMake(12, 54, ScreenWidth/2 - 18, 38);
    [_walletItemConfigTheItemView setTitle:@"E-Wallet" forState:UIControlStateNormal];
    _walletItemConfigTheItemView.titleLabel.font = FontBold(16);
    _walletItemConfigTheItemView.backgroundColor = rgba(212, 231, 255, 1);

    [_walletItemConfigTheItemView setTitleColor:TextBlackColor forState:UIControlStateNormal];
    [_walletItemConfigTheItemView setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];

    [self.content addSubview:_walletItemConfigTheItemView];
    [_walletItemConfigTheItemView addTarget:self action:@selector(walletAction) forControlEvents:UIControlEventTouchUpInside];
    [_walletItemConfigTheItemView showAddToRadius:19];

    _bankAccountToItemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _bankAccountToItemBtn.frame = CGRectMake(12 + _walletItemConfigTheItemView.right, 54, ScreenWidth/2 - 18, 38);
    [_bankAccountToItemBtn setTitle:@"Bank" forState:UIControlStateNormal];

    _bankAccountToItemBtn.titleLabel.font = FontBold(16);
    _bankAccountToItemBtn.backgroundColor = rgba(212, 231, 255, 1);
    [_bankAccountToItemBtn setTitleColor:TextBlackColor forState:UIControlStateNormal];
    [_bankAccountToItemBtn setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
    [self.content addSubview:_bankAccountToItemBtn];
    
    [self walletAction];
    [_bankAccountToItemBtn addTarget:self action:@selector(bankAction) forControlEvents:UIControlEventTouchUpInside];
    [_bankAccountToItemBtn showAddToRadius:19];

    
    _waPPLetBagView = [[PPUserDefaultViewWalletItem alloc] initWithFrame:CGRectMake(0, _walletItemConfigTheItemView.bottom + 22, ScreenWidth, _walletInfoListArray.count*60 + 54 + 177) wallets:_walletInfoListArray data:_walletPPNiceToInfoData];
    [self.content addSubview:_waPPLetBagView];
    _waPPLetBagView.backgroundColor = UIColor.whiteColor;
    
    _bankBagToSomeItemView = [[PPUserDefaultViewBankItem alloc] initWithFrame:CGRectMake(0, _walletItemConfigTheItemView.bottom + 22, ScreenWidth, _waPPLetBagView.h) banks:_bankInfoListArray data:_bankPPNiceToInfoData];
    [self.content addSubview:_bankBagToSomeItemView];
    _bankBagToSomeItemView.hidden = YES;
    _bankBagToSomeItemView.backgroundColor = UIColor.whiteColor;

    
    UIButton *_next = [PPKingHotConfigView normalBtn:CGRectMake(34, self.view.h - SafeBottomHeight - 60, ScreenWidth - 68, 48) title:@"Apply" font:24];
    [self.view addSubview:_next];
    [_next showBottomShadow:COLORA(0, 0, 0, 0.2)];

    [_next addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nextActionClick)]];

}


- (void)loadData {
    NSDictionary *dic = @{
        p_product_id: self.productId,
    };
    kWeakself;
    [Http post:R_bank params:dic success:^(Response *response) {
        if (response.success) {
            weakSelf.walletPPNiceToInfoData = [NSMutableDictionary dictionaryWithDictionary:response.dataDic[p_wallet][p_filled]];
            weakSelf.bankInfoListArray = response.dataDic[p_bank][@"rsexsuctionCiopjko"];
            weakSelf.walletInfoListArray = response.dataDic[p_wallet][@"rsexsuctionCiopjko"];
            weakSelf.countingSecTimes = [response.dataDic[p_countdown] integerValue];
            weakSelf.bankPPNiceToInfoData = [NSMutableDictionary dictionaryWithDictionary:response.dataDic[p_bank][p_filled]];
            [weakSelf loadUI];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"======faild!");
    }];
}

- (void)nextActionClick {
    NSString *selectType = @"";
    NSString *account = @"";
    NSString *channel = @"";
    if (_index == 0) {
        channel = [_walletPPNiceToInfoData[p_channel] stringValue];
        if (channel.length == 0) {
            [PPMiddleCenterToastView show:@"Please select E-wallet"];
            return;
        }
        account = _waPPLetBagView.account;
        if (account.length == 0){
            [PPMiddleCenterToastView show:@"Please enter E-wallet Account"];
            return;
        }
        selectType = @"2";
        if (![account hasPrefix:@"0"]) {
            account = StrFormat(@"0%@", account);
        }
    }else if (_index == 1) {
        channel = [_bankPPNiceToInfoData[p_channel] stringValue];
        if (channel.length == 0) {
            [PPMiddleCenterToastView show:@"Please select Bank"];
            return;
        }
        account = _bankBagToSomeItemView.account;
        if (account.length == 0){
            [PPMiddleCenterToastView show:@"Please enter Bank Account"];
            return;
        }
        selectType = @"1";
    }

    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{p_product_id:notNull(self.productId), p_card_type:selectType}];
    dic[p_channel] = notNull(channel);
    dic[p_account] = account;
//    dic[p_point] = [self point];
    
    [self showSurePop:dic];
}


- (void)bankAction {
    self.walletItemConfigTheItemView.backgroundColor = rgba(212, 231, 255, 1);

    self.index = 1;
    self.walletItemConfigTheItemView.selected = NO;
    [self.view endEditing:YES];
    self.waPPLetBagView.hidden = YES;
    self.bankBagToSomeItemView.hidden = NO;
    self.bankAccountToItemBtn.backgroundColor = MainColor;
    self.bankAccountToItemBtn.selected = YES;
}

- (void)showSurePop:(NSDictionary *)dic {
    NSString *bank = @"";
    if (_index == 0) {
        bank = _waPPLetBagView.bankName;
    }else {
        bank = _bankBagToSomeItemView.bankName;
    }
    kWeakself;
    _confirmAlert = [[PPUserDefaultViewBankAlert alloc] initWithBank:bank account:dic[p_account]];
    _confirmAlert.confirmBlock = ^{
        [weakSelf saveResult:dic];
    };
    [_confirmAlert show];
}

@end
