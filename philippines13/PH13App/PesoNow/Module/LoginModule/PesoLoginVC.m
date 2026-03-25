//
//  PesoLoginVC.m
//  PesoApp
//
//  Created by Jacky on 2024/9/10.
//

#import "PesoLoginVC.h"
#import "PesoLoginCodeVC.h"
@interface PesoLoginVC ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *phoneTextfield;
@property(nonatomic, strong) QMUIButton *protocolBtn;
@property(nonatomic, copy) NSString *oldPhone;
@property(nonatomic, assign) int countDownTime;

@end

@implementation PesoLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_bg"]];
    bg.frame = CGRectMake(0, 0, kScreenWidth, 407);
    bg.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:bg];
    
    
    QMUIButton *btn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 60, 30);
    btn.center = self.view.center;
    [btn setTitle:@"Login" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 277, kScreenWidth, kScreenHeight - 277)];
    bgView.layer.cornerRadius = 16.f;
    bgView.layer.masksToBounds = YES;
    bgView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:bgView];
    
    QMUILabel *tipL = [[QMUILabel alloc] qmui_initWithFont:PH_Font_B(15) textColor:ColorFromHex(0x0B2C04)];
    tipL.frame = CGRectMake(15, 20, kScreenWidth - 15, 20);
    tipL.text = @"Log in to experience personal loan services now";
    [bgView addSubview:tipL];
    
    UIView *textBg = [[UIView alloc] initWithFrame:CGRectMake(15, tipL.bottom + 24, kScreenWidth-30, 55)];
    textBg.backgroundColor = ColorFromHex(0xF8F8F8);
    [bgView addSubview:textBg];
    
    QMUILabel *leftLabel = [[QMUILabel alloc] qmui_initWithFont:PH_Font(16) textColor:ColorFromHex(0x0B2C04)];
    leftLabel.frame = CGRectMake(0, 0, 48, 28);
    leftLabel.layer.cornerRadius = 14.f;
    leftLabel.layer.masksToBounds = YES;
    leftLabel.textAlignment = NSTextAlignmentCenter;
    leftLabel.text = @"+63";
    leftLabel.textColor = ColorFromHex(0x0B2C04);
    leftLabel.backgroundColor = ColorFromHex(0xE4EDE2);
    
    UIView *leftView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 78, 28)];
    leftView.backgroundColor = UIColor.clearColor;
    leftLabel.center = leftView.center;
    [leftView addSubview:leftLabel];
    
    self.phoneTextfield = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, textBg.width, textBg.height)];
    _phoneTextfield.borderStyle = UITextBorderStyleNone;
    _phoneTextfield.font = PH_Font_SD(18);
    _phoneTextfield.textColor = [UIColor blackColor];
    _phoneTextfield.textAlignment = NSTextAlignmentLeft;
    _phoneTextfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _phoneTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneTextfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Phone number" attributes:@{NSFontAttributeName:PH_Font(16) ,NSForegroundColorAttributeName:[UIColor qmui_colorWithHexString:@"#B4B9B3"]}];
    _phoneTextfield.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTextfield.delegate = self;
    _phoneTextfield.leftView = leftView;
    _phoneTextfield.leftViewMode = UITextFieldViewModeAlways;
    [textBg addSubview:_phoneTextfield];
    
    
    self.protocolBtn.frame = CGRectMake(20.f, textBg.bottom + 140, 14.f, 14.f);
    [bgView addSubview:self.protocolBtn];

    YYLabel *agreementLabel = [[YYLabel alloc] initWithFrame:CGRectZero];
    NSDictionary *attributes = @{NSFontAttributeName:PH_Font(13), NSForegroundColorAttributeName: [UIColor qmui_colorWithHexString:@"#666666"]};
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"I have read and agree with Privacy Agreement" attributes:attributes];
    [text addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:[[text string] rangeOfString:@"Privacy Agreement"]];
    [text yy_setTextHighlightRange:[[text string] rangeOfString:@"Privacy Agreement"] color:[UIColor qmui_colorWithHexString:@"#0A7635"] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        NSString *url = [NSString stringWithFormat:@"%@%@",WebBaseUrl,Privacy];
        [[PesoRouterCenter sharedPesoRouterCenter] routeWithUrl:url];
    }];
   
    agreementLabel.attributedText = text;
    agreementLabel.frame = CGRectMake(self.protocolBtn.right + 10.f, 200, 286, 17);
    agreementLabel.centerY = self.protocolBtn.centerY;
    [bgView addSubview:agreementLabel];
    
    QMUIButton *loginBtn = [[QMUIButton alloc] initWithFrame:CGRectMake(30, agreementLabel.bottom + 20, kScreenWidth - 60, 50)];
    loginBtn.backgroundColor = ColorFromHex(0xFCE815);
    [loginBtn setTitle:@"Let’s Go" forState:UIControlStateNormal];
    [loginBtn setTitleColor:ColorFromHex(0x000000) forState:UIControlStateNormal];
    loginBtn.titleLabel.font = PH_Font_B(18);
    loginBtn.layer.cornerRadius = 25.f;
    loginBtn.layer.masksToBounds = YES;
    [loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:loginBtn];
    
    [RACObserve(self, phoneTextfield) subscribeNext:^(NSString * _Nullable x) {
        NSLog(@">>>>>>");
    }];
    
}
- (void)loginClick{
    if([QMUIHelper isKeyboardVisible]){
        [self.view endEditing:YES];
    }
    if(!self.protocolBtn.isSelected){
        [PesoUtil showToast:@"Login means you have read and agreed with Privacy Agreement"];
        return;
    }
    if (self.phoneTextfield.text.length>15 || self.phoneTextfield.text.length<5) {
        [PesoUtil showToast:@"Please enter a valid phone number"];
        return;
    }
    PesoLoginCodeVC *vc = [PesoLoginCodeVC new];
    vc.phoneNumber = self.phoneTextfield.text;
    if(![self.oldPhone isEqual:vc.phoneNumber]){
        vc.countDownTime = 0;
    }else{
        vc.countDownTime = self.countDownTime;
    }
    WEAKSELF
    vc.countBlock = ^(int countdown) {
        weakSelf.countDownTime = countdown;
    };
    [self.navigationController qmui_pushViewController:vc animated:YES completion:^{
        
    }];
}
-(void)protocolClick:(QMUIButton*)btn
{
    btn.selected = !btn.selected;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.hiddenBackBtn = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hiddenDargView" object:@{@"hidden":@(1)}];

}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.oldPhone = self.phoneTextfield.text;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hiddenDargView" object:@{@"hidden":@(0)}];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *text = [textField.text stringByAppendingString:string];
    if (text.length>15) {
        return NO;
    }
    return YES;
}
-(QMUIButton *)protocolBtn{
    if(!_protocolBtn){
        _protocolBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        _protocolBtn.selected = YES;
        _protocolBtn.frame = CGRectMake(20.f, _phoneTextfield.bottom + 140, 14.f, 14.f);
        [_protocolBtn setImage:[UIImage imageNamed:@"login_normal"] forState:UIControlStateNormal];
        [_protocolBtn setImage:[UIImage imageNamed:@"login_select"] forState:UIControlStateSelected];
        [_protocolBtn addTarget:self action:@selector(protocolClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _protocolBtn;
}

@end
