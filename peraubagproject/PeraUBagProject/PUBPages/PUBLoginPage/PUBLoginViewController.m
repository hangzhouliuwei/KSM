//
//  PUBLoginViewController.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/18.
//

#import "PUBLoginViewController.h"
#import "PUBPhoneNoInputView.h"
#import "PUBLoginCodeController.h"
#import "PUBChooseEnvView.h"
#import "PUBEnvironmentViewController.h"

@interface PUBLoginViewController ()
@property(nonatomic, strong) UIView *backView;
@property(nonatomic, strong) PUBPhoneNoInputView *phoneNoInputView;
@property(nonatomic, strong) UIButton *loginBtn;
@property(nonatomic, strong) UIButton *codeSelectBtn;
@property (nonatomic, strong) YYLabel *agreementLabel;
@property(nonatomic, assign) NSInteger runningTimeNum;
@property(nonatomic, copy) NSString *lastPhoneNumber;
@property(nonatomic, strong) UIView *chooseEnvView;
@end

@implementation PUBLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hiddeNarbar];
    self.contentView.backgroundColor = [UIColor qmui_colorWithHexString:@"#1E1E2B"];
    self.contentView.height = KSCREEN_HEIGHT;
    [self creatUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(!VCManager.dragView.isHidden){
        VCManager.dragView.hidden = YES;
    }
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if(VCManager.dragView.isHidden){
        VCManager.dragView.hidden = NO;
    }
}

- (void)creatUI
{
    UIImageView *loginImage = [[UIImageView alloc] initWithImage:ImageWithName(@"pub_login_iocn")];
    [self.contentView addSubview:loginImage];
    [loginImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20.f);
        make.top.mas_equalTo(20 + [PUBTools getStatusBarHight]);
        make.size.mas_offset(CGSizeMake(134.f, 38.f));
    }];
    
    
    UIImageView *bannerImage = [[UIImageView alloc] initWithImage:ImageWithName(@"pub_login_banner")];
    [self.contentView addSubview:bannerImage];
    [bannerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20.f);
        make.right.mas_equalTo(-20.f);
        make.top.mas_equalTo(loginImage.mas_bottom).offset(15.f);
        make.height.mas_offset(127.f);
    }];
    
    self.backView = [[UIView alloc] initWithFrame:CGRectZero];
    self.backView.backgroundColor = [UIColor qmui_colorWithHexString:@"#313848"];
    self.backView.layer.cornerRadius = 20.f;
    self.backView.clipsToBounds = YES;
    [self.contentView addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(bannerImage.mas_bottom).offset(40.f);
        make.bottom.mas_equalTo(0);
    }];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectZero];
    topView.layer.cornerRadius = 5.f;
    topView.clipsToBounds = YES;
    topView.backgroundColor = [UIColor qmui_colorWithHexString:@"#00FFD7"];
    [self.backView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(60.f, 10.f));
    }];
    
    UILabel *tipLabel = [[UILabel alloc] qmui_initWithFont:[UIFont boldSystemFontOfSize:13.f] textColor:[UIColor whiteColor]];
    tipLabel.text = @"Log in to experience personal loan services now";
    [self.backView addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20.f);
        make.top.mas_equalTo(topView.mas_bottom).offset(30.f);
        make.height.mas_equalTo(14.f);
    }];
    
    [self.backView addSubview:self.phoneNoInputView];
    [self.phoneNoInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20.f);
        make.top.mas_equalTo(tipLabel.mas_bottom).offset(10.f);
        make.height.mas_equalTo(52.f);
        make.width.mas_equalTo( KSCREEN_WIDTH- 40.f);
    }];
    
    [self.backView addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20.f);
        make.right.mas_equalTo(-20.f);
        make.top.mas_equalTo(self.phoneNoInputView.mas_bottom).offset(108.f);
        make.height.mas_equalTo(48.f);
    }];
    
    [self.backView addSubview:self.codeSelectBtn];
    [self.codeSelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(29.f);
        make.bottom.mas_equalTo(self.loginBtn.mas_bottom).offset(44.f);
        make.size.mas_equalTo(CGSizeMake(12.f,  12.f));
    }];
    
    self.agreementLabel = [[YYLabel alloc] initWithFrame:CGRectZero];
    
    NSDictionary *attributes = @{NSFontAttributeName:FONT(12), NSForegroundColorAttributeName: [UIColor qmui_colorWithHexString:@"#FFFFFF"]};
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"I have read and agree with Privacy Agreement" attributes:attributes];
    [text addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:[[text string] rangeOfString:@"Privacy Agreement"]];
    //设置高亮色和点击事件
    WEAKSELF
    [text yy_setTextHighlightRange:[[text string] rangeOfString:@"Privacy Agreement"] color:[UIColor qmui_colorWithHexString:@"#00FFD7"] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        STRONGSELF
        PUBBaseWebController *webVC = [[PUBBaseWebController alloc] init];
        webVC.url = STR_FORMAT(@"%@%@", HttPPUBRequest.h5Url,privacyAgreement);
        webVC.h5Title = @"Privacy Agreement";
        [strongSelf.navigationController qmui_pushViewController:webVC animated:YES completion:nil];
    }];
    self.agreementLabel.attributedText = text;
    [self.backView addSubview:self.agreementLabel];
    [self.agreementLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.codeSelectBtn.mas_right).offset(4.f);
        make.centerY.mas_equalTo(self.codeSelectBtn.mas_centerY);
    }];
    
    [self.contentView addSubview:self.chooseEnvView];
    self.chooseEnvView.backgroundColor = [UIColor clearColor];
    [self.chooseEnvView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-2.f * WScale);
        make.bottom.mas_equalTo(-10.f *WScale);
        make.width.height.mas_equalTo(80.f);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseEnvTap)];
    tap.numberOfTapsRequired = 5.f;
    [self.chooseEnvView addGestureRecognizer:tap];
}

