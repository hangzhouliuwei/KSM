//
//  PUBBankViewController.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/10.
//

#import "PUBBankViewController.h"
#import "PUBBasicCountDownView.h"
#import "PUBLoanViewModel.h"
#import "PUBWanLiuView.h"

#import "PUBBankViewModel.h"
#import "PUBBankModel.h"
#import "PUBWalletAndBandView.h"
#import "PUBWalletView.h"

#import "PUBBankPopView.h"
#import "PUBBankView.h"

@interface PUBBankViewController ()
@property(nonatomic, strong) PUBBasicCountDownView *downView;
@property(nonatomic, strong) UIView *backView;
@property(nonatomic, strong) PUBWalletAndBandView *chooseView;
@property(nonatomic, strong) PUBWalletView *walletView;
@property(nonatomic, strong) PUBBankView *bankView;
@property(nonatomic, strong) PUBWanLiuView *wanLiuView;
@property(nonatomic, strong) PUBLoanViewModel *loanViewModel;
@property(nonatomic, strong) QMUIButton *nextBtn;
@property(nonatomic, strong) PUBBankViewModel *viewModel;
@property(nonatomic, strong) PUBBankModel *model;
@property(nonatomic, copy) NSString *startTime;
@end

@implementation PUBBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor qmui_colorWithHexString:@"#1E1E2B"];
    self.contentView.backgroundColor = [UIColor qmui_colorWithHexString:@"#1E1E2B"];
    self.navBar.backgroundColor = [UIColor qmui_colorWithHexString:@"#1E1E2B"];
    [self.navBar showtitle:@"Withdrawal accout" isLeft:YES];
    [self creatUI];
    [self reponseData];
    self.startTime = [PUBTools getTime];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [PUBTrackHandleManager trackAppEventName:@"af_pub_page_card" withElementParam:@{}];
    
}

- (void)backBtnClick:(UIButton *)btn
{
    if([QMUIHelper isKeyboardVisible]){
        [self.view endEditing:YES];
    }
    [self.wanLiuView show:WithdrawType];
}

///监听左滑返回
- (BOOL)shouldPopViewControllerByBackButtonOrPopGesture:(BOOL)byPopGesture
{
    if([QMUIHelper isKeyboardVisible]){
        [self.view endEditing:YES];
    }
    [self.wanLiuView show:WithdrawType];
    return NO;
}

- (void)creatUI
{
    self.contentView.height = KSCREEN_HEIGHT - self.navBar.bottom;
    [self.contentView addSubview:self.downView];
    [self.contentView addSubview:self.chooseView];
    [self.contentView addSubview:self.backView];
    [self.contentView addSubview:self.nextBtn];
    [self.backView addSubview:self.walletView];
    [self.backView addSubview:self.bankView];
}

- (void)reponseData
{
    NSDictionary *dic = @{
                         @"perikaryon_eg": NotNull(self.productId)
                         };
    WEAKSELF
    [self.viewModel getBindCardInitView:self.view dic:dic finish:^(PUBBankModel * _Nonnull bankModel) {
        STRONGSELF
        strongSelf.model = bankModel;
        [strongSelf updataCountDown:bankModel.sdlkfjl_eg];
        [strongSelf.walletView updataModel:bankModel.valued_eg];
        [strongSelf.bankView updataModel:bankModel.wilt_eg];
        if(bankModel.wilt_eg.megrim_eg.rbds_eg && bankModel.wilt_eg.megrim_eg.jeanne_eg != 0){
            [strongSelf.chooseView selecIndexBtn:1];
        }
    } failture:^{
        
    }];
    
}


#pragma mark - 更新倒计时
- (void)updataCountDown:(NSInteger)countDown
{
    
    if(countDown > 0){
        self.downView.countTime = countDown;
        self.downView.hidden = NO;
        self.downView.height = 76.f;
        self.chooseView.Y = self.downView.bottom + 14.f;
        self.backView.y = self.chooseView.bottom + 12.f;
        self.backView.height = KSCREEN_HEIGHT - self.chooseView.bottom - 12.f;
        self.walletView.height =  self.backView.height - self.nextBtn.height -  KSafeAreaBottomHeight - self.navBar.bottom;
        self.bankView.height = self.backView.height - self.nextBtn.height -  KSafeAreaBottomHeight - self.navBar.bottom;
        return;
    }
    
    self.downView.countTime = 0;
    self.downView.hidden = YES;
    self.downView.height = 0;
    self.chooseView.Y = 8.f;
    self.backView.y = self.chooseView.bottom + 14.f;
    self.backView.height = KSCREEN_HEIGHT - self.chooseView.bottom - 14.f;
    self.walletView.height =  self.backView.height - self.nextBtn.height -  KSafeAreaBottomHeight - self.navBar.bottom;
    self.bankView.height = self.backView.height - self.nextBtn.height -  KSafeAreaBottomHeight - self.navBar.bottom;
}

