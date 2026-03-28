//
//  BagLoginViewController.m
//  NewBag
//
//  Created by Jacky on 2024/3/14.
//

#import "BagLoginViewController.h"
#import <YYText.h>
#import "BagLoginPresenter.h"
#import "XBDispatchTimer.h"
#import "BagLocationManager.h"
#import "BagWebViewController.h"
#import "UITextField+VerCodeTF.h"
#import "BagChooseEnvViewController.h"
#import "BagChooseEnvPassView.h"
static const int Count = 6;

@interface BagLoginViewController ()<UITextFieldDelegate,BagLoginPresenterDelegate,VerCodeTFDelegate,UINavigationBarDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *loginBackImageView;
@property (weak, nonatomic) IBOutlet UIImageView *loginCardImageView;
@property (weak, nonatomic) IBOutlet UIImageView *loginLogoImage;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextfield;
@property (weak, nonatomic) IBOutlet UILabel *productTitleLabel;

@property (weak, nonatomic) IBOutlet UIButton *protocolSelectBtn1;
@property (weak, nonatomic) IBOutlet YYLabel *protocolLabel;
@property (weak, nonatomic) IBOutlet UIButton *protocolSelectBtn2;
@property (weak, nonatomic) IBOutlet YYLabel *protocolLabel2;
@property (weak, nonatomic) IBOutlet UIButton *goBtn;
//手机号输入
@property (weak, nonatomic) IBOutlet UIView *phoneInputBottomView;
//验证码
@property (weak, nonatomic) IBOutlet UIView *codeInputBottomView;
//验证码框
@property (weak, nonatomic) IBOutlet UIView *smsCodeBgView;
//phone label
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UIButton *resendBtn;
//@property (nonatomic, assign) BOOL ;

@property (nonatomic, strong) NSMutableArray *codeArray;
@property (nonatomic, strong) NSMutableArray *lineArray;

@property (nonatomic, strong) BagLoginPresenter *presenter;
@property (nonatomic, strong) XBDispatchTimer *timer;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *lastTFText;
@property (nonatomic, copy) NSString *codeText;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConst;
@property (weak, nonatomic) IBOutlet UIImageView *chooseEnvImage;

@end

@implementation BagLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor qmui_colorWithHexString:@"#154685"];
    [self loadVCImage];
    WEAKSELF
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:NetWorkMonitor object:nil] subscribeNext:^(NSNotification * _Nullable x) {
       STRONGSELF
        [strongSelf loadVCImage];
    }];
    self.productTitleLabel.text = appName;
    self.protocolSelectBtn1.selected =   self.protocolSelectBtn2.selected = YES;
    self.protocolSelectBtn1.hitScale =   self.protocolSelectBtn2.hitScale = 2;
    [self updateNextBtnEnable:NO];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:@"I have read and agree with the Privacy Agreement"];
    attr.yy_font = [UIFont systemFontOfSize:12];
    attr.yy_color = [UIColor qmui_colorWithHexString:@"#ACACAC"];
    NSRange userRange = [attr.string rangeOfString:@"I have read and agree with the"];
    [attr yy_setTextHighlightRange:userRange
                             color:[UIColor qmui_colorWithHexString:@"#333333"]
                   backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]
                         tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
        [self goUserProtocolAction];
    }];
    NSRange praviRange = [attr.string rangeOfString:@"Privacy Agreement"];

    [attr yy_setTextHighlightRange:praviRange
                             color:[UIColor qmui_colorWithHexString:@"#0eb479"]
                   backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]
                         tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
        [self goUserProtocolAction];
    }];
    [attr yy_setAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:praviRange];
    
    self.protocolLabel.attributedText = attr;
    self.protocolLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    self.protocolLabel.textAlignment = NSTextAlignmentLeft;

    self.protocolLabel2.attributedText = attr;
    
    self.phoneTextfield.delegate = self;
    self.codeArray = [NSMutableArray array];
    self.lineArray = [NSMutableArray array];

    [self.smsCodeBgView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UITextField class]]) {
            [self.codeArray addObject:obj];
        }else{
            [self.lineArray addObject:obj];
        }
    }];
    [self.codeArray enumerateObjectsUsingBlock:^(UITextField *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.delegate = self;
        [obj addTarget:self action:@selector(tfChange:) forControlEvents:UIControlEventEditingChanged];

    }];
    UITextField *field = self.codeArray[0];
//    [field becomeFirstResponder];
    
    [[BagLocationManager shareInstance] startLocation];
    self.navigationController.delegate = self;

    if (kScreenHeight < 800) {
        self.topConst.constant = 100;
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseEnvTap)];
    tap.numberOfTapsRequired = 5;
    [self.chooseEnvImage addGestureRecognizer:tap];
}
- (void)chooseEnvTap{
    BagChooseEnvPassView *view = [BagChooseEnvPassView createView];
    view.succeedBlock = ^{
        BagChooseEnvViewController *env = [[BagChooseEnvViewController alloc] initWithNibName:NSStringFromClass(BagChooseEnvViewController.class) bundle:[Util getBundle]];;
        [self.navigationController pushViewController:env animated:YES];
    };
    view.failBlock = ^{
        [self showToastInWindow:@"Password error!" duration:1.5];
    };
    [view show];

}