-(void)chooseEnvTap
{
    PUBChooseEnvView *enview = [[PUBChooseEnvView alloc] init];
    [enview show];
    WEAKSELF
    enview.clickBlock = ^(BOOL value) {
        STRONGSELF
        if(value){
            PUBEnvironmentViewController *environmentVC = [[PUBEnvironmentViewController alloc] init];
            [strongSelf.navigationController pushViewController:environmentVC animated:YES];
        }else{
            [PUBTools showToast:@"Password error!" time:1];
        }
    };
}

- (void)loginBtnClick
{
    
    if (!self.codeSelectBtn.selected) {
        [PUBTools showToast:@"Login means you have read and agreed with Privacy Agreement" time:1];
        return;
    }
    if (self.phoneNoInputView.text.length>18 || self.phoneNoInputView.text.length<=0) {
        [PUBTools showToast:@"Please enter a valid phone number"];
        return;
    }
    
    NSString *phoneNubString = [self.phoneNoInputView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    PUBLoginCodeController *codeVC = [[PUBLoginCodeController alloc] init];
    codeVC.phoneNumber = NotNull(phoneNubString);
    codeVC.loginResultBlock = self.loginResultBlock;
    WEAKSELF
    codeVC.timeBtRunning = ^(NSInteger index, NSString * _Nonnull object2) {
        STRONGSELF
        strongSelf.runningTimeNum = index;
        strongSelf.lastPhoneNumber = object2;
    };
    
    if(![PUBTools isBlankString:self.lastPhoneNumber] && 
       [self.lastPhoneNumber isEqualToString:phoneNubString]
       && self.runningTimeNum > 0){
        codeVC.runningTimeNum = self.runningTimeNum;
    }
    [self.navigationController qmui_pushViewController:codeVC animated:YES completion:nil];
}



- (void)codeSelectBtnClick:(UIButton *)sender 
{
    sender.selected = !sender.selected;
}

#pragma mrak - lazy
-(PUBPhoneNoInputView *)phoneNoInputView{
    if(!_phoneNoInputView){
        _phoneNoInputView = [[PUBPhoneNoInputView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH- 40.f, 52.f)];
        _phoneNoInputView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2f];
        _phoneNoInputView.layer.cornerRadius = 12.f;
        WEAKSELF
        _phoneNoInputView.inputBlock = ^(NSInteger index) {
            STRONGSELF
            if(index > 10){
                strongSelf.loginBtn.backgroundColor = [UIColor qmui_colorWithHexString:@"#00FFD7"];
                strongSelf.loginBtn.userInteractionEnabled = YES;
            }else{
                strongSelf.loginBtn.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
                strongSelf.loginBtn.userInteractionEnabled = NO;
            }
        };
    }
    
    return _phoneNoInputView;
}

- (UIButton *)loginBtn{
    if(!_loginBtn){
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.titleLabel.font = FONT_BOLD(20.f);
        _loginBtn.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
        _loginBtn.layer.cornerRadius = 24.f;
        _loginBtn.clipsToBounds = YES;
        _loginBtn.userInteractionEnabled = NO;
        [_loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_loginBtn setTitle:@"Let’s Go" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor qmui_colorWithHexString:@"#000000"] forState:UIControlStateNormal];
    }
    return _loginBtn;
}

- (UIButton *)codeSelectBtn{
    if(!_codeSelectBtn){
        _codeSelectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _codeSelectBtn.selected = YES;
        [_codeSelectBtn setImage:ImageWithName(@"pub_protocol_unselected") forState:UIControlStateNormal];
        [_codeSelectBtn setImage:ImageWithName(@"pub_protocol_selected") forState:UIControlStateSelected];
        [_codeSelectBtn addTarget:self action:@selector(codeSelectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _codeSelectBtn;
}

- (UIView *)chooseEnvView{
    if(!_chooseEnvView){
        _chooseEnvView = [[UIView alloc] init];
        _chooseEnvView.userInteractionEnabled = YES;
    }
    
    return _chooseEnvView;
}


@end
