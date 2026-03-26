//
//  PUBLoginCodeController.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/22.
//

#import "PUBLoginCodeController.h"
#import "PUBCodeInputView.h"
#import "PUBTimeButton.h"
#import <Bugly/Bugly.h>

@interface PUBLoginCodeController ()
@property(nonatomic, strong) UIView *backView;
@property(nonatomic, strong) PUBCodeInputView *authCodeText;
@property(nonatomic, strong) PUBTimeButton *timeBtn;
@property(nonatomic, copy) NSString *startTime;
@property(nonatomic, strong) UIButton *codeSelectBtn;
@property (nonatomic, strong) YYLabel *agreementLabel;
@end

@implementation PUBLoginCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[PUBLocationManager sharedPUBLocationManager] startLocation];
    self.navBar.backgroundColor = [UIColor qmui_colorWithHexString:@"#1E1E2B"];
    self.contentView.backgroundColor = [UIColor qmui_colorWithHexString:@"#1E1E2B"];
    self.contentView.height = KSCREEN_HEIGHT - self.navBar.bottom;
    [self creatUI];
    self.startTime = [PUBTools getTime];
    if(self.runningTimeNum !=0){
        [self.timeBtn startTimes:(int)self.runningTimeNum];
        self.runningTimeNum = 0;
        return;
    }
    [self reponseCodephonestr];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(!VCManager.dragView.isHidden){
        VCManager.dragView.hidden = YES;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //[self.timeBtn releaseTimer];
    if(VCManager.dragView.isHidden){
        VCManager.dragView.hidden = NO;
    }
    if(self.timeBtRunning){
        self.timeBtRunning(self.timeBtn.runningTimeNum, self.phoneNumber);
    }
}

- (void)backBtnClick:(UIButton *)btn
{
    [self.navigationController qmui_popViewControllerAnimated:YES completion:nil];
}

- (void)creatUI
{
    WEAKSELF
    UIImageView *loginImage = [[UIImageView alloc] initWithImage:ImageWithName(@"pub_login_iocn")];
    [self.contentView addSubview:loginImage];
    [loginImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20.f);
        make.top.mas_equalTo(0);
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
    tipLabel.text = @"Please enter verification code";
    [self.backView addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20.f);
        make.top.mas_equalTo(topView.mas_bottom).offset(30.f);
        make.height.mas_equalTo(14.f);
    }];
    
    self.authCodeText = [[PUBCodeInputView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH - 40.f, 46.f*WScale)];
    self.authCodeText.finishBlock = ^(NSString * _Nonnull str) {
        STRONGSELF
        [strongSelf reponseLoginCode:str];
    };
    [self.contentView addSubview:self.authCodeText];
    [self.authCodeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tipLabel.mas_bottom).offset(20.f);
        make.left.mas_equalTo(20.f);
        make.right.mas_equalTo(-20.f);
        make.height.mas_equalTo(46.f*WScale);
    }];
    
    UILabel *phoeTipLabel = [[UILabel alloc] qmui_initWithFont:[UIFont boldSystemFontOfSize:13.f] textColor:[UIColor whiteColor]];
    phoeTipLabel.text = @"SMS verification code has been sent to";
    [self.backView addSubview:phoeTipLabel];
    [phoeTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20.f);
        make.top.mas_equalTo(self.authCodeText.mas_bottom).offset(24.f);
        make.height.mas_equalTo(14.f);
    }];
    
    UILabel *phoeNumberLabel = [[UILabel alloc] qmui_initWithFont:[UIFont boldSystemFontOfSize:13.f] textColor:[UIColor whiteColor]];
    phoeNumberLabel.text = NotNull(self.phoneNumber);
    [self.backView addSubview:phoeNumberLabel];
    [phoeNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(phoeTipLabel);
        make.top.mas_equalTo(phoeTipLabel.mas_bottom).offset(2.f);
        make.height.mas_equalTo(14.f);
    }];
    
    self.timeBtn = [[PUBTimeButton alloc] initWithFrame:CGRectMake(0, 0, 72.f, 32.f) andTimer:60.f];
    self.timeBtn.layer.cornerRadius = 16.f;
    self.timeBtn.clipsToBounds = YES;
    
    self.timeBtn.startTimeButtonAction = ^(PUBTimeButton * _Nonnull btn, BOOL isRunning) {
        STRONGSELF
        if(!isRunning){
            [strongSelf reponseCodephonestr];
        }
    };
    self.timeBtn.endTimeButtonAction = ^(PUBTimeButton * _Nonnull btn) {

        
    };
    [self.backView addSubview:self.timeBtn];
    [self.timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20.f);
        make.top.mas_equalTo(self.authCodeText.mas_bottom).offset(22.f);
        make.size.mas_equalTo(CGSizeMake(72.f,  32.f));
    }];
    
    
    [self.backView addSubview:self.codeSelectBtn];
    [self.codeSelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(29.f);
        make.bottom.mas_equalTo(-72.f);
        make.size.mas_equalTo(CGSizeMake(12.f,  12.f));
    }];
    
    self.agreementLabel = [[YYLabel alloc] initWithFrame:CGRectZero];
    
    NSDictionary *attributes = @{NSFontAttributeName:FONT(12), NSForegroundColorAttributeName: [UIColor qmui_colorWithHexString:@"#FFFFFF"]};
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"I have read and agree with Privacy Agreement" attributes:attributes];
    [text addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:[[text string] rangeOfString:@"Privacy Agreement"]];
    //设置高亮色和点击事件
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
    
}

