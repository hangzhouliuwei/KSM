//
//  PesoSettingVC.m
//  PesoApp
//
//  Created by Jacky on 2024/9/18.
//

#import "PesoSettingVC.h"
#import "PesoVerifyWanliuView.h"
#import "PesoLogouOutAPI.h"
@interface PesoSettingVC ()

@end

@implementation PesoSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)createUI
{
    [super createUI];
    self.titleString = @"Set Up";
    UIImageView *icon  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"set_logo"]];
    icon.contentMode = UIViewContentModeScaleAspectFit;
    icon.frame = CGRectMake(0, kNavBarAndStatusBarHeight+20, 133, 130);
    icon.centerX = self.view.centerX;
    icon.userInteractionEnabled = YES;
    [self.view addSubview:icon];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(15, icon.bottom+40, kScreenWidth-30, 273)];
    bgView.backgroundColor = ColorFromHex(0xF8F8F8);
    bgView.layer.cornerRadius = 16;
    bgView.layer.masksToBounds = YES;
    [self.view addSubview:bgView];
    
    QMUILabel *webSiteTileLabel = [[QMUILabel alloc] qmui_initWithFont:PH_Font(14.f) textColor:ColorFromHex(0x616C5F)];
    webSiteTileLabel.frame = CGRectMake(20, 20, 200, 18);
    webSiteTileLabel.text = @"Website";
    [bgView addSubview:webSiteTileLabel];

    
    QMUILabel *webSiteSubTileLabel = [[QMUILabel alloc] qmui_initWithFont:PH_Font_B(16) textColor:ColorFromHex(0x0B2C04)];
    webSiteSubTileLabel.text = @"https://www.blnylendingcorp.com";
    webSiteSubTileLabel.numberOfLines = 0;
    webSiteSubTileLabel.frame = CGRectMake(20, webSiteTileLabel.bottom+5, bgView.width-40, 21);
    [bgView addSubview:webSiteSubTileLabel];
    
    QMUILabel *emailL = [[QMUILabel alloc] qmui_initWithFont:PH_Font(14.f) textColor:ColorFromHex(0x616C5F)];
    emailL.frame = CGRectMake(20, webSiteSubTileLabel.bottom+15, 200, 18);
    emailL.text = @"Email";
    [bgView addSubview:emailL];

    
    QMUILabel *emailValueL = [[QMUILabel alloc] qmui_initWithFont:PH_Font_B(16) textColor:ColorFromHex(0x0B2C04)];
    emailValueL.text = @"cs@blnylendingcorp.com";
    emailValueL.numberOfLines = 0;
    emailValueL.frame = CGRectMake(20, emailL.bottom+5, 200, 21);
    [bgView addSubview:emailValueL];

    QMUILabel *version = [[QMUILabel alloc] qmui_initWithFont:PH_Font(14.f) textColor:ColorFromHex(0x616C5F)];
    version.frame = CGRectMake(20, emailValueL.bottom+15, 200, 18);
    version.text = @"Edition";
    [bgView addSubview:version];

    
    QMUILabel *versionValueL = [[QMUILabel alloc] qmui_initWithFont:PH_Font_B(16) textColor:ColorFromHex(0x0B2C04)];
    versionValueL.text = [NSString stringWithFormat:@"V%@",NotNil([PesoDeviceTool version])];
    versionValueL.numberOfLines = 0;
    versionValueL.frame = CGRectMake(20, version.bottom+5, 200, 21);
    [bgView addSubview:versionValueL];
    
    QMUIButton *logoutBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    logoutBtn.frame = CGRectMake(0, bgView.bottom+40, 270, 50);
    logoutBtn.centerX = self.view.centerX;
    logoutBtn.titleLabel.font = PH_Font_B(18.f);
    logoutBtn.backgroundColor = ColorFromHex(0xFCE815);
    [logoutBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [logoutBtn setTitle:@"Logout" forState:UIControlStateNormal];
    logoutBtn.layer.cornerRadius = 25;
    logoutBtn.layer.masksToBounds = YES;
    [logoutBtn addTarget:self action:@selector(logoutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logoutBtn];
    
    
    QMUIButton *accountBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    accountBtn.frame = CGRectMake(0, logoutBtn.bottom+12, 270, 50);
    accountBtn.centerX = self.view.centerX;
    accountBtn.titleLabel.font = PH_Font_B(14.f);
    accountBtn.backgroundColor = ColorFromHex(0xF1F1F1);
    [accountBtn setTitleColor:ColorFromHex(0x898989) forState:UIControlStateNormal];
    [accountBtn setTitle:@"Cancel Account" forState:UIControlStateNormal];
    accountBtn.layer.cornerRadius = 25;
    accountBtn.layer.masksToBounds = YES;
    [accountBtn addTarget:self action:@selector(accountBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:accountBtn];
    
}
- (void)logoutBtnClick:(UIButton *)btn{
    btn.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        btn.enabled = YES;
    });
    PesoVerifyWanliuView *logoutView = [[PesoVerifyWanliuView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    [logoutView setTitle:@"Are you sure\nyou want to leave the software?"];
    WEAKSELF
    logoutView.confirmBlock = ^{
        STRONGSELF
        [strongSelf logout];
    };
    [logoutView show];
}
- (void)accountBtnClick:(UIButton *)btn{
    
    btn.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        btn.enabled = YES;
    });
    PesoVerifyWanliuView *logoutView = [[PesoVerifyWanliuView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    [logoutView setTitle:@"Are you sure you want to log out of this user?"];
    WEAKSELF
    logoutView.confirmBlock = ^{
        STRONGSELF
        [strongSelf logout];
    };
    [logoutView show];
}
- (void)logout{
    PesoLogouOutAPI *logoutService = [[PesoLogouOutAPI alloc] init];
    [logoutService startWithCompletionBlockWithSuccess:^(__kindof PesoBaseAPI * _Nonnull request) {
        if(request.responseCode != 0){
            [PesoUtil showToast:request.responseMessage];
            return;
        }
        [PesoUserCenter.sharedPesoUserCenter logout];
        [PesoRootVCCenter.sharedPesoRootVCCenter switchIndex:0];
        [[PesoRootVCCenter sharedPesoRootVCCenter] checkLogin:^{
            
        }];
    } failure:^(__kindof PesoBaseAPI * _Nonnull request) {
        
    }];
}
@end
