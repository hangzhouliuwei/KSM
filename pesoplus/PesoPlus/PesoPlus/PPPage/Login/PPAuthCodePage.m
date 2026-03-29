//
//  PPAuthCodePage.m
// FIexiLend
//
//  Created by jacky on 2024/11/12.
//

#import "PPAuthCodePage.h"
#import "PPTimeDown.h"
#import "PPAuthCodeView.h"

@interface PPAuthCodePage () <UITextFieldDelegate>
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UIButton *sendButton;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, strong) PPAuthCodeView *codeView;

@end

@implementation PPAuthCodePage

- (void)viewDidLoad {
    [super viewDidLoad];
    self.startTime = [self nowTime];
    self.view.backgroundColor = COLORA(247, 251, 255, 1);
    UIImageView *loginHeaderBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 255*WS)];
    loginHeaderBg.image = ImageWithName(@"login_header");
    [self.content addSubview:loginHeaderBg];
    
    UIImageView *loginLogo = [[UIImageView alloc] initWithFrame:CGRectMake(12, StatusBarHeight + 18, 30, 30)];
    loginLogo.image = ImageWithName(@"app_icon");
    [loginHeaderBg addSubview:loginLogo];
    
    UIImageView *loginService = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth - 32, StatusBarHeight + 18, 20, 20)];
    loginService.image = ImageWithName(@"login_service");
    [loginHeaderBg addSubview:loginService];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, loginHeaderBg.h - 20, 36, 36)];
    image.image = ImageWithName(@"header_bottom");
    image.centerX = ScreenWidth/2;
    [loginHeaderBg addSubview:image];
    
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, loginHeaderBg.bottom + 16, ScreenWidth - 50, 22)];
    descLabel.text = @"Please enter verification code";
    descLabel.textColor = UIColor.blackColor;
    descLabel.font = Font(16);
    [self.content addSubview:descLabel];

    UILabel *sendLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, descLabel.bottom + 9, ScreenWidth - 50, 25)];
    
    NSString *aString = @"SMS";
    NSString *bString = @" verification code";
    NSString *cString = @" has been sent to";
    NSString *valueString = StrFormat(@"%@%@%@", aString, bString, cString);

    sendLabel.text = valueString;
    sendLabel.textColor = COLORA(75, 135, 211, 1);
    sendLabel.font = Font(12);
    [self.content addSubview:sendLabel];

    UILabel *phone = [[UILabel alloc] initWithFrame:CGRectMake(25, sendLabel.bottom + 8, 200, 26)];
    phone.text = [self insertABigSpace:self.phone];
    phone.textColor = UIColor.blackColor;
    phone.font = FontBold(18);
    [self.view addSubview:phone];
    
    self.sendButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - 105, phone.y, 80, 26)];
    [self.sendButton setTitle:StrValue(self.time) forState:UIControlStateNormal];
    self.sendButton.backgroundColor = COLORA(212, 231, 255, 1);
    self.sendButton.userInteractionEnabled = NO;
    self.sendButton.titleLabel.font = Font(12);
    [self.content addSubview:self.sendButton];
    [self.sendButton addTarget:self action:@selector(resendAction) forControlEvents:UIControlEventTouchUpInside];
    [self.sendButton showAddToRadius:13];

    
    kWeakself;
    self.codeView = [[PPAuthCodeView alloc] initWithFrame:CGRectMake(25, self.sendButton.bottom + 20, ScreenWidth - 50, 44)];
    self.codeView.changeBlock = ^{
        [weakSelf checkCodeStatus];
    };
    [self.content addSubview:self.codeView];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(25, self.codeView.bottom + 60, ScreenWidth - 50, 48)];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    backButton.titleLabel.font = FontCustom(18);
    [backButton setTitleColor:UIColor.whiteColor forState:(UIControlStateNormal)];
    [backButton showAddToRadius:24];
    backButton.backgroundColor = MainColor;
    [self.content addSubview:backButton];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(counting:) name:CountingStarSecondsAction object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countingFinishCompleted) name:CountingStarSecondsFinish object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWhenEnterTheBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    [CountDown countDown:CountDownTypeLogin time:self.time];
    
    [Track ppConfigReqUserLoction:^(BOOL value) {
    }];
}

