//
//  PTLoginCodeController.m
//  PTApp
//
//  Created by 刘巍 on 2024/7/31.
//

#import "PTLoginCodeController.h"
#import "PTCountDownButton.h"
#import "PTCountDownButton.h"
#import <CRBoxInputView/CRBoxInputView.h>
#import "PTLoginGetSMSCodeService.h"
#import "PTLoginService.h"

@interface PTLoginCodeController ()
//@property(nonatomic, copy) NSString *startTime;
@property(nonatomic, strong) PTCountDownButton *downButton;
@property(nonatomic, strong) CRBoxInputView *codeInputView;
@end

@implementation PTLoginCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [PTLocation startUpdatingLocation];
//    self.startTime = [PTTools getTime];
    [self createSubUI];
    if(self.runningTimeNum !=0){
        [self.downButton startCountDownWithSecond:self.runningTimeNum];
        return;
    }
    [self getPTLoginCode];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hiddenDargView" object:@{@"hidden":@(1)}];    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 100;

    [self.codeInputView loadAndPrepareViewWithBeginEdit:YES];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 0;

    if(self.timeBtRunn){
        self.timeBtRunn(self.downButton.second,self.phoneNumber);
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hiddenDargView" object:@{@"hidden":@(0)}];

    
}

-(void)createSubUI
{
    UIImageView *backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_login_loginCodeback"]];
    backImageView.contentMode = UIViewContentModeScaleAspectFill;
    backImageView.userInteractionEnabled = YES;
    [self.view addSubview: backImageView];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    QMUILabel *tipLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font(12.f) textColor:[UIColor qmui_colorWithHexString:@"#666666"]];
    tipLabel.textAlignment = NSTextAlignmentLeft;
    tipLabel.text = @"SMS verification code has been sent to";
    tipLabel.frame = CGRectMake(46.f, kNavHeight + PTAUTOSIZE(386.f), PTAUTOSIZE(280.f), PTAUTOSIZE(14.f));
    [backImageView addSubview:tipLabel];
    
    QMUILabel *phoneNumberLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font_M(26.f) textColor:[UIColor qmui_colorWithHexString:@"#000000"]];
    phoneNumberLabel.textAlignment = NSTextAlignmentLeft;
    phoneNumberLabel.text = PTNotNull(self.phoneNumber);
    phoneNumberLabel.frame = CGRectMake(46.f, tipLabel.bottom + 14.f, PTAUTOSIZE(200.f), PTAUTOSIZE(28.f));
    [backImageView addSubview:phoneNumberLabel];
    
    self.downButton = [PTCountDownButton buttonWithType:UIButtonTypeCustom];
    self.downButton.frame = CGRectMake(phoneNumberLabel.right + 4.f, tipLabel.bottom + 14.f, 88.f, 30.f);
    self.downButton.backgroundColor = PTUIColorFromHex(0xC1FA53);
    self.downButton.titleLabel.font = PT_Font_SD(14.f);
    [self.downButton setTitle:@"Resend" forState:UIControlStateNormal];
    [self.downButton setTitleColor:PTUIColorFromHex(0x000000) forState:UIControlStateNormal];
    [self.downButton showRadius:15.f];
    self.downButton.layer.borderWidth = 1.f;
    self.downButton.layer.borderColor = PTUIColorFromHex(0xC1FA53).CGColor;
    [backImageView addSubview:self.downButton];
    WEAKSELF
    [self.downButton countDownButtonHandler:^(PTCountDownButton * _Nonnull countDownButton, NSInteger tag) {
        STRONGSELF
        countDownButton.enabled = NO;
        [strongSelf getPTLoginCode];
    }];
    
    [self.downButton countDownChanging:^NSString * _Nullable(PTCountDownButton * _Nonnull countDownButton, NSUInteger second) {
        NSString *title = [NSString stringWithFormat:@"%zds",second];
        countDownButton.backgroundColor = [UIColor whiteColor];
        countDownButton.titleLabel.font = PT_Font(14.f);
        [countDownButton setTitleColor: PTUIColorFromHex(0xC1FA53) forState:UIControlStateNormal];
        return title;
    }];
    
    [self.downButton countDownFinished:^NSString * _Nullable(PTCountDownButton * _Nonnull countDownButton, NSUInteger second) {
        countDownButton.enabled = YES;
        countDownButton.backgroundColor = PTUIColorFromHex(0xC1FA53);
        countDownButton.titleLabel.font = PT_Font_SD(14.f);
        [countDownButton setTitleColor:PTUIColorFromHex(0x000000) forState:UIControlStateNormal];
        return @"Resend";
    }];
    
    [backImageView addSubview:self.codeInputView];
    self.codeInputView.frame = CGRectMake(46.f, phoneNumberLabel.bottom + 30.f, kScreenWidth - 92.f, 48.f);

    self.codeInputView.textDidChangeblock = ^(NSString * _Nullable text, BOOL isFinished) {
        STRONGSELF
        if(isFinished && text.length == 6){
            [strongSelf getPTLoginCode:text];
        }
    };
    [self.codeInputView becomeFirstResponder];
    
    self.navView.backgroundColor = UIColor.clearColor;
    [self.view bringSubviewToFront:self.navView];
}

