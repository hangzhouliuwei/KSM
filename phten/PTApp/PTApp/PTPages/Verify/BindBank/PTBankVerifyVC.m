//
//  PTBankVerifyVC.m
//  PTApp
//
//  Created by Jacky on 2024/8/21.
//

#import "PTBankVerifyVC.h"
#import "PTVerifyCountDownView.h"
#import "PTBankVerifyView.h"
#import "PTBankPresenter.h"
#import "PTBankModel.h"
#import "PTBankConfirmView.h"
#import "PTVerifyPleaseLeftView.h"
@interface PTBankVerifyVC ()<PTBankProtocol>
@property (nonatomic, strong) PTBankVerifyView *bankView;

@property (nonatomic, strong) PTVerifyCountDownView *countDownView;
@property (nonatomic, strong) UIButton *saveBtn;
@property (nonatomic, strong) PTBankPresenter *presenter;
@property (nonatomic, strong) PTBankModel *model;

@end

@implementation PTBankVerifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showtitle:@"Withdrawal account" isLeft:NO disPlayType:PTDisplayTypeBlack];
    [self.view addSubview:self.countDownView];
    [self.view addSubview:self.bankView];
    [self.view addSubview:self.saveBtn];
   
    [self.countDownView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(kNavBarAndStatusBarHeight+20);
        make.height.mas_equalTo((kScreenWidth-32)/343*164.f);
    }];
    [self.bankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.countDownView.mas_bottom).offset(18);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
//        make.height.mas_equalTo((kScreenWidth-32)/343*480);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-50);
    }];
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(44);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
    [self.presenter pt_sendGetBankRequest:self.productId];
    // Do any additional setup after loading the view.
}
#pragma mark - nav back
- (void)leftBtnClick
{
    [self showWanliu];
}

