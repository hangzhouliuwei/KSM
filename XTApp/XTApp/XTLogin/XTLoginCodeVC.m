//
//  XTLoginCodeVC.m
//  XTApp
//
//  Created by xia on 2024/9/4.
//

#import "XTLoginCodeVC.h"
#import "XTPhoneCodeApi.h"
#import "XTLoginVC.h"
#import "XTHtmlVC.h"
#import "XTCodeAltView.h"
#import <YFPopView/YFPopView.h>
#import "XTLoginVC.h"

@interface XTLoginCodeVC ()

@property(nonatomic,copy) NSString *countDown;
@property(nonatomic,copy) NSString *phone;
@property(nonatomic,weak) XTLoginVC *loginVC;
@property(nonatomic,weak) UITextField *textField;
@property(nonatomic,weak) dispatch_source_t codeTimer;

@end

@implementation XTLoginCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *iconImg = [UIImageView xt_img:@"xt_login_icon" tag:0];
    [self.xt_navView addSubview:iconImg];
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.xt_navView.mas_left).offset(20);
        make.centerY.equalTo(self.xt_bkBtn);
    }];
    
    UILabel *appNameLab = [UILabel xt_lab:CGRectZero text:XT_App_Name font:XT_Font_SD(16) textColor:[UIColor whiteColor] alignment:NSTextAlignmentLeft tag:0];
    [self.xt_navView addSubview:appNameLab];
    [appNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImg.mas_right).offset(10);
        make.centerY.equalTo(self.xt_bkBtn);
    }];
    
    self.xt_bkBtn.hidden = YES;
    UIImageView *bgImg = [UIImageView xt_img:@"xt_login_code_top_bg" tag:0];
    [self.view addSubview:bgImg];
    [bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top);
    }];
    self.xt_navView.backgroundColor = [UIColor clearColor];
    [self.view bringSubviewToFront:self.xt_navView];
    
    UIView *view = [UIView new];
    view.clipsToBounds = YES;
    view.layer.cornerRadius = 20;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(bgImg.mas_bottom).offset(-23);
        make.height.mas_equalTo(305);
    }];
    
    [view.layer addSublayer:[UIView xt_layer:@[(__bridge id)XT_RGB(0xF3FF9B, 1.0f).CGColor,(__bridge id)XT_RGB(0xFFFFFF, 1.0f).CGColor] locations:@[@0,@1.0f] startPoint:CGPointMake(0.5, 0) endPoint:CGPointMake(0.5, 0.48) size:CGSizeMake(self.view.width, 305)]];
    
    UILabel *titLab = [UILabel xt_lab:@"" font:XT_Font(17) textColor:[UIColor blackColor] alignment:NSTextAlignmentLeft isPriority:YES tag:0];
    titLab.numberOfLines = 0;
    [self.view addSubview:titLab];
    [titLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(27);
        make.right.equalTo(self.view.mas_right).offset(-27);
        make.top.equalTo(view.mas_top).offset(23);
    }];
    
    titLab.attributedText = [NSString xt_strs:@[@"Log in",@"to experience personal loan services now"] fonts:@[XT_Font_M(31),XT_Font_M(17)] colors:@[XT_RGB(0x0BB559, 1.0f),XT_RGB(0x000000, 1.0f)]];
    
    
    UIView *codeView = [UIView xt_frame:CGRectZero color:[UIColor whiteColor]];
    codeView.layer.cornerRadius = 26;
    codeView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1100].CGColor;
    codeView.layer.shadowOffset = CGSizeMake(0,1);
    codeView.layer.shadowOpacity = 1;
    codeView.layer.shadowRadius = 4;
    [self.view addSubview:codeView];
    [codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.top.equalTo(titLab.mas_bottom).offset(20);
        make.height.mas_equalTo(52);
    }];
    
    UILabel *logoLab = [UILabel xt_lab:@"+63" font:XT_Font_M(17) textColor:XT_RGB(0x0BB559, 1.0f) alignment:NSTextAlignmentCenter isPriority:YES tag:0];
    [self.view addSubview:logoLab];
    [logoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(codeView.mas_left).offset(26);
        make.centerY.equalTo(codeView);
        make.height.mas_equalTo(20);
    }];
    
    UITextField *phoneTextField = [UITextField xt_textField:NO placeholder:@"Phone number" font:XT_Font_M(14) textColor:[UIColor blackColor] withdelegate:self];
    phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:phoneTextField];
    self.textField = phoneTextField;
    [phoneTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(logoLab.mas_right).offset(27);
        make.right.equalTo(codeView.mas_right).offset(-20);
        make.centerY.equalTo(codeView);
        make.height.mas_equalTo(codeView);
    }];
    
    UIButton *readBtn = [UIButton xt_btn:@" I have read and agree with the" font:XT_Font(12) textColor:[UIColor blackColor] cornerRadius:0 tag:0];
    [self.view addSubview:readBtn];
    [readBtn setImage:XT_Img(@"xt_login_code_select_yes") forState:UIControlStateSelected];
    [readBtn setImage:XT_Img(@"xt_login_code_select_no") forState:UIControlStateNormal];
    [readBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(codeView.mas_left).offset(16);
        make.top.equalTo(phoneTextField.mas_bottom).offset(25);
        make.height.mas_equalTo(25);
    }];
    readBtn.selected = YES;
    readBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        readBtn.selected = !readBtn.selected;
        return [RACSignal empty];
    }];
    
    UIButton *privacyBtn = [UIButton xt_btn:@"" font:nil textColor:nil cornerRadius:0 tag:0];
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Privacy Agreement" attributes:@{
        NSFontAttributeName:XT_Font_B(12),
        NSForegroundColorAttributeName:XT_RGB(0x02CC56, 1.0f),
        NSUnderlineStyleAttributeName:[NSString stringWithFormat:@"%ld", NSUnderlineStyleSingle],
    }];
    [privacyBtn setAttributedTitle:str forState:UIControlStateNormal];
    [self.view addSubview:privacyBtn];
    [privacyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(readBtn.mas_right);
        make.centerY.equalTo(readBtn);
        make.height.mas_equalTo(readBtn);
    }];
    @weakify(self)
    privacyBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        XTHtmlVC *htmlVC = [[XTHtmlVC alloc] initUrl:XT_Privacy_Url];
        [self.navigationController pushViewController:htmlVC animated:YES];
        return [RACSignal empty];
    }];
    
    UIButton *codeBtn = [UIButton xt_btn:@"Let’s Go" font:XT_Font_B(20) textColor:[UIColor whiteColor] cornerRadius:24 tag:0];
    codeBtn.backgroundColor = XT_RGB(0x02CC56, 1.0f);
    [self.view addSubview:codeBtn];
    [codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.top.equalTo(readBtn.mas_bottom).offset(30);
        make.height.mas_equalTo(48);
    }];
    codeBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
