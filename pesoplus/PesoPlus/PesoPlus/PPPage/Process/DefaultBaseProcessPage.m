//
//  DefaultBaseProcessPage.m
// FIexiLend
//
//  Created by jacky on 2024/11/20.
//

#import "DefaultBaseProcessPage.h"
#import "PPSelfConfigCenterAlert.h"

@interface DefaultBaseProcessPage () <UIGestureRecognizerDelegate>
@property (nonatomic, strong) PPSelfConfigCenterAlert *stayAlert;
@end

@implementation DefaultBaseProcessPage

- (id)init{
    self = [super init];
    if (self) {
        self.canGestureBack = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _startTime = [self nowTime];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.navigationController.interactivePopGestureRecognizer) {
        [self backAction];
        return NO;
    }
    return YES;
}

- (void)backAction {
    NSString *aString = @"Complete the form to";
    NSString *bString = @" apply for a loan, and we'll ";
    NSString *cString = @"tailor a loan amount just for you.";
    NSString *valueString = StrFormat(@"%@%@%@", aString, bString, cString);

    NSString *aString1 = @"Enhance your loan approval ";
    NSString *bString1 = @"chances by providing your emergency";
    NSString *cString1 = @" contact information now.";
    NSString *valueString1 = StrFormat(@"%@%@%@", aString1, bString1, cString1);
    
    NSString *aString2 = @"Complete your identification";
    NSString *bString2 = @" now for a chance to increase";
    NSString *cString2 = @" your loan limit.";
    NSString *valueString2 = StrFormat(@"%@%@%@", aString2, bString2, cString2);
    
    NSString *aString3 = @"Boost your credit ";
    NSString *bString3 = @"score by completing facial";
    NSString *cString3 = @" recognition now.";
    NSString *valueString3 = StrFormat(@"%@%@%@", aString3, bString3, cString3);

    NSString *aString4 = @"Take the final st";
    NSString *bString4 = @"ep to apply for your loan—submitting";
    NSString *cString4 = @" now will enhance your approval rate.";
    NSString *valueString4 = StrFormat(@"%@%@%@", aString4, bString4, cString4);


    NSArray *arr = @[@{@"title":valueString, @"icon":@"stay_note_0"}, @{@"title":valueString1, @"icon":@"stay_note_1"}, @{@"title":valueString2, @"icon":@"stay_note_2"}, @{@"title":valueString3, @"icon":@"stay_note_3"}, @{@"title":valueString4, @"icon":@"stay_note_4"}];
    NSDictionary * dic = arr[_step];

    [self showAlert:dic[@"title"] icon:dic[@"icon"]];
}

- (void)showAlert:(NSString *)title icon:(NSString *)icon {
    UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(24, ScreenHeight/2 - 270/2, ScreenWidth - 48, 270)];
    alertView.backgroundColor = UIColor.whiteColor;
    [alertView showAddToRadius:16];
    
    UIView *topVtem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, alertView.w, 86)];
    topVtem.backgroundColor = MainColor;
    [alertView addSubview:topVtem];
    
    UIButton *image = [[UIButton alloc] initWithFrame:CGRectMake(alertView.w - 86 - 10, 0, 86, 86)];
    [image setImage:ImageWithName(icon) forState:UIControlStateNormal];
    [topVtem addSubview:image];
    
    UILabel *Valuelabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, alertView.w - 128, 86)];
    Valuelabel.text = @"Are you sure you want to leave?";
    Valuelabel.textColor = UIColor.whiteColor;
    Valuelabel.font = FontCustom(16);
    Valuelabel.numberOfLines = 0;
    [topVtem addSubview:Valuelabel];
    
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, topVtem.bottom, alertView.w - 40, 90)];
    descLabel.text = title;
    descLabel.textColor = rgba(51, 51, 51, 1);
    descLabel.font = Font(16);
    descLabel.numberOfLines = 0;
    [topVtem addSubview:descLabel];
    
    UIButton *cancelBtn = [PPKingHotConfigView normalBtn:CGRectMake(14, descLabel.bottom + 6, alertView.w - 28, 42) title:@"Cancel" font:18];
    [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [alertView addSubview:cancelBtn];
    
    UIButton *confirmBtnItem = [PPKingHotConfigView normalBtn:CGRectMake(14, cancelBtn.bottom, alertView.w - 28, 42) title:@"Confirm" font:18];
    confirmBtnItem.backgroundColor = UIColor.whiteColor;
    [confirmBtnItem setTitleColor:MainColor forState:UIControlStateNormal];
    [confirmBtnItem addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    [alertView addSubview:confirmBtnItem];
    
    _stayAlert = [[PPSelfConfigCenterAlert alloc] initWithPPCenterCustomView:alertView];
    [_stayAlert show];
}

- (void)sureAction {
    [Page popToRootTabViewController];
    [_stayAlert hide];
}

- (void)cancelAction {
    [_stayAlert hide];
}

- (NSString *)endTime {
    return [self nowTime];
}

- (NSString *)nowTime {
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970]*1000;
    NSString *timeStr = StrValue(time);
    return notNull(timeStr);
}

- (NSDictionary *)track {
    NSArray *typeArr = @[@"22", @"23", @"24", @"25", @"26"];
    
    NSDictionary *pointDic = @{@"rsgothicCiopjko": self.startTime,
                               @"rsisraeliCiopjko":self.endTime,
                               @"rssynestheseaCiopjko":notNull(self.productId),
                               @"rsdehydrogenateCiopjko":typeArr[_step],
                               @"rsnonallergenicCiopjko":[PPHandleDevicePhoneInfo mirjhaDeviceidfv],
                               @"rsestroneCiopjko":notNull(User.latitude),
                               @"rssplodgyCiopjko":notNull(User.longitude)};
    
    return pointDic;
}


@end
