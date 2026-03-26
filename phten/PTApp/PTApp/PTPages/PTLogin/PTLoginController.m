//
//  PTLoginController.m
//  PTApp
//
//  Created by 刘巍 on 2024/7/25.
//

#import "PTLoginController.h"
#import "PTPhoneInputView.h"
#import "PTLoginCodeController.h"
#import "PTWebViewController.h"
#import "PTLoginTipView.h"
@interface PTLoginController ()
@property(nonatomic, strong) PTPhoneInputView *phoneTextField;
@property(nonatomic, strong) QMUIButton *protocolBtn;
@property (nonatomic, strong) YYLabel *agreementLabel;
@property(nonatomic, strong) QMUIButton *loginBtn;
@property(nonatomic, assign) NSInteger runningTimeNum;
@property(nonatomic, copy) NSString *oldPhoneNumber;
@end

@implementation PTLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createSubUI];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 设置 keyboardDistanceFromTextField
//    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 100;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hiddenDargView" object:@{@"hidden":@(1)}];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 恢复默认的 keyboardDistanceFromTextField
//    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 0;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hiddenDargView" object:@{@"hidden":@(0)}];

    if([QMUIHelper isKeyboardVisible]){
        [self.view endEditing:YES];
    }
}


-(void)createSubUI
{
    self.navView.hidden =YES;
    UIImageView *backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_login_back"]];
    backImageView.userInteractionEnabled = YES;
    [self.view addSubview: backImageView];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    UIImageView *logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_login_Log"]];
    [backImageView addSubview:logoImageView];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(32.f);
        make.top.mas_equalTo(kStatusBarHeight);
        make.width.height.mas_equalTo(38.f);
    }];
    
    QMUILabel *title = [[QMUILabel alloc] qmui_initWithFont:PT_Font(14) textColor:UIColor.blackColor];
    title.text = AppName;
    [backImageView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(logoImageView.mas_right).offset(16);
        make.centerY.mas_equalTo(logoImageView);
    }];

    [backImageView addSubview:self.phoneTextField];
    
    [backImageView addSubview:self.protocolBtn];
    
    
    self.agreementLabel = [[YYLabel alloc] initWithFrame:CGRectZero];
    NSDictionary *attributes = @{NSFontAttributeName:PT_Font(12), NSForegroundColorAttributeName: [UIColor qmui_colorWithHexString:@"#CFDADC"]};
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"I have read and agree with Privacy Agreement" attributes:attributes];
    [text addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:[[text string] rangeOfString:@"Privacy Agreement"]];
    //设置高亮色和点击事件
    WEAKSELF
    [text yy_setTextHighlightRange:[[text string] rangeOfString:@"Privacy Agreement"] color:[UIColor qmui_colorWithHexString:@"#C1FA54"] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        STRONGSELF
        PTWebViewController *webViewVC = [[PTWebViewController alloc] init];
        webViewVC.url = [NSString stringWithFormat:@"%@%@",PTWebbaseUrl,PTPrivacy];
        [strongSelf.navigationController qmui_pushViewController:webViewVC animated:YES completion:nil];
    }];
   
    self.agreementLabel.attributedText = text;
    self.agreementLabel.frame = CGRectMake(self.protocolBtn.right + 8.f, 200, 260, 14.f);
    self.agreementLabel.centerY = self.protocolBtn.centerY;
    [backImageView addSubview:self.agreementLabel];
    
    [backImageView addSubview:self.loginBtn];
    
}

-(void)protocolBtnClick:(QMUIButton*)btn
{
    btn.selected = !btn.selected;
}

- (void)loginBtnClick
{
    if([QMUIHelper isKeyboardVisible]){
        [self.view endEditing:YES];
    }
    if(!self.protocolBtn.isSelected){
//        [PTTools showToast:@"Login means you have read and agreed with Privacy Agreement" time:1];
        PTLoginTipView *tip = [[PTLoginTipView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [tip show];
        return;
    }
    if (self.phoneTextField.text.length>18 || self.phoneTextField.text.length<=0) {
        [PTTools showToast:@"Please enter a valid phone number"];
        return;
    }
    
    PTLoginCodeController *loginCodeVC = [[PTLoginCodeController alloc] init];
    loginCodeVC.phoneNumber = PTNotNull(self.phoneTextField.text);
    loginCodeVC.runningTimeNum = self.runningTimeNum;
    NSLog(@">>>>runningTimeNum======%ld",self.runningTimeNum);
    if(![self.oldPhoneNumber isEqual:loginCodeVC.phoneNumber]){
        loginCodeVC.runningTimeNum = 0;
    }else{
        loginCodeVC.runningTimeNum = self.runningTimeNum;
    }
    loginCodeVC.loginResultBlock = self.loginResultBlock;
    WEAKSELF
    loginCodeVC.timeBtRunn = ^(NSInteger index, NSString *object2) {
        STRONGSELF
        strongSelf.runningTimeNum = index;
        strongSelf.oldPhoneNumber = PTNotNull(object2);
    };
    
    [self.navigationController qmui_pushViewController:loginCodeVC animated:YES completion:nil];
}

#pragma mark - lazy
-(PTPhoneInputView *)phoneTextField{
    if(!_phoneTextField){
        _phoneTextField = [[PTPhoneInputView alloc] initWithPhoneInputViewFrame:CGRectMake(46.f, kNavHeight + PTAUTOSIZE(410.f), kScreenWidth - 92.f , 46.f)];
        WEAKSELF
        _phoneTextField.inputBlock = ^(NSInteger index) {
            STRONGSELF
            if(index > 10){
                strongSelf.loginBtn.backgroundColor = [UIColor qmui_colorWithHexString:@"#0C0C31"];
                strongSelf.loginBtn.userInteractionEnabled = YES;
            }else{
                strongSelf.loginBtn.backgroundColor = [[UIColor qmui_colorWithHexString:@"#0C0C31"] colorWithAlphaComponent:0.5f];;
                strongSelf.loginBtn.userInteractionEnabled = NO;
            }
            
        };
    }
    
    return _phoneTextField;
}

-(QMUIButton *)protocolBtn{
    if(!_protocolBtn){
        _protocolBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        _protocolBtn.selected = YES;
        _protocolBtn.frame = CGRectMake(46.f, _phoneTextField.bottom + PTAUTOSIZE(26.f), 14.f, 14.f);
        [_protocolBtn setImage:PTImageWithName(@"PT_login_normal") forState:UIControlStateNormal];
        [_protocolBtn setImage:PTImageWithName(@"PT_login_select") forState:UIControlStateSelected];
        [_protocolBtn addTarget:self action:@selector(protocolBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _protocolBtn;
}

-(QMUIButton *)loginBtn{
    if(!_loginBtn){
        _loginBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.titleLabel.font = PT_Font_B(20.f);
        _loginBtn.backgroundColor = [[UIColor qmui_colorWithHexString:@"#0C0C31"] colorWithAlphaComponent:0.5f];
        _loginBtn.layer.cornerRadius = 8.f;
        _loginBtn.clipsToBounds = YES;
        _loginBtn.userInteractionEnabled = NO;
        [_loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_loginBtn setTitle:@"Let’s Go" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor qmui_colorWithHexString:@"#C1FA53"] forState:UIControlStateNormal];
        _loginBtn.frame = CGRectMake(34.f, _protocolBtn.bottom + (kScreenHeight <= 667 ? 20 : PTAUTOSIZE(80.f)), kScreenWidth - 68.f, 46.f);
    }
    return _loginBtn;
}

@end