//        self.countDown = @"60";
//        [self nextLoginVC];
//        [self goCountDown];
//        return [RACSignal empty];
        if(!readBtn.selected) {
            [self showAltView];
            return [RACSignal empty];
        }
        [self checkCode];
        return [RACSignal empty];
    }];
    
    UIButton *testBtn = [UIButton new];
    [self.view addSubview:testBtn];
    [testBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(50, 50 + XT_Bottom_Height));
    }];
    __block NSInteger tap = 0;
    testBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        tap ++;
        if(tap == 5) {
            tap = 0;
            [self xt_altView];
        }
        
        return [RACSignal empty];
    }];
}

-(void)xt_altView {
    UIAlertController *altVC = [UIAlertController alertControllerWithTitle:@"switch_environment" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [altVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"switch_environment";
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [altVC addAction:cancelAction];
    @weakify(self)
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self)
        UITextField *textField = altVC.textFields.firstObject;
        if(![textField.text isEqualToString:@"ksm2023"]) {
            [XTUtility xt_showTips:@"Password error！" view:nil];
            return;
        }
        [self xt_change];
    }];
    
    [altVC addAction:sureAction];
    
    [self xt_presentViewController:altVC animated:YES completion:nil modalPresentationStyle:UIModalPresentationFullScreen];
    
}