- (void)nexBtnClick
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *textStr = @"";
    NSString  *numberStr = @"";
    if(self.chooseView.selecIndex == 0){
        if(!self.walletView.selecModel){
            [PUBTools showToast:@"select your recipient E-wallet"];
            return;
        }
        if([PUBTools isBlankString:self.walletView.walletText]){
            [PUBTools showToast:@"please enter your e-wallet account"];
            return;
        }
        dic[@"grocer_eg"] = @"2";
        dic[@"jeanne_eg"] = @(self.walletView.selecModel.quilting_eg);
        dic[@"rbds_eg"] = NotNull(self.walletView.walletText);
        textStr = self.walletView.selecModel.rhodo_eg;
        numberStr = self.walletView.walletText;
    }else if (self.chooseView.selecIndex == 1){
        if(!self.bankView.selecModel){
            [PUBTools showToast:@"select your recipient bank"];
            return;
        }
        if([PUBTools isBlankString:self.bankView.bankText]){
            [PUBTools showToast:@"please enter your bank account number"];
            return;
        }
        
        dic[@"grocer_eg"] = @"1";
        dic[@"jeanne_eg"] = @(self.bankView.selecModel.quilting_eg);
        dic[@"rbds_eg"] = NotNull(self.bankView.bankText);
        textStr = self.bankView.selecModel.rhodo_eg;
        numberStr = self.bankView.bankText;
        
    }
    
    NSDictionary *pointDic = @{
                                @"testudinal_eg": @(self.startTime.doubleValue),
                                @"grouse_eg": NotNull(self.productId),
                                @"classer_eg":@"26",
                                @"neuroleptic_eg":@(PUBLocation.latitude),
                                @"milligramme_eg":@([PUBTools getTime].doubleValue),
                                @"infortune_eg": NotNull(NSObject.getIDFV),
                                @"nonrecurring_eg":@(PUBLocation.longitude),
                               };
    dic[@"point"] = pointDic;
    dic[@"perikaryon_eg"]= NotNull(self.productId);
    if([PUBTools isBlankString:textStr] || [PUBTools isBlankString:numberStr])return;
    PUBBankPopView *popView = [[PUBBankPopView alloc] initWithWord:@[textStr , numberStr]];
    [popView show];
    WEAKSELF
    popView.confirmBlock = ^(NSArray * _Nonnull arr) {
        STRONGSELF
        [strongSelf nexBtnCkickRequestDic:dic];
        [PUBTrackHandleManager trackAppEventName:@"af_pub_click_card" withElementParam:@{@"type": self.chooseView.selecIndex == 1 ? @"wallet" : @"bank"}];
    };
    popView.cancelBlock = ^{
        [PUBTrackHandleManager trackAppEventName:@"af_pub_click_card_cancel" withElementParam:@{}];
    };
}

- (void)nexBtnCkickRequestDic:(NSDictionary*)dic
{
    
    [PUBTrackHandleManager trackAppEventName:@"af_pub_start_card" withElementParam:@{}];
    WEAKSELF
    [self.viewModel getSaveBindCardView:self.view dic:dic finish:^(NSDictionary * _Nonnull dic) {
        [PUBTrackHandleManager trackAppEventName:@"af_pub_success_card" withElementParam:@{}];
        STRONGSELF
        if(User.is_aduit){
            [strongSelf removeViewController];
            return;
        }
        NSString *nextStr = [NSString stringWithFormat:@"%@",dic[@"nonparticipant_eg"][@"excuse"]];
        if(![PUBTools isBlankString:nextStr]){
            [PUBRouteManager routeWitheNextPage:nextStr productId:NotNull(strongSelf.productId)];
            [strongSelf removeViewController];
            return;
        }
        [strongSelf productPush];
    } failture:^{
        
    }];
    
}

-(void)productPush
{
    NSDictionary *dic = @{
                          @"order_no":NotNull(Config.hypokinesis_eg),
                          @"furnisher_eg":@"dddd",
                          @"billyboy_eg":@"houijhyus",
                         };
    WEAKSELF
    [self.loanViewModel getproductPushView:self.view dic:dic finish:^(NSString * _Nonnull url) {
        STRONGSELF
        [PUBRouteManager routeWitheNextPage:url productId:@""];
        [strongSelf removeViewController];
    } failture:^{
        
    }];
}