- (void)counting:(NSNotification *)notification {
    self.sendButton.userInteractionEnabled = NO;
    self.sendButton.backgroundColor = COLORA(212, 231, 255, 1);
    NSInteger timeOut = [notification.object integerValue];
    [self.sendButton setTitle: [NSString stringWithFormat:@"%ldS",(long)timeOut] forState:(UIControlStateNormal)];
}

- (void)appWhenEnterTheBackground{
    UIApplication *app = [UIApplication sharedApplication];
    __block UIBackgroundTaskIdentifier bgTask;
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid){
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    }];
}

- (void)checkCodeStatus {
    NSString *code =  self.codeView.text;
    if (code.length < 6) {
        return;
    }
    [self sureAction];
}

- (void)backAction {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!isBlankStr(_msg)) {
        [PPMiddleCenterToastView show:_msg];
    }
    [self.codeView.textView becomeFirstResponder];
}

- (void)countingFinishCompleted {
    self.sendButton.userInteractionEnabled = YES;
    self.sendButton.backgroundColor = MainColor;
    [self.sendButton setTitle:@"Resend" forState:(UIControlStateNormal)];
}


- (void)sureAction {
    NSString *code =  self.codeView.text;
    if (code.length != 6) {
        [PPMiddleCenterToastView show:@"Please enter valid verification code"];
        return;
    }
    NSDictionary *dic = @{
        p_username: notNull(self.phone),
        p_smsCode: notNull(self.codeView.text),
        p_point:[self track],
        @"rsloofahCiopjko":@"duiuyiton"
    };
    kWeakself;
    [Http post:R_login_sms params:dic success:^(Response *response) {
        if (response.success) {
            [weakSelf loginSucessed];
        }else {
            weakSelf.codeView.text = @"";
            [PPMiddleCenterToastView show:response.msg];
        }
    } failure:^(NSError *error) {
        
    } showLoading:YES];
}

- (NSDictionary *)track {
    NSDictionary *pointDic = @{@"rsgothicCiopjko": self.startTime,
                               @"rsisraeliCiopjko":self.endTime,
                               @"rssynestheseaCiopjko":@"1",
                               @"rsdehydrogenateCiopjko":@"21",
                               @"rsnonallergenicCiopjko":[PPHandleDevicePhoneInfo mirjhaDeviceidfv],
                               @"rsestroneCiopjko":notNull(User.latitude),
                               @"rssplodgyCiopjko":notNull(User.longitude)};
    
    return pointDic;
}


- (void)loginSucessed {
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)timeAction:(NSInteger)time {
    [CountDown countDown:CountDownTypeLogin time:time];
}


- (NSString *)endTime {
    return [self nowTime];
}

- (NSString *)nowTime {
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970]*1000;
    NSString *timeStr = StrValue(time);
    return notNull(timeStr);
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (![self isNumber:string]) {
        return NO;
    }
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (newString.length >= 15) {
        newString = [newString substringToIndex:15];
    }
    if (newString.length >= 10) {
        self.sendButton.userInteractionEnabled = YES;
        self.sendButton.backgroundColor = MainColor;
    }else {
        self.sendButton.userInteractionEnabled = NO;
        self.sendButton.backgroundColor = COLORA(212, 231, 255, 1);
    }
    textField.text = newString;
    return NO;
}




- (NSString *)insertABigSpace:(NSString *)input {
    NSMutableString *result = [NSMutableString string];
    for (NSInteger i = 0; i < input.length; i++) {
        if (i > 0 && i % 4 == 0) {
            [result appendString:@" "];
        }
        [result appendFormat:@"%C", [input characterAtIndex:i]];
    }
    return result;
}

- (BOOL)isNumber:(NSString *)string {
    unichar c;
    for (int i = 0; i < string.length; i++) {
        c = [string characterAtIndex:i];
        if (!isdigit(c)) {
            return NO;
        }
    }
    return YES;
}

- (void)resendAction {
    NSDictionary *dic = @{
        p_phone: notNull(self.phone),
        @"rsexpiableCiopjko": @"juyttrr"
    };
    [Http post:R_send_sms params:dic success:^(Response *response) {
        if (response.success) {
            NSDictionary *item = response.dataDic[p_item];
            NSInteger time = [item[p_time] integerValue];
            NSString *msg = item[p_message];
            [PPMiddleCenterToastView show:msg];
            [CountDown countDown:CountDownTypeLogin time:time];
        }
    } failure:^(NSError *error) {
        
    } showLoading:YES];
}


@end