-(void)xt_change {
    UIAlertController *altVC = [UIAlertController alertControllerWithTitle:@"Environment" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [altVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Environment";
        textField.keyboardType = UIKeyboardTypeURL;
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [altVC addAction:cancelAction];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = altVC.textFields.firstObject;
        if(![textField.text hasPrefix:@"http://"] && ![textField.text hasPrefix:@"https://"]) {
            [XTUtility xt_showTips:@"Please enter the correct domain name" view:nil];
            return;
        }
        NSString *url = [NSString stringWithFormat:@"%@%@",textField.text,XT_Api_api];
        [url writeToFile:XT_Locality_Url_Path atomically:YES encoding:NSUTF8StringEncoding error:nil];

    }];
    
    [altVC addAction:sureAction];
    
    [self xt_presentViewController:altVC animated:YES completion:nil modalPresentationStyle:UIModalPresentationFullScreen];
}

- (void)textFieldDidChange:(UITextField *)textField {
    if (textField == self.textField && textField.text.length > 15) {
        self.textField.text =  [self.textField.text substringToIndex:15];
    }
}

- (void)showAltView {
    XTCodeAltView *view = [[XTCodeAltView alloc] init];
    view.center = self.view.center;
    YFPopView *popView = [[YFPopView alloc] initWithAnimationView:view];
    popView.animationStyle = YFPopViewAnimationStyleFade;
    popView.autoRemoveEnable = YES;
    [popView showPopViewOn:self.view];
}

- (void)checkCode {
    NSString *text = XT_Object_To_Stirng(self.textField.text);
    if(text.length > 15 || text.length < 8){
        [XTUtility xt_showTips:@"Please enter a valid phone number" view:self.view];
        return;
    }
    if([self.phone isEqualToString:text] && [self.countDown integerValue] > 0){
        [self nextLoginVC];
        return;
    }
    self.phone = text;
    @weakify(self)
    [self getCodeNumber:^{
        @strongify(self)
        [self nextLoginVC];
    }];
}

-(void)getCodeNumber:(XTBlock)block {
    @weakify(self)
    XTPhoneCodeApi *api = [[XTPhoneCodeApi alloc] initPhone:self.phone];
    [XTUtility xt_showProgress:self.view message:@"loading..."];
    [api xt_startRequestSuccess:^(NSDictionary *dic, NSString *str) {
        @strongify(self)
        [XTUtility xt_atHideProgress:self.view];
        [XTUtility xt_showTips:str view:nil];
        if([dic isKindOfClass:[NSDictionary class]] && [dic[@"gugosixyleNc"] isKindOfClass:[NSDictionary class]]) {
            self.countDown = XT_Object_To_Stirng(dic[@"gugosixyleNc"][@"tedisixurnalNc"]);
            [self goCountDown];
            if(block) {
                block();
            }
        }
    } failure:^(NSDictionary *dic, NSString *str) {
        @strongify(self)
        [XTUtility xt_atHideProgress:self.view];
        [XTUtility xt_showTips:str view:nil];
    } error:^(NSError * _Nonnull error) {
        @strongify(self)
        [XTUtility xt_atHideProgress:self.view];
    }];
}

-(void)goCountDown {
    if(self.codeTimer){
        dispatch_source_cancel(self.codeTimer);
    }
    __weak XTLoginCodeVC *weakSelf = self;
    __block NSInteger timeout = [self.countDown integerValue]; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    self.codeTimer = timer;
    dispatch_source_set_timer(timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(timer, ^{
        if(!weakSelf) {
            dispatch_source_cancel(timer);
        }
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(timer);
            weakSelf.countDown = @"0";
        }
        else {
            timeout--;
            weakSelf.countDown = [NSString stringWithFormat:@"%ld",timeout];
        }
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(timer);
            weakSelf.countDown = @"0";
        }
        if(weakSelf.loginVC) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.loginVC reloadCountDown:weakSelf.countDown];
            });
        }
    });
    dispatch_resume(timer);
}

-(void)nextLoginVC {
    XTLoginVC *vc = [[XTLoginVC alloc] initPhone:self.phone countDown:self.countDown];
    [self.navigationController pushViewController:vc animated:YES];
    vc.loginBlock = self.loginBlock;
    self.loginVC = vc;
    @weakify(self)
    vc.resendBlock = ^{
        @strongify(self)
        [self getCodeNumber:nil];
    };
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