- (void)showWanliu{
    if([QMUIHelper isKeyboardVisible]){
        [self.view endEditing:YES];
    }
    PTVerifyPleaseLeftView *view = [[PTVerifyPleaseLeftView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    view.cancelBlock = ^{
        
    };
    view.confirmBlock = ^{
        [self.navigationController qmui_popViewControllerAnimated:YES completion:^{}];
    };
    view.step = 5;
    [view show];
    
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
#pragma mark - action
- (void)onNextClick{
    [self.view endEditing:YES];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *textStr = @"";
    NSString  *numberStr = @"";
    if(self.bankView.selecctIndex == 0){
        if(!self.bankView.walletView.selectModel){
            [self showToast:@"Please select E-wallet" duration:2];
            return;
        }
        if([PTNotNull(self.bankView.walletView.walletText) br_isBlankString]){
            [self showToast:@"Please enter E-wallet Account" duration:2];
            return;
        }
        dic[@"cetenNc"] = @"2";
        dic[@"bltenthelyNc"] = @(self.bankView.walletView.selectModel.retengnNc);
        dic[@"ovtenrcutNc"] = PTNotNull(self.bankView.walletView.walletText);
        textStr = self.bankView.walletView.selectModel.uptenornNc;
        numberStr = self.bankView.walletView.walletText;
//        [BagTrackHandleManager trackAppEventName:@"af_cc_click_card" withElementParam:@{@"type": @"wallet"}];

    }else if (self.bankView.selecctIndex == 1){
        if(!self.bankView.bankView.selectModel){
            [self showToast:@"Please select Bank" duration:2];
            return;
        }
        if([PTNotNull(self.bankView.bankView.bankText) br_isBlankString]){
            [self showToast:@"Please enter Bank Account" duration:2];
            return;
        }
        
        dic[@"cetenNc"] = @"1";
        dic[@"bltenthelyNc"] = @(self.bankView.bankView.selectModel.retengnNc);
        dic[@"ovtenrcutNc"] = PTNotNull(self.bankView.bankView.bankText);
        textStr = self.bankView.bankView.selectModel.uptenornNc;
        numberStr = self.bankView.bankView.bankText;
//        [BagTrackHandleManager trackAppEventName:@"af_cc_click_card" withElementParam:@{@"type": @"bank"}];
    }
    
    NSDictionary *pointDic = @{
                                @"detenamatoryNc": @(self.startTime.doubleValue),
                                @"mutenniumNc": PTNotNull(self.productId),
                                @"hytenrarthrosisNc":@"26",
                                @"botenomofoNc":PTNotNull([PTLocationManger sharedPTLocationManger].latitude),
                                @"untenulyNc":@([NSDate br_timestamp].doubleValue),
                                @"catencotomyNc": PTNotNull([PTDeviceInfo idfv]),
                                @"untenevoutNc":PTNotNull([PTLocationManger sharedPTLocationManger].longitude),
                               };
    dic[@"point"] = pointDic;
    dic[@"litenetusNc"]= PTNotNull(self.productId);
    if([textStr br_isBlankString] || [numberStr br_isBlankString])return;
    PTBankConfirmView *confirm = [[PTBankConfirmView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    confirm.bank = textStr;
    confirm.bankNumber = numberStr;
    confirm.confirmBlock = ^{
        [self.presenter pt_sendSaveBankInfoRequest:dic productId:self.productId];
    };
    confirm.cancelBlock = ^{
        
    };
    [confirm show];
}
#pragma mark - presenter代理负责跳转页面及其他vc适合处理的事情
- (void)updateUIWithModel:(PTBankModel *)model
{
    _model = model;
    _countDownView.countTime = model.pateneographerNc;
    _countDownView.hidden = NO;
    if (model.pateneographerNc > 0) {
        _bankView.hidden = NO;
    }
    [self.bankView updateUI:model];
    
}
- (void)router:(NSString *)url
{
    [[PTAuthentRouterManager sharedPTAuthentRouterManager] routeWithUrl:url];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeViewController];
    });
}
- (void)saveIdentifySucceed
{
}

#pragma mark - getter
- (PTBankPresenter *)presenter
{
    if (!_presenter) {
        _presenter = [PTBankPresenter new];
        _presenter.delegate = self;
    }
    return _presenter;
}
- (PTBankVerifyView *)bankView
{
    if (!_bankView) {
        _bankView = [[PTBankVerifyView alloc] initWithFrame:CGRectZero];
        _bankView.selecctIndex = 0;
        _bankView.hidden = YES;
        _bankView.clickBlock = ^(NSInteger index) {
            
        };
    }
    return _bankView;
}
- (UIButton *)saveBtn
{
    if (!_saveBtn) {
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _saveBtn.titleLabel.textColor = [UIColor whiteColor];
        [_saveBtn setTitle:@"Next" forState:UIControlStateNormal];
        [_saveBtn addTarget:self action:@selector(onNextClick) forControlEvents:UIControlEventTouchUpInside];
        _saveBtn.backgroundColor = PTUIColorFromHex(0xcdf76e);
        [_saveBtn br_setRoundedCorners:UIRectCornerAllCorners withRadius:CGSizeMake(22, 22) viewRect:CGRectMake(0, 0, kScreenWidth - 28, 44)];
    }
    return _saveBtn;
}
- (PTVerifyCountDownView *)countDownView
{
    if (!_countDownView) {
        _countDownView = [[PTVerifyCountDownView alloc] initWithFrame:CGRectZero];
        _countDownView.step = 5;
        _countDownView.hidden = YES;
        WEAKSELF
        _countDownView.endBlock = ^{
            [weakSelf.countDownView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(0);
            }];
            [UIView animateWithDuration:0.3 animations:^{
                [weakSelf.view layoutIfNeeded];
            }];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                weakSelf.bankView.hidden = NO;
            });
            [weakSelf.countDownView hiddenAllSub];
        };
        [_countDownView hiddenStep];
    }
    return _countDownView;
}
- (void)dealloc{
    
}

@end
