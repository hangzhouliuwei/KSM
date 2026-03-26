//
//  SettingViewController.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/9/10.
//

#import "PLPSettingViewController.h"
#import "LogoutAlertView.h"
#import "PLPLoginRegistViewController.h"
#import "PLPBaseNavigationController.h"
@interface PLPSettingViewController ()
@property(nonatomic)UIImageView *logoImageView;
@end

@implementation PLPSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Set Up";
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, self.view.bounds.size.width, 283);
    gradientLayer.colors = @[
        (__bridge id)kBlueColor_0053FF.CGColor,  // #2964F6
        (__bridge id)kHexColor(0xF5F5F5).CGColor   // #F9F9F9
    ];
    gradientLayer.startPoint = CGPointMake(0.5, 0.0);
    gradientLayer.endPoint = CGPointMake(0.5, 1.0);
    [self.view.layer insertSublayer:gradientLayer atIndex:0];
}
-(void)BASE_GenerateSubview
{
    self.logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenW - 99) / 2.0, 60 + kTopHeight, 99, 99)];
    self.logoImageView.image = kImageName(@"logo");
//    self.logoImageView.layer.masksToBounds = self.logoImageView.layer.cornerRadius =
    [self.view addSubview:self.logoImageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 13 + _logoImageView.bottom, kScreenW, 32)];
    [label pp_setPropertys:@[kBoldFontSize(23),kBlueColor_0053FF,@(NSTextAlignmentCenter),@"Cashhere"]];
    [self.view addSubview:label];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(14, label.bottom + 41, kScreenW - 28, 226)];
    bgView.backgroundColor = kWhiteColor;
    bgView.layer.cornerRadius = 12;
    [self.view addSubview:bgView];
    NSArray *array1 = @[@"Website",@"Email",@"Edition"];
    NSArray *array2 = @[@"https://www.oragon-lending.com",@"cs@oragon-lending.com",[NSString stringWithFormat:@"V%@",[PLPCommondTools fetchShortVersion]]];
    for (int i = 0; i < array1.count; i++) {
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 20 + (51 + 19) * i, bgView.width - 2 * 16, 19)];
        [tipLabel pp_setPropertys:@[kFontSize(14),kGrayColor_999999,array1[i]]];
        [bgView addSubview:tipLabel];
        
        UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(tipLabel.left, tipLabel.bottom + 2, tipLabel.width, 25)];
        [valueLabel pp_setPropertys:@[array2[i],kBoldFontSize(18),kBlackColor_333333]];
        [bgView addSubview:valueLabel];
        
        if (i < 2) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(tipLabel.left, tipLabel.bottom + 39, tipLabel.width, 1)];
            lineView.backgroundColor = kHexColor(0xe5e5e5);
            [bgView addSubview:lineView];
        }
    }
    CGFloat itemWidth = (kScreenW - 2 * 14 - 10) / 2.0;
    NSArray *titleArray = @[@"Logout",@"Cancel Account"];
    for (int i = 0; i < titleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(14 + (itemWidth + 10) * i, kScreenH - 24 - kBottomSafeHeight - 47, itemWidth, 47);
        [button addTarget:self action:@selector(handleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100 + i;
        [self.view addSubview:button];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        button.layer.cornerRadius = button.height / 2.0;
        if (i == 0) {
            [button setTitleColor:kBlueColor_0053FF forState:UIControlStateNormal];
            button.layer.borderWidth = 1;
            button.layer.borderColor = kBlueColor_0053FF.CGColor;
        }else
        {
            [button setTitleColor:kWhiteColor forState:UIControlStateNormal];
            button.backgroundColor = kBlueColor_0053FF;
        }
    }
    
    
}
-(void)logoutAccount
{
    [kMMKV setBool:false forKey:kIsLoginKey];
    [kMMKV setString:@"" forKey:kSessionIDKey];
    [kMMKV setString:@"" forKey:kPhoneKey];
    [kMMKV setBool:false forKey:kReviewKey];
    [kMMKV setString:@"" forKey:kTokenKey];
    [kMMKV setString:@"" forKey:kNameKey];
    [kMMKV setString:@"" forKey:kUserIdKey];
}
-(void)handleButtonAction:(UIButton *)button
{
    kWeakSelf
    NSInteger tag = button.tag - 100;
    if (tag == 0) {//logout
        LogoutAlertView *view = [[LogoutAlertView alloc] initWithFrame:CGRectMake(0, 0, 321, 180)];
        view.tapBlk = ^(NSInteger index) {
            if (index == 0) {
                kShowLoading
                [[PLPNetRequestManager plpJsonManager] GETURL:@"twelvecp/logout" paramsInfo:nil successBlk:^(id  _Nonnull responseObject) {
                    kHideLoading
                    kPLPPopInfoWithStr(responseObject[@"frwntwelveNc"]);
                    [weakSelf logoutAccount];
                    PLPLoginRegistViewController *vc = [PLPLoginRegistViewController new];
                    PLPBaseNavigationController *navC = [[PLPBaseNavigationController alloc] initWithRootViewController:vc];
                    [PLPCommondTools resetKeyWindowRootViewController:navC];
                } failureBlk:^(NSError * _Nonnull error) {
                    
                }];
            }
        };
        view.infoLabel.text = @"Are you sure you want to leave the software?";
        [view popAlertViewOnCenter];
    }else//cancel account
    {
        LogoutAlertView *view = [[LogoutAlertView alloc] initWithFrame:CGRectMake(0, 0, 321, 180)];
        view.tapBlk = ^(NSInteger index) {
            if (index == 0) {
                kShowLoading
                [[PLPNetRequestManager plpJsonManager] GETURL:@"twelvecp/logout" paramsInfo:nil successBlk:^(id  _Nonnull responseObject) {
                    kHideLoading
                    kPLPPopInfoWithStr(responseObject[@"frwntwelveNc"]);
                    [weakSelf logoutAccount];
                    PLPLoginRegistViewController *vc = [PLPLoginRegistViewController new];
                    PLPBaseNavigationController *navC = [[PLPBaseNavigationController alloc] initWithRootViewController:vc];
                    [PLPCommondTools resetKeyWindowRootViewController:navC];
                } failureBlk:^(NSError * _Nonnull error) {
                    
                }];
            }
        };
        view.infoLabel.text = @"Are you sure you want to log out of this user?";
        [view popAlertViewOnCenter];
    }
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
