//
//  BagVerifyBankVC.m
//  NewBag
//
//  Created by Jacky on 2024/4/8.
//

#import "BagVerifyBankVC.h"

#import "BagVerifyBasicCountDownView.h"
#import "BagVerifyBankPresenter.h"
#import "BagVerifyWanliuView.h"
#import "BagBankSegmentView.h"
#import "BagBankWalletView.h"
#import "BagBankBankView.h"
#import "BagBankModel.h"
#import "BagBankSaveConfirmView.h"
#import "BagNavBar.h"

@interface BagVerifyBankVC ()<BagVerifyBankProtocol>

@property (nonatomic, strong) BagVerifyBankPresenter *presenter;
@property (nonatomic, strong) BagVerifyBasicCountDownView *countDownView;
@property (nonatomic, strong) BagBankSegmentView *segmentView;
@property (nonatomic, strong) BagBankWalletView *walletView;
@property (nonatomic, strong) BagBankBankView *bankView;

@property (nonatomic, strong) UILabel *topTitle;
@property (nonatomic, strong) UILabel *bottomTitle;

@property (nonatomic, strong) UIButton *nextBtn;
@property(nonatomic, copy) NSString *startTime;
@property (nonatomic, strong) BagBankModel *model;
//@property (nonatomic, strong) BagNavBar *navBar;

@end

@implementation BagVerifyBankVC