- (void)removeViewController
{
    NSMutableArray *VCArr = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [VCArr removeObject:self];
    self.navigationController.viewControllers =VCArr;
}

#pragma mark - lazy
- (PUBBasicCountDownView *)downView{
    if(!_downView){
        _downView = [[PUBBasicCountDownView alloc] initWithFrame:CGRectMake(20.f, 16.f, KSCREEN_WIDTH - 40.f, 76.f)];
        _downView.hidden = YES;
        WEAKSELF
        _downView.countDownEndBlock = ^{
          STRONGSELF
            [strongSelf updataCountDown:0];
        };
    }
    return _downView;
}


- (QMUIButton *)nextBtn{
    if(!_nextBtn){
        _nextBtn = [QMUIButton buttonWithType:UIButtonTypeSystem];
        [_nextBtn addTarget:self action:@selector(nexBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _nextBtn.frame = CGRectMake(32.f,self.contentView.height - KSafeAreaBottomHeight - 48.f, KSCREEN_WIDTH - 64.f, 48.f);
        _nextBtn.backgroundColor = [UIColor qmui_colorWithHexString:@"#00FFD7"];
        _nextBtn.cornerRadius = 24.f;
        _nextBtn.titleLabel.font = FONT(20.f);
        [_nextBtn setTitle:@"Next" forState:UIControlStateNormal];
        [_nextBtn setTitleColor:[UIColor qmui_colorWithHexString:@"#13062A"] forState:UIControlStateNormal];
    }
    return _nextBtn;
}

- (PUBWalletAndBandView *)chooseView{
    if(!_chooseView){
        _chooseView = [[PUBWalletAndBandView alloc] initWithFrame:CGRectMake(20.f, self.downView.bottom + 14.f, KSCREEN_WIDTH - 40.f, 48.f)];
        WEAKSELF
        _chooseView.clickBtnBlock = ^(NSInteger index) {
            STRONGSELF
            if(index == 0){
                strongSelf.walletView.hidden = NO;
                strongSelf.bankView.hidden = YES;
            }else if (index == 1){
                strongSelf.walletView.hidden = YES;
                strongSelf.bankView.hidden = NO;
            }
        };
    }
    return _chooseView;
}

- (UIView *)backView{
    if(!_backView){
        _backView = [[UIView alloc] qmui_initWithSize:CGSizeMake(KSCREEN_WIDTH, KSCREEN_HEIGHT - self.chooseView.bottom - 12.f)];
        _backView.frame = CGRectMake(0, self.chooseView.bottom + 12.f, KSCREEN_WIDTH, KSCREEN_HEIGHT - self.chooseView.bottom - 12.f);
        [_backView showTopRarius: 24.f];
        _backView.backgroundColor = [UIColor qmui_colorWithHexString:@"#313848"];
    }
    return _backView;
}

- (PUBWalletView *)walletView{
    if(!_walletView){
        _walletView = [[PUBWalletView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, self.backView.height - self.nextBtn.height - 136.f)];
        _walletView.backgroundColor = [UIColor qmui_colorWithHexString:@"#313848"];
    }
    
    return _walletView;
}

- (PUBBankView *)bankView{
    if(!_bankView){
        _bankView = [[PUBBankView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, self.backView.height - self.nextBtn.height - 136.f)];
        _bankView.backgroundColor = [UIColor qmui_colorWithHexString:@"#313848"];
        _bankView.hidden =  YES;
    }
    return _bankView;
}

- (PUBWanLiuView *)wanLiuView{
    if(!_wanLiuView){
        _wanLiuView = [[PUBWanLiuView alloc] init];
        WEAKSELF
        _wanLiuView.confirmBlock = ^{
            STRONGSELF
            [strongSelf.wanLiuView hide];
            [strongSelf.navigationController qmui_popViewControllerAnimated:YES completion:nil];
            [PUBTrackHandleManager trackAppEventName:@"af_pub_page_card_exit" withElementParam:@{}];
        };
    }
    return _wanLiuView;
}

-(PUBLoanViewModel *)loanViewModel{
    if(!_loanViewModel){
        _loanViewModel = [[PUBLoanViewModel alloc] init];
    }
    return _loanViewModel;
}

- (PUBBankViewModel *)viewModel{
    if(!_viewModel){
        _viewModel = [[PUBBankViewModel alloc] init];
    }
    return _viewModel;
}

@end