- (void)loadVCImage
{
    [self.loginBackImageView sd_setImageWithURL:[Util loadImageUrl:@"login_bg"]];
    [self.loginCardImageView sd_setImageWithURL:[Util loadImageUrl:@"login_card"]];
    [self.loginLogoImage sd_setImageWithURL:[Util loadImageUrl:@"login_logo"]];
    [self.protocolSelectBtn1 sd_setImageWithURL:[Util loadImageUrl:@"login_protocol_selected"] forState:UIControlStateSelected];
    [self.protocolSelectBtn1 sd_setImageWithURL:[Util loadImageUrl:@"login_protocol_normal"] forState:UIControlStateNormal];
    [self.protocolSelectBtn2 sd_setImageWithURL:[Util loadImageUrl:@"login_protocol_selected"] forState:UIControlStateSelected];
    [self.protocolSelectBtn2 sd_setImageWithURL:[Util loadImageUrl:@"login_protocol_normal"] forState:UIControlStateNormal];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _startTime = [NSDate br_timestamp];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dargView" object:@{@"hidden":@(1)}];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dargView" object:@{@"hidden":@(0)}];
}
/**跳协议**/
- (void)goUserProtocolAction{
    [self.phoneTextfield resignFirstResponder];
    BagWebViewController *web = [BagWebViewController new];
    web.url = [NSString stringWithFormat:@"%@/%@",bagH5Url,bagPrivacyProtocol];
    [self.navigationController pushViewController:web animated:YES];
}
//输入完手机号点击下一步触发
- (IBAction)phoneInputAction:(UIButton *)sender {
    if (!self.protocolSelectBtn1.selected) {
        [self showToast:@"Login means you have read and agreed with Privacy Agreement" duration:1.5];
        return;
    }
    if (self.phoneTextfield.text.length>18 || self.phoneTextfield.text.length<=0) {
        [self showToast:@"Please enter a valid phone number" duration:1.5];
        return;
    }
    if (!self.resendBtn.enabled) {
        [self showLoginPage:YES];
        return;
    }
    [self.presenter sendGetSMSCodeRequest];
}
- (IBAction)resendAction:(UIButton *)sender {
    [self.presenter sendGetSMSCodeRequest];
}

//协议选中
- (IBAction)protocolAgreeAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected && _codeText.length == 6) {
        //发送登录请求
        [self loginAction];
    }
}
//返回输入手机号页面
- (IBAction)backToPhoneInputAction:(id)sender {
    [self showLoginPage:NO];
}
//登录事件
- (void)loginAction{
    if (!self.protocolSelectBtn2.selected) {
        [self showToast:@"Login means you have read and agreed with Privacy Agreement" duration:1.5];
        return;
    }
    [self.presenter sendLoginRequestWithStartTime:_startTime code:_codeText];
}