- (void)viewDidLoad {
    self.leftTitle = @"Withdrawal account";
    [super viewDidLoad];
    self.startTime = [NSDate br_timestamp];
    [self setupUI];
    [self.presenter sendGetBankRequestWithProductId:self.productId];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [BagTrackHandleManager trackAppEventName:@"af_cc_page_card" withElementParam:@{}];
}
- (void)setupUI{
    self.view.backgroundColor = [UIColor qmui_colorWithHexString:@"#F4F7FA"];
    [self.view addSubview:self.countDownView];
    [self.view addSubview:self.topTitle];
    [self.view addSubview:self.segmentView];
    [self.view addSubview:self.walletView];
    [self.view addSubview:self.bankView];
    [self.view addSubview:self.nextBtn];

    [self.countDownView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(219);
    }];
    [self.topTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.countDownView.mas_bottom).offset(18);
        make.left.mas_equalTo(27);
        make.right.mas_equalTo(-27);
    }];
    [self.segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topTitle.mas_bottom).offset(20);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(48);
    }];
    [self.segmentView layoutIfNeeded];
    [self.walletView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.segmentView.mas_bottom).offset(10);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-44);
    }];
    [self.bankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.segmentView.mas_bottom).offset(10);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-44);
    }];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(44);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
}
- (void)onNextClick{
    [self.view endEditing:YES];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *textStr = @"";
    NSString  *numberStr = @"";
    if(self.segmentView.selecctIndex == 0){
        if(!self.walletView.selectModel){
            [self showToast:@"select your recipient E-wallet" duration:1.5];
            return;
        }
        if([self.walletView.walletText br_isBlankString]){
            [self showToast:@"please enter your e-wallet account" duration:1.5];
            return;
        }
        dic[@"conniptionF"] = @"2";
        dic[@"autoinfectionF"] = @(self.walletView.selectModel.franticF);
        dic[@"fetoproteinF"] = NotNull(self.walletView.walletText);
        textStr = self.walletView.selectModel.antineoplastonF;
        numberStr = self.walletView.walletText;
        [BagTrackHandleManager trackAppEventName:@"af_cc_click_card" withElementParam:@{@"type": @"wallet"}];

    }else if (self.segmentView.selecctIndex == 1){
        if(!self.bankView.selectModel){
            [self showToast:@"select your recipient bank" duration:1.5];
            return;
        }
        if([self.bankView.bankText br_isBlankString]){
            [self showToast:@"please enter your bank account number" duration:1.5];
            return;
        }
        
        dic[@"conniptionF"] = @"1";
        dic[@"autoinfectionF"] = @(self.bankView.selectModel.franticF);
        dic[@"fetoproteinF"] = NotNull(self.bankView.bankText);
        textStr = self.bankView.selectModel.antineoplastonF;
        numberStr = self.bankView.bankText;
        [BagTrackHandleManager trackAppEventName:@"af_cc_click_card" withElementParam:@{@"type": @"bank"}];
    }
    
    NSDictionary *pointDic = @{
                                @"calcographyF": @(self.startTime.doubleValue),
                                @"biolysisF": NotNull(self.productId),
                                @"jactancyF":@"26",
                                @"hateworthyF":@(BagLocationManager.shareInstance.latitude),
                                @"apoenzymeF":@([NSDate br_timestamp].doubleValue),
                                @"clapperclawF": NotNull(NSObject.getIDFV),
                                @"reinhabitF":@(BagLocationManager.shareInstance.longitude),
                               };
    dic[@"point"] = pointDic;
    dic[@"vachelF"]= NotNull(self.productId);
    if([textStr br_isBlankString] || [numberStr br_isBlankString])return;
    BagBankSaveConfirmView *confirm = [BagBankSaveConfirmView createView];
    confirm.bank = textStr;
    confirm.bankNumber = numberStr;
    WEAKSELF
    confirm.confirmBlock = ^{
        STRONGSELF
        [strongSelf.presenter sendSaveContactRequestWithDic:dic productId:strongSelf.productId];
        [BagTrackHandleManager trackAppEventName:@"af_cc_start_card" withElementParam:@{}];

    };
    confirm.cancelBlock = ^{
        [BagTrackHandleManager trackAppEventName:@"af_cc_click_card_cancel" withElementParam:@{}];

    };
    [confirm show];
}
#pragma mark - BagVerifyBankProtocol
- (void)updateUIWithModel:(BagBankModel *)model
{
    _model = model;
    self.countDownView.countTime = model.analectaF;
    [self.walletView updateUIWithModel:model.fullnessF];
    [self.bankView updateUIWithModel:model.begirdF];
}
- (void)jumpNextPageWithProductId:(NSString *)product_id nextUrl:(NSString *)url
{
    [[BagRouterManager shareInstance] routeWithUrl:[url br_pinProductId:product_id]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeViewController];
    });
}
- (void)saveBankSucceed
{
    [BagTrackHandleManager trackAppEventName:@"af_cc_success_card" withElementParam:@{}];
}
#pragma mark - nav back
- (void)backClick
{
    if([QMUIHelper isKeyboardVisible]){
        [self.view endEditing:YES];
    }
    [self showWanliu];
}
- (void)showWanliu{
    BagVerifyWanliuView *view = [BagVerifyWanliuView createAlert];
    view.confirmBlock = ^{
        [BagTrackHandleManager trackAppEventName:@"af_cc_page_card_exit" withElementParam:@{}];
        [self.navigationController popViewControllerAnimated:YES];
    };
    [view showWithType:VerifyWithdrawType];
}
///监听左滑返回
- (BOOL)shouldPopViewControllerByBackButtonOrPopGesture:(BOOL)byPopGesture
{
    if([QMUIHelper isKeyboardVisible]){
        [self.view endEditing:YES];
    }
    [self showWanliu];
    return NO;
}
#pragma mark - getter
- (BagVerifyBankPresenter *)presenter
{
    if (!_presenter) {
        _presenter = [BagVerifyBankPresenter new];
        _presenter.delegate= self;
    }
    return _presenter;
}
- (BagVerifyBasicCountDownView *)countDownView
{
    if (!_countDownView) {
        _countDownView = [BagVerifyBasicCountDownView createView];
        WEAKSELF
        _countDownView.countDownEndBlock = ^{
            STRONGSELF
            [strongSelf.countDownView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.mas_equalTo(0);
                make.height.mas_equalTo(kNavBarAndStatusBarHeight + 20);
            }];
        };
        [_countDownView hiddenStep];
    }
    return _countDownView;
}
- (UIButton *)nextBtn
{
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _nextBtn.titleLabel.textColor = [UIColor whiteColor];
        [_nextBtn setTitle:@"Next" forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(onNextClick) forControlEvents:UIControlEventTouchUpInside];
        [_nextBtn br_setGradientColor:[UIColor qmui_colorWithHexString:@"#205EAC"] toColor:[UIColor qmui_colorWithHexString:@"#154685"] direction:BRDirectionTypeLeftToRight bounds:CGRectMake(0, 0, kScreenWidth - 26, 44)];
        [_nextBtn br_setRoundedCorners:UIRectCornerAllCorners withRadius:CGSizeMake(4, 4) viewRect:CGRectMake(0, 0, kScreenWidth - 28, 44)];
    }
    return _nextBtn;
}
- (BagBankSegmentView *)segmentView
{
    if (!_segmentView) {
        _segmentView = [BagBankSegmentView createView];
        [_segmentView setSelecctIndex:0];
        WEAKSELF
        _segmentView.clickBlock = ^(NSInteger index) {
            STRONGSELF
            if (index) {
                strongSelf.bankView.hidden = NO;
                strongSelf.walletView.hidden = YES;
            }else{
                strongSelf.bankView.hidden = YES;
                strongSelf.walletView.hidden = NO;
            }
        };
    }
    return _segmentView;
}
- (BagBankWalletView *)walletView
{
    if (!_walletView) {
        _walletView = [[BagBankWalletView alloc] initWithFrame:CGRectZero];
    }
    return _walletView;
}
- (BagBankBankView *)bankView
{
    if (!_bankView) {
        _bankView = [BagBankBankView createView];
        _bankView.hidden = YES;
    }
    return _bankView;
}
-(UILabel *)topTitle
{
    if (!_topTitle) {
        _topTitle = [[UILabel alloc] qmui_initWithFont:[UIFont systemFontOfSize:14] textColor:[UIColor qmui_colorWithHexString:@"#333333"]];
        _topTitle.numberOfLines = 0;
        _topTitle.text = @"You can use E-wallet / bank account / over the counter to repay the bills.";
    }
    return _topTitle;
}
-(UILabel *)bottomTitle
{
    if (!_bottomTitle) {
        _bottomTitle = [[UILabel alloc] qmui_initWithFont:[UIFont systemFontOfSize:11] textColor:[UIColor qmui_colorWithHexString:@"#949DA6"]];
        _bottomTitle.numberOfLines = 0;
        _bottomTitle.text = @"Please confirm the account belongs to yourself and be correct, it will be used as a receipt account to receice the funds.";
    }
    return _bottomTitle;
}
@end