#pragma mark - 获取验证码
- (void)getPTLoginCode
{
    WEAKSELF
    NSString *phoneNubString = [self.phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    PTLoginGetSMSCodeService *codeService = [[PTLoginGetSMSCodeService alloc] initWithPhoneNumber:phoneNubString];
    STRONGSELF
    [codeService startWithCompletionBlockWithSuccess:^(__kindof PTBaseRequest * _Nonnull request) {
        if(request.response_code == 0){
            [PTTools showToast:PTNotNull(request.response_message)];
            if(request.response_dic){
                NSString *tetendiurnalNcStr = [NSString stringWithFormat:@"%@",request.response_dic[@"gutengoyleNc"][@"tetendiurnalNc"]];
                [strongSelf.downButton startCountDownWithSecond:tetendiurnalNcStr.intValue > 0 ? tetendiurnalNcStr.intValue : 60.f];
            }
        }else{
            [PTTools showToast:PTNotNull(request.response_message)];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

#pragma mark - 登录
- (void)getPTLoginCode:(NSString*)code
{
    NSString *phoneNubString = [self.phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSDictionary *pointDic = [PTTools getStartTime:self.startTime mutenniumNc:@"1" hytenrarthrosisNc:@"21"];
    NSDictionary *dic = @{
                          @"sttenwardessNc":PTNotNull(phoneNubString),
                          @"fitenroticNc":PTNotNull(code),
                          @"latentescencyNc":@"duiuyiton",
                          @"point":pointDic,
                         };
    WEAKSELF
    PTLoginService *loginService  = [[PTLoginService alloc] initWithPhoneDataDic:dic];
    [loginService startWithCompletionBlockWithSuccess:^(__kindof PTBaseRequest * _Nonnull request) {
        STRONGSELF
        if(request.response_code != 0){
            [strongSelf.codeInputView clearAll];
            [PTTools showToast:PTNotNull(request.response_message)];
            return;
        }
        [strongSelf dataProcesDic:request.response_dic];
        [strongSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (void)dataProcesDic:(NSDictionary*)dic
{
    if(![dic isKindOfClass:[NSDictionary class]] ||!dic[@"gutengoyleNc"])return;
    [PTUser initwithUserModelDic:dic[@"gutengoyleNc"]];
    if(self.loginResultBlock){
        self.loginResultBlock();
    }
}

#pragma mark - lazy

- (CRBoxInputView *)codeInputView{
    if(!_codeInputView){
        CRBoxInputCellProperty *cellProperty = [[CRBoxInputCellProperty alloc] init];
        cellProperty.cellBorderColorNormal = PTUIColorFromHex(0x000000);
        cellProperty.cellBorderColorFilled = PTUIColorFromHex(0x000000);
        cellProperty.cellBorderColorSelected = PTUIColorFromHex(0x64F6FE);
        cellProperty.cellBgColorNormal = [UIColor whiteColor];
        cellProperty.cellBgColorFilled =  PTUIColorFromHex(0x64F6FE);
        cellProperty.cellCursorColor =[UIColor whiteColor];
        cellProperty.cellCursorWidth = 2;
        cellProperty.cellCursorHeight = 20.f;
        cellProperty.cornerRadius = 8;
        cellProperty.borderWidth = 1.f;
        cellProperty.cellFont = PT_Font_SD(20.f);
        _codeInputView = [[CRBoxInputView alloc] initWithCodeLength:6];
        _codeInputView.boxFlowLayout.itemSize = CGSizeMake(40.f,48.f);
        _codeInputView.boxFlowLayout.minLineSpacing = 6;
        _codeInputView.customCellProperty = cellProperty;
    }
    return _codeInputView;
}
- (void)dealloc{
    
}


@end
