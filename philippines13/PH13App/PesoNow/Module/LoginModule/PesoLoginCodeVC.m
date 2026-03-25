//
//  PesoLoginCodeVC.m
//  PesoApp
//
//  Created by Jacky on 2024/9/10.
//

#import "PesoLoginCodeVC.h"
#import <CRBoxInputView/CRBoxInputView.h>
#import "PesoLoginAPI.h"
#import "PesoLoginGetCodeAPI.h"
#import "PesoTimer.h"
@interface PesoLoginCodeVC ()
@property (nonatomic, strong) QMUIButton *resendBtn;
@property (nonatomic, strong) CRBoxInputView *inputView;
@property (nonatomic, strong) PesoTimer *timer;

@end

@implementation PesoLoginCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[PesoLocationCenter sharedPesoLocationCenter] startUpdatingLocation];
    if (self.countDownTime != 0) {
        [self timerCountDown:self.countDownTime];
        return;
    }
    [self sendGetCode];

}
- (void)createUI
{
    [super createUI];
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_bg"]];
    bg.frame = CGRectMake(0, 0, kScreenWidth, 407);
    bg.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:bg];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 277, kScreenWidth, kScreenHeight - 277)];
    bgView.layer.cornerRadius = 16.f;
    bgView.layer.masksToBounds = YES;
    bgView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:bgView];
    
    QMUILabel *tipL1 = [[QMUILabel alloc] qmui_initWithFont:PH_Font_B(15) textColor:ColorFromHex(0x0B2C04)];
    tipL1.frame = CGRectMake(20, 25, kScreenWidth - 40, 20);
    tipL1.text = @"Please enter verification code";
    [bgView addSubview:tipL1];
    
    QMUILabel *tipL2 = [[QMUILabel alloc] qmui_initWithFont:PH_Font(15) textColor:ColorFromHex(0x616C5F)];
    tipL2.frame = CGRectMake(20, tipL1.bottom + 5, kScreenWidth - 40, 20);
    tipL2.text = @"SMS verification code has been sent to";
    [bgView addSubview:tipL2];
    
    QMUILabel *phoneLabel = [[QMUILabel alloc] qmui_initWithFont:PH_Font_B(16) textColor:ColorFromHex(0x0A7635)];
    phoneLabel.frame = CGRectMake(20, tipL2.bottom + 12, kScreenWidth - 40, 20);
    phoneLabel.text = self.phoneNumber;
    [bgView addSubview:phoneLabel];
    
    _resendBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    _resendBtn.frame = CGRectMake(kScreenWidth-24-64, 0, 64, 24);
    _resendBtn.centerY = phoneLabel.centerY;
    [_resendBtn setTitle:@"Resend" forState:UIControlStateNormal];
    [_resendBtn setTitleColor:ColorFromHex(0x616C5F) forState:UIControlStateNormal];
    _resendBtn.titleLabel.font = PH_Font(13);
    _resendBtn.layer.borderWidth = 1;
    _resendBtn.layer.borderColor = RGBA(97, 108, 95, 0.10).CGColor;
    _resendBtn.layer.cornerRadius = 4;
    _resendBtn.layer.masksToBounds = YES;
    [_resendBtn addTarget:self action:@selector(resendAction:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:_resendBtn];
    
    CRBoxInputCellProperty *cellProperty = [[CRBoxInputCellProperty alloc] init];
    cellProperty.cellBorderColorNormal = ColorFromHex(0x000000);
    cellProperty.cellBorderColorFilled = RGBA(10, 118, 53, 0.50);
    cellProperty.cellBorderColorSelected =  RGBA(10, 118, 53, 0.50);
    cellProperty.cellBgColorNormal = [UIColor whiteColor];
    cellProperty.cellBgColorFilled = [UIColor whiteColor];
    cellProperty.cellCursorColor =[UIColor whiteColor];
    cellProperty.cellCursorWidth = 2;
    cellProperty.cellCursorHeight = 20.f;
    cellProperty.cornerRadius = 4;
    cellProperty.borderWidth = 1.f;
    cellProperty.cellFont = PH_Font_M(30.f);
    _inputView = [[CRBoxInputView alloc] initWithCodeLength:6];
    _inputView.boxFlowLayout.itemSize = CGSizeMake(45,45);
    _inputView.boxFlowLayout.minLineSpacing = 6;
    _inputView.customCellProperty = cellProperty;
    _inputView.frame = CGRectMake(20, phoneLabel.bottom + 43, kScreenWidth-40, 45);
    WEAKSELF
    _inputView.textDidChangeblock = ^(NSString * _Nullable text, BOOL isFinished) {
        STRONGSELF
        if(isFinished && text.length == 6){
            [strongSelf loginAction:text];
        }
    };
    [bgView addSubview:_inputView];
    [self.inputView becomeFirstResponder];

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self bringNavToFront];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hiddenDargView" object:@{@"hidden":@(1)}];

}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 100;

    [self.inputView loadAndPrepareViewWithBeginEdit:YES];

}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 0;