#pragma mark - BagLoginPresenterDelegate
- (void)updateNextBtnEnable:(BOOL)enable
{
    if (enable) {
        self.goBtn.enabled = YES;
        self.goBtn.layer.cornerRadius = 4.f;
        self.goBtn.layer.masksToBounds = YES;
        [self.goBtn setBackgroundImage:[UIImage qmui_imageWithGradientColors:@[[UIColor qmui_colorWithHexString:@"#205EAB"],[UIColor qmui_colorWithHexString:@"#13407C"]] type:QMUIImageGradientTypeHorizontal locations:nil size:CGSizeMake(kScreenWidth-28, 44) cornerRadiusArray:nil] forState:UIControlStateNormal];
    }else{
        self.goBtn.enabled = NO;
        self.goBtn.backgroundColor = [UIColor qmui_colorWithHexString:@"#DFDFDF"];
        [self.goBtn setBackgroundImage:[UIImage new] forState:UIControlStateNormal];
    }
}
- (void)loginFaild
{
    self.lastTFText = @"";
    [self.codeArray enumerateObjectsUsingBlock:^(UITextField *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *line = self.lineArray[idx];
        if (idx!=0) {
            line.backgroundColor = [UIColor qmui_colorWithHexString:@"#212121"];
        }
        obj.text = @"";
        if (idx == 0) {
            obj.userInteractionEnabled = YES;
            [obj becomeFirstResponder];
        }
    }];
}
- (void)showLoginPage:(BOOL)show
{
    self.codeInputBottomView.hidden = show ? NO : YES;
    self.phoneInputBottomView.hidden = show ? YES : NO;
    if (show) {
        [self.phoneTextfield resignFirstResponder];
    }
}
- (void)timerCountDown{
    WEAKSELF
    _timer = [XBDispatchTimer timerStartCountdownWithBtn:self.resendBtn timeOut:60 titleIngSettingBlock:^(int sec) {
        [weakSelf.resendBtn setTitleColor:[UIColor qmui_colorWithHexString:@"#ACACAC"] forState:UIControlStateNormal];
        weakSelf.resendBtn.backgroundColor = [UIColor whiteColor];
        [weakSelf.resendBtn setBackgroundImage:[UIImage new] forState:UIControlStateNormal];
        [weakSelf.resendBtn setTitle:[NSString stringWithFormat:@"%ds",sec] forState:UIControlStateNormal];
        weakSelf.resendBtn.layer.borderWidth = .5;
        weakSelf.resendBtn.layer.borderColor = [UIColor qmui_colorWithHexString:@"#949DA6"].CGColor;
        
    } titleFinishSettingBlock:^{
        [weakSelf.resendBtn setTitleColor:[UIColor qmui_colorWithHexString:@"FFFFFF"] forState:UIControlStateNormal];
        weakSelf.resendBtn.layer.borderWidth = 0;
        weakSelf.resendBtn.layer.cornerRadius  = 4;
        weakSelf.resendBtn.layer.masksToBounds = YES;
        [weakSelf.resendBtn setBackgroundImage:[UIImage qmui_imageWithGradientColors:@[[UIColor qmui_colorWithHexString:@"#205EAB"],[UIColor qmui_colorWithHexString:@"#13407C"]] type:QMUIImageGradientTypeHorizontal locations:nil size:CGSizeMake(80, 24) cornerRadiusArray:nil] forState:UIControlStateNormal];
        [weakSelf.resendBtn setTitle:[NSString stringWithFormat:@"Resend"] forState:UIControlStateNormal];
        weakSelf.resendBtn.enabled = YES;
    }];
}
- (void)loginSuccessWithUid:(NSInteger)uid
{
    if (self.loginResultBlock) {
        self.loginResultBlock(uid);
    }
}
- (void)dissmiss
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark - textfield delegate
-(void)tfChange:(UITextField *)textField{
     
    if(textField.tag -100 +1 == Count){
        self.lastTFText = textField.text;
    }
    if(textField.text.length > 0){
        if(textField.tag - 100 + 1 < self.codeArray.count){
            UITextField *tf = self.codeArray[textField.tag - 100 + 1];
            UIView *line = self.lineArray[textField.tag - 100 + 1];
            line.backgroundColor = [UIColor qmui_colorWithHexString:@"#0EB479"];
            tf.userInteractionEnabled = YES;
            [tf becomeFirstResponder];
            textField.userInteractionEnabled = NO;
        }else{
            //输入框输入完毕,
            [textField resignFirstResponder];
            NSString *verificationCode = @"";
            // 拼接所有UITextField的内容
            for (UITextField *textField in self.codeArray) {
                verificationCode = [verificationCode stringByAppendingString:textField.text];
            }
            _codeText = verificationCode;
            //发送登录请求
            [self loginAction];
        }
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag >= 100) {
        if(textField.text.length > 0){
            textField.text = [textField.text substringToIndex:textField.text.length - 1];
        }
        return YES;
    }
    
    if (![string br_isAllDigits]) {
        return NO;
    }
    
    NSString *text = [textField text];
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
        return NO;
    }

    text = [text stringByReplacingCharactersInRange:range withString:string];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];

//       // 如果是电话号码格式化，需要添加这三行代码
//       NSMutableString *temString = [NSMutableString stringWithString:text];
//       [temString insertString:@" " atIndex:0];
//       text = temString;
    NSString *newString = @"";
    while (text.length > 0) {
        NSString *subString = [text substringToIndex:MIN(text.length, 4)];
        newString = [newString stringByAppendingString:subString];
        if (subString.length == 4) {
            newString = [newString stringByAppendingString:@" "];
        }
        text = [text substringFromIndex:MIN(text.length, 4)];
    }
    self.phoneLabel.text = newString;
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
    if (newString.length >= 19) {
        return NO;
    }
    [textField setText:newString];
    
    [self.presenter updatePhone:newString];
    return NO;
}

- (void)textFieldDidDeleteBackward:(UITextField *)textField
{
    if(textField.tag - 100+1 == Count && self.lastTFText.length > 0){
        [textField becomeFirstResponder];
        self.lastTFText = @"";
    }else{
        //因为第一个UITextField的tag值为1
        if(textField.tag > 100){
            UITextField *tf = self.codeArray[textField.tag- 100 - 1];
            tf.userInteractionEnabled = YES;
            tf.text = @"";
            [tf becomeFirstResponder];
            UIView *line = self.lineArray[textField.tag - 100];
            line.backgroundColor = [UIColor qmui_colorWithHexString:@"#212121"];
        }
    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    // 将第一个UITextField的边框颜色设置为红色
    if (textField.tag == 100) {
        UIView *line = self.lineArray[textField.tag - 100];
        line.backgroundColor = [UIColor qmui_colorWithHexString:@"#0EB479"];
    }
    return YES;
}
#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isSelf = [viewController isKindOfClass:[self class]];
    if (isSelf) {
        [self.navigationController setNavigationBarHidden:isSelf animated:YES];
    }
}
#pragma mark - presenter
- (BagLoginPresenter *)presenter
{
    if (!_presenter) {
        _presenter = [[BagLoginPresenter alloc] init];
        _presenter.delegate = self;
    }
    return _presenter;
}
@end
