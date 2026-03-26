//
//  CodeViewController.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/26.
//

#import "PLPCodeViewController.h"
#import "SLBlockCodeView.h"
#import "PLPBaseTabbarController.h"
#import "LocationAlertView.h"
@interface PLPCodeViewController ()<SLBlockCodeViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic) SLBlockCodeView *blockCodeView;
@property (nonatomic) UIButton *sendButton;
@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, assign)NSInteger count;
@end

@implementation PLPCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.lastCount > 0) {
        self.count = self.lastCount;
    }else
    {
        self.count = 60;
    }
    kWeakSelf
    self.hideServeImageView = true;
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0));
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (weakSelf.count <= 0) {
                weakSelf.sendButton.userInteractionEnabled = true;
                [weakSelf.sendButton setTitle:@"Resend" forState:UIControlStateNormal];
                [weakSelf.sendButton setBackgroundColor:kBlueColor_0053FF];
            }else
            {
                weakSelf.sendButton.userInteractionEnabled = false;
                weakSelf.count -- ;
                NSString *str = [NSString stringWithFormat:@"%lds",weakSelf.count];
                [weakSelf.sendButton setTitle:str forState:UIControlStateNormal];
                [weakSelf.sendButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
                [weakSelf.sendButton setBackgroundColor:kGrayColor_C9C9C9];
            }
        });
    });
    dispatch_activate(timer);
    self.timer = timer;
    [[PLPLocationManager sharedManager] requestLocactionInfo:^(BOOL hasPermission, id  _Nonnull info) {
        if (!hasPermission) {
            LocationAlertView *view = [[LocationAlertView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 192)];
            view.okBlk = ^{
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
                }
            };
            [view popAlertViewOnBottom];
        }
    }];
}
-(void)BASE_BackAction
{
    [self saveAcountInfo];
    [self.navigationController popViewControllerAnimated:YES];
}
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    [self saveAcountInfo];
    return true;
}
-(void)saveAcountInfo
{
    NSString *timeKey = [NSString stringWithFormat:@"%@_time",self.phoneStr];
    NSString *countKey = [NSString stringWithFormat:@"%@_count",self.phoneStr];
//    NSString *key = [NSString stringWithFormat:@"%@",self.phoneStr];
    [kMMKV setDate:[NSDate date] forKey:timeKey];
    [kMMKV setInt64:self.count forKey:countKey];
}
-(void)BASE_GenerateSubview
{
    [self.view addSubview:self.baseImageView];
    CGFloat scale = 375 / 260.0;
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenW / scale)];
    headImageView.image = kImageName(@"base_head_medium");
    [self.view addSubview:headImageView];
    UIView *logoBgView = [[UIView alloc] initWithFrame:CGRectMake((kScreenW - 250) / 2.0, kStatusHeight + 30, 125, 35)];
    [headImageView addSubview:logoBgView];
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    iconImageView.image = kImageName(@"logo");
    [logoBgView addSubview:iconImageView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(6 + iconImageView.right, 0, logoBgView.width - (6 + iconImageView.right), logoBgView.height)];
    [label pp_setPropertys:@[@"Cashhere", kBoldFontSize(20),kWhiteColor]];
    label.width = [label.text widthWithFont:label.font];
    [logoBgView addSubview:label];
    logoBgView.width = label.width + 6 + iconImageView.width;
    logoBgView.left = (kScreenW - logoBgView.width) / 2.0;
    
    UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake((kScreenW - 300) / 2.0, logoBgView.bottom + 27, 300, 47)];
    [valueLabel pp_setPropertys:@[[PLPCommondTools formatterUnitValue:@"20000"], kWhiteColor, kBoldFontSize(34), @(NSTextAlignmentCenter)]];
    [self.view addSubview:valueLabel];
    
    UILabel *desLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, valueLabel.bottom, kScreenW, 20)];
    [desLabel pp_setPropertys:@[@"Maximum Borrowable Amount", kAlphaHexColor(0xffffff, 0.6), kFontSize(14), @(NSTextAlignmentCenter)]];
    [self.view addSubview:desLabel];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, headImageView.bottom - 14, kScreenW, kScreenH - (headImageView.bottom - 14))];
    bgView.backgroundColor = kWhiteColor;
    [self.view addSubview:bgView];
    [bgView clipTopLeftAndTopRightCornerRadius:14];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 32, bgView.width - 2 * 20, 20)];
    [titleLabel pp_setPropertys:@[kBoldFontSize(22), kBlackColor_333333, @"Please enter verification code"]];
    titleLabel.height = [titleLabel.text heightWithWidth:titleLabel.width font:titleLabel.font];
    [bgView addSubview:titleLabel];
    
    UILabel *smsLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10 + titleLabel.bottom, bgView.width - 2 * 20, 22)];
    [smsLabel pp_setPropertys:@[kFontSize(14), kBlackColor_333333, @"SMS verification code has been sent to"]];
    [bgView addSubview:smsLabel];
    
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 9 + smsLabel.bottom, 0, 18)];
    [phoneLabel pp_setPropertys:@[kBoldFontSize(16), kBlackColor_333333, self.phoneStr?:@""]];
    phoneLabel.width = [phoneLabel.text widthWithFont:phoneLabel.font];
    [bgView addSubview:phoneLabel];
    
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.frame = CGRectMake(phoneLabel.right + 10, phoneLabel.top, 62, 21);
    sendButton.titleLabel.font = kFontSize(13);
    [sendButton setTitle:@"Resend" forState:UIControlStateNormal];
    [sendButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(handleSendButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    sendButton.layer.cornerRadius = sendButton.height / 2.0;
    self.sendButton = sendButton;
    [bgView addSubview:sendButton];
    
    CGFloat width = (bgView.width - 2 * 20 - 50 * 6) / 5.0;
    self.blockCodeView = [[SLBlockCodeView alloc] initWithCount:6 margin:width];
    self.blockCodeView.frame = CGRectMake(20, phoneLabel.bottom + 30, bgView.width - 40, 50);
    self.blockCodeView.delegate = self;
    [bgView addSubview:self.blockCodeView];
    
    [self.blockCodeView.textField becomeFirstResponder];
//    UILabel *voiceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 28 + _blockCodeView.bottom, 0, 22)];
//    [voiceLabel pp_setPropertys:@[kBoldFontSize(13), kBlueColor_3274FD, @"Get Voice Verification Code"]];
//    phoneLabel.width = [phoneLabel.text widthWithFont:phoneLabel.font];
//    [phoneLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:sendButton action:@selector(handleTapGestureAction:)]];
//    [bgView addSubview:voiceLabel];
}
//-(void)handleTapGestureAction:(UITapGestureRecognizer *)tapG
//{
//    [self sendVoiceCode];
//}
#pragma mark - SLBlockCodeViewDelegate
- (void)blockCodeViewDidInputCompleted:(SLBlockCodeView *)blockCodeView {
    if (blockCodeView.code.length == 6) {
        [self.view endEditing:YES];
        kShowLoading
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"stwatwelverdessNc"] = _phoneStr;
        dic[@"firotwelveticNc"] = blockCodeView.code;
        dic[@"latetwelvescencyNc"] = @"duiuyiton";
        NSMutableDictionary *temp = [NSMutableDictionary dictionary];
        dic[@"point"] = temp;
        temp[@"deamtwelveatoryNc"] = self.startTime;
        temp[@"munitwelveumNc"] = @"1";
        temp[@"hyratwelverthrosisNc"] = @"21";
        temp[@"boomtwelveofoNc"] = [[PLPLocationManager sharedManager] getCurrentLatitude];
        temp[@"unultwelveyNc"] = [PLPCommondTools getCurrentTimeStamp];
        temp[@"unevtwelveoutNc"] = [[PLPLocationManager sharedManager] getCurrentLongitude];
        temp[@"cacotwelvetomyNc"] = [PLPCommondTools getDeviceIDFV];
        [[PLPNetRequestManager plpJsonManager] POSTURL:@"twelvecp/login" paramsInfo:dic successBlk:^(id  _Nonnull responseObject) {
            NSDictionary *dic = responseObject[@"viustwelveNc"][@"gugotwelveyleNc"];
            NSString *sessionId = [NSString stringWithFormat:@"%@",dic[@"fifotwelveotedNc"]];
            NSString *token = [NSString stringWithFormat:@"%@",dic[@"tetotwelvegenesisNc"]];
            NSString *name = [NSString stringWithFormat:@"%@",dic[@"stwatwelverdessNc"]];
            NSString *uid = [NSString stringWithFormat:@"%@",dic[@"bamytwelveNc"]];
            [kMMKV setString:sessionId forKey:kSessionIDKey];
            [kMMKV setBool:true forKey:kIsLoginKey];
            [kMMKV setString:_phoneStr forKey:kPhoneKey];
            [kMMKV setBool:[dic[@"aoNctwelve"] boolValue] forKey:kReviewKey];
            [kMMKV setString:token forKey:kTokenKey];
            [kMMKV setString:name forKey:kNameKey];
            [kMMKV setString:uid forKey:kUserIdKey];
            [self saveAcountInfo];
            PLPBaseTabbarController *vc = [PLPBaseTabbarController new];
            [PLPCommondTools resetKeyWindowRootViewController:vc];
        } failureBlk:^(NSError * _Nonnull error) {
            if (error.code == -1) {
                blockCodeView.textField.text = @"";
                for (UILabel *label in blockCodeView.labels) {
                    label.text = @"";
                }
                [blockCodeView.textField becomeFirstResponder];
            }
        }];
        
    }
}
-(void)sendVoiceCode
{
    kShowLoading
    [[PLPNetRequestManager plpJsonManager] POSTURL:@"twelvecp/get_code" paramsInfo:@{@"chretwelveographyNc":_phoneStr?:@"",@"betytwelveNc":@"juyttrr"} successBlk:^(id  _Nonnull responseObject) {
        kHideLoading
        kPLPPopInfoWithStr(responseObject[@"frwntwelveNc"]?:@"");
        self.count = 60;
    } failureBlk:^(NSError * _Nonnull error) {
        
    }];
}
-(void)handleSendButtonAction:(UIButton *)button
{
    kShowLoading
    [[PLPNetRequestManager plpJsonManager] POSTURL:@"twelvecp/get_code" paramsInfo:@{@"chretwelveographyNc":_phoneStr?:@"",@"betytwelveNc":@"juyttrr"} successBlk:^(id  _Nonnull responseObject) {
        kHideLoading
        kPLPPopInfoWithStr(responseObject[@"frwntwelveNc"]?:@"");
        self.count = 60;
    } failureBlk:^(NSError * _Nonnull error) {
        
    }];
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