//    if(self.timeBtRunn){
//        self.timeBtRunn(self.downButton.second,self.phoneNumber);
//    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hiddenDargView" object:@{@"hidden":@(0)}];

    
}
#pragma mark - action
- (void)sendGetCode{
    WEAKSELF
    NSString *phoneNubString = [self.phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    PesoLoginGetCodeAPI *api = [[PesoLoginGetCodeAPI alloc] initWithPhoneNumber:phoneNubString];
    [api startWithCompletionBlockWithSuccess:^(__kindof PesoBaseAPI * _Nonnull request) {
        if(request.responseCode == 0){
            [PesoUtil showToast:NotNil(request.responseMessage)];
            if(request.responseDic){
                NSString *tetendiurnalNcStr = [NSString stringWithFormat:@"%@",request.responseDic[@"gugothirteenyleNc"][@"tedithirteenurnalNc"]];
                [weakSelf timerCountDown:tetendiurnalNcStr.intValue > 0 ? tetendiurnalNcStr.intValue : 60];
            }
        }else{
            [PesoUtil showToast:NotNil(request.responseMessage)];
        }
        
    } failure:^(__kindof PesoBaseAPI * _Nonnull request) {
        
    }];
}
- (void)timerCountDown:(int)second{
    WEAKSELF
    _timer = [PesoTimer timerStartCountdownWithBtn:self.resendBtn timeOut:second titleIngSettingBlock:^(int sec) {
        [weakSelf.resendBtn setTitleColor:[UIColor qmui_colorWithHexString:@"#616C5F"] forState:UIControlStateNormal];
        [weakSelf.resendBtn setTitle:[NSString stringWithFormat:@"%ds",sec] forState:UIControlStateNormal];
        weakSelf.resendBtn.layer.borderColor = RGBA(97, 108, 95, 0.20).CGColor;
        if (weakSelf.countBlock) {
            weakSelf.countBlock(sec);
        }
    } titleFinishSettingBlock:^{
        [weakSelf.resendBtn setTitleColor:[UIColor qmui_colorWithHexString:@"#0A7635"] forState:UIControlStateNormal];
        weakSelf.resendBtn.layer.borderColor = RGBA(42, 147, 19, 0.25).CGColor;
        [weakSelf.resendBtn setTitle:[NSString stringWithFormat:@"Resend"] forState:UIControlStateNormal];
        weakSelf.resendBtn.enabled = YES;
        if (weakSelf.countBlock) {
            weakSelf.countBlock(0);
        }
    }];
}
- (void)resendAction:(UIButton *)btn{
    [self sendGetCode];
}
- (void)loginAction:(NSString *)code{
    NSString *phoneNubString = [self.phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSDictionary *pointDic = [self getaSomeApiParam:@"1" sceneType:@"21"];
    NSDictionary *dic = @{
                          @"stwathirteenrdessNc":NotNil(phoneNubString),
                          @"firothirteenticNc":NotNil(code),
                          @"latethirteenscencyNc":@"duiuyiton",
                          @"point":pointDic,
                         };
    PesoLoginAPI *api = [[PesoLoginAPI alloc] initWithDic:dic];
    WEAKSELF
    [api startWithCompletionBlockWithSuccess:^(__kindof PesoBaseAPI * _Nonnull request) {
        if(request.responseCode != 0){
            [weakSelf.inputView clearAll];
            [PesoUtil showToast:NotNil(request.responseMessage)];
            return;
        }
        if (request.responseDic) {
            [PesoUserCenter.sharedPesoUserCenter initwithUserModelDic:request.responseDic[@"gugothirteenyleNc"]];
            if(self.loginResultBlock){
                self.loginResultBlock();
            }
            if([QMUIHelper isKeyboardVisible]){
                [self.view endEditing:YES];
            }
        }
        [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
    } failure:^(__kindof PesoBaseAPI * _Nonnull request) {
        
    }];
}
- (void)dealloc
{
    
}
@end
