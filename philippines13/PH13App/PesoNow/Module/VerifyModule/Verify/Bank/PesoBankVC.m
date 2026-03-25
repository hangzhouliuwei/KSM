//
//  PesoBankVC.m
//  PesoApp
//
//  Created by Jacky on 2024/9/16.
//

#import "PesoBankVC.h"
#import "PesoVerifyStepView.h"
#import "PesoBankViewModel.h"
#import "PesoBankModel.h"
#import "PesoBankCredictView.h"
#import "PesoBankConfirmView.h"
#import "PesoHomeViewModel.h"
#import "PesoVerifyWanliuView.h"
@interface PesoBankVC ()
@property (nonatomic, strong) PesoVerifyStepView *stepView;
@property (nonatomic, strong) QMUIButton *saveBtn;
@property (nonatomic, strong) PesoBankViewModel *viewModel;
@property (nonatomic, strong) PesoBankModel *model;

@property (nonatomic, strong) PesoBankCredictView *bankView;

@end

@implementation PesoBankVC

- (void)viewDidLoad {
    [super viewDidLoad];
    WEAKSELF
    [self.viewModel loadGetBankRequest:self.productId callback:^(id  _Nonnull model) {
        weakSelf.model = model;
        weakSelf.stepView.hidden = NO;
        weakSelf.stepView.countTime = weakSelf.model.pateneographerNc;
        [weakSelf.bankView updateUI:model];
        if ( weakSelf.model.pateneographerNc > 0) {
            weakSelf.bankView.hidden = NO;
        }
    }];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self bringNavToFront];
}
- (void)backClickAction
{
    [self wanliuAlert];
}
- (void)wanliuAlert{
    if([QMUIHelper isKeyboardVisible]){
        [self.view endEditing:YES];
    }
    PesoVerifyWanliuView *alert = [[PesoVerifyWanliuView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    alert.step = 5;
    alert.confirmBlock = ^{
        [self.navigationController qmui_popViewControllerAnimated:YES completion:^{
            
        }];
    };
    [alert show];
}
///监听左滑返回
- (BOOL)shouldPopViewControllerByBackButtonOrPopGesture:(BOOL)byPopGesture
{
    [self wanliuAlert];
    return NO;
}
- (void)createUI
{
    UIImageView *backImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"basic_bg"]];
    backImage.contentMode = UIViewContentModeScaleAspectFill;
    backImage.frame = CGRectMake(0, 0, kScreenWidth, 260);
    [self.view addSubview:backImage];
    
    UIImageView *titleImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bank_title"]];
    titleImage.contentMode = UIViewContentModeScaleAspectFit;
    titleImage.frame = CGRectMake(0, kNavBarAndStatusBarHeight - 20, 228, 72);
    titleImage.centerX = kScreenWidth/2;
    [backImage addSubview:titleImage];
    WEAKSELF
    _stepView = [[PesoVerifyStepView alloc] initWithFrame:CGRectMake(0, titleImage.bottom-5, kScreenWidth, kScreenWidth/375*142)];
    _stepView.endBlock = ^{
        weakSelf.stepView.hidden = YES;
        weakSelf.stepView.height = 0;
        weakSelf.bankView.frame = CGRectMake(0, weakSelf.stepView.bottom, kScreenWidth, kScreenHeight - weakSelf.stepView.bottom  - kBottomSafeHeight - 50 - 20 );
        [weakSelf.bankView setNeedsLayout];
        weakSelf.bankView.hidden = NO;
    };
    _stepView.backgroundColor = [UIColor clearColor];
    _stepView.hidden = YES;
    [self.view addSubview:_stepView];
    _stepView.step = 5;
    
    _bankView = [[PesoBankCredictView alloc] initWithFrame:CGRectMake(0, _stepView.bottom - 2, kScreenWidth, kScreenHeight - _stepView.bottom  - kBottomSafeHeight - 50 - 20 )];
    _bankView.hidden = YES;
    [self.view addSubview:_bankView];
    
    QMUIButton *saveBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake(30, kScreenHeight - kBottomSafeHeight - 50 - 20, kScreenWidth-60, 50);
    [saveBtn setTitle:@"Next" forState:UIControlStateNormal];
    saveBtn.backgroundColor = ColorFromHex(0xFCE815);
    saveBtn.titleLabel.font = PH_Font_B(18);
    [saveBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    saveBtn.layer.cornerRadius = 25;
    saveBtn.layer.masksToBounds = YES;
    [saveBtn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
    _saveBtn= saveBtn;
}
- (void)nextAction{
    [self.view endEditing:YES];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *textStr = @"";
    NSString  *numberStr = @"";
    if(self.bankView.selecctIndex == 0){
        if(!self.bankView.walletView.selectModel){
            [PesoUtil showToast:@"Please select E-wallet"];
            return;
        }
        if(br_isEmptyObject(NotNil(self.bankView.walletView.walletText))){
            [PesoUtil showToast:@"Please enter E-wallet Account"];
            return;
        }
        dic[@"ceNcthirteen"] = @"2";
        dic[@"blththirteenelyNc"] = @(self.bankView.walletView.selectModel.regnthirteenNc);
        dic[@"ovrcthirteenutNc"] = NotNil(self.bankView.walletView.walletText);
        textStr = self.bankView.walletView.selectModel.uporthirteennNc;
        numberStr = self.bankView.walletView.walletText;
    }else if (self.bankView.selecctIndex == 1){
        if(!self.bankView.bankView.selectModel){
            [PesoUtil showToast:@"Please select Bank"];
            return;
        }
        if(br_isEmptyObject(self.bankView.bankView.bankText)){
            [PesoUtil showToast:@"Please enter Bank Account"];
            return;
        }else {
            if (self.bankView.bankView.bankText.length < 10) {
                [PesoUtil showToast:@"The length of the bank card number cannot be less than 10 digits"];
                return;
            }
        }
        
        dic[@"ceNcthirteen"] = @"1";
        dic[@"blththirteenelyNc"] = @(self.bankView.bankView.selectModel.regnthirteenNc);
        dic[@"ovrcthirteenutNc"] = NotNil(self.bankView.bankView.bankText);
        textStr = self.bankView.bankView.selectModel.uporthirteennNc;
        numberStr = self.bankView.bankView.bankText;
    }
    dic[@"point"] = [self getaSomeApiParam:self.productId sceneType:@"26"];
    dic[@"lietthirteenusNc"]= NotNil(self.productId);
    if(br_isEmptyObject(textStr) || br_isEmptyObject(numberStr))return;
    PesoBankConfirmView *confirm = [[PesoBankConfirmView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    confirm.bank = textStr;
    confirm.bankNumber = numberStr;
    WEAKSELF
    confirm.confirmBlock = ^{
        [self.viewModel loadSaveBankInfoRequest:dic productId:self.productId callback:^(NSString *url) {
//            if (PesoUserCenter.sharedPesoUserCenter.isaduit) {
//                [self removeViewController];
//                return;
//            }
            if (br_isNotEmptyObject(url)) {
                [self routerUrl:[url pinProductId:self.productId]];
                return;
            }
            PesoHomeViewModel *homeVM = [PesoHomeViewModel new];
            [homeVM loadPushRequestWithOrderId:PesoUserCenter.sharedPesoUserCenter.order product_id:weakSelf.productId callback:^(NSString *nexturl) {
                if (br_isNotEmptyObject(nexturl)) {
                    [self routerUrl:[nexturl pinProductId:self.productId]];
                    return;
                }
            }];
        }];
    };
    confirm.cancelBlock = ^{
        
    };
    [confirm show];
}
- (void)routerUrl:(NSString *)url{
    [[PesoRouterCenter sharedPesoRouterCenter] routeWithUrl:url];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self removeViewController];
    });
}
- (PesoBankViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [PesoBankViewModel new];
    }
    return _viewModel;
}
@end