#pragma mark - 请求验证
- (void)reponseCodephonestr
{
    NSDictionary *dic = @{
                         @"roofless_eg":NotNull(self.phoneNumber),
                         @"unmistakably_eg":@"juyttrr",
                         };
    [self showEmptyViewWithLoading];
    WEAKSELF
    [HttPPUBRequest postWithPath:SendSmsCode params:dic success:^(NSDictionary * _Nonnull responseDataDic, PUBBaseResponseModel * _Nonnull mode) {
        STRONGSELF
        NSString *times = [NSString stringWithFormat:@"%@",mode.dataDic[@"inequity_eg"][@"shroud_eg"]];
        [strongSelf hideEmptyView];
        strongSelf.timeBtn.runningTimeNum = 0;
        [strongSelf.timeBtn startTimes:times.integerValue > 0 ? times.intValue : 60.f];
        [PUBTools showToast:mode.dataDic[@"obliterate_eg"][@"electioneer_eg"]];
    } failure:^(NSError * _Nonnull error) {
        STRONGSELF
        [strongSelf hideEmptyView];
        
    } showLoading:NO];
    
}


- (void)reponseLoginCode:(NSString*)code
{
    if (!self.codeSelectBtn.selected) {
        [PUBTools showToast:@"Login means you have read and agreed with Privacy Agreement" time:1];
        return;
    }
    if (!(code.length == AuthCodeLength)) {
        [PUBTools showToast:@"Please enter the correct verification code"];
        return;
    }
    
    NSDictionary *pointDic = @{
                               @"milligramme_eg":@([PUBTools getTime].doubleValue),
                               @"testudinal_eg" : @(self.startTime.doubleValue),
                               @"classer_eg" :@"21",
                               @"grouse_eg"  :@"1",
                               @"infortune_eg":NotNull([NSObject getIDFV]),
                               @"neuroleptic_eg":@(PUBLocation.latitude),
                               @"nonrecurring_eg":@(PUBLocation.longitude),
                             };
    NSDictionary *dic = @{
                         @"point":pointDic,
                         @"electrologist_eg":NotNull(self.phoneNumber),
                         @"hsus_eg":NotNull(code),
                         @"furrin_eg":@"duiuyiton",
                         };
    [self showEmptyViewWithLoading];
    WEAKSELF
    [HttPPUBRequest postWithPath:SmsCodeLogin params:dic success:^(NSDictionary * _Nonnull responseDataDic, PUBBaseResponseModel * _Nonnull mode) {
       STRONGSELF
        [strongSelf hideEmptyView];
        if(!mode.success){
            [strongSelf.authCodeText reloadUI];
            [PUBTools showToast:mode.desc];
            return;
        }
        [strongSelf loginSuccessDic:mode.dataDic];
        [strongSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError * _Nonnull error) {
        STRONGSELF
        [strongSelf hideEmptyView];
        
    }];
}

- (void)loginSuccessDic:(NSDictionary*)dic
{
    if(![dic isKindOfClass:[NSDictionary class]] ||!dic[@"obliterate_eg"])return;
    PUBUserModel *userModel = [PUBUserModel yy_modelWithDictionary:dic[@"obliterate_eg"]];
    [PUBCache cacheYYObject:userModel withKey:LoginUser];
    [[PUBUserManager sharedUser] initUser];
    [PUBTrackHandleManager trackUpDataAppUserId:[NSString stringWithFormat:@"%ld",User.uid]];
    [Bugly setUserIdentifier:User.username];
    if(self.loginResultBlock){
        self.loginResultBlock([PUBUserManager sharedUser].uid);
    }
}

- (void)codeSelectBtnClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if(sender.selected){
        [self reponseLoginCode:self.authCodeText.text];
    }
}


#pragma mark - lazy
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

@end
