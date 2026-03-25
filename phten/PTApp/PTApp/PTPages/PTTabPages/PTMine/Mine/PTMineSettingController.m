//
//  PTMineSettingController.m
//  PTApp
//
//  Created by 刘巍 on 2024/8/12.
//

#import "PTMineSettingController.h"
#import "PTSettingLogoutView.h"
#import "PTSettLogoutService.h"

@interface PTMineSettingController ()

@end

@implementation PTMineSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = PTUIColorFromHex(0xF5F9FF);
    [self showtitle:@"Set Up" isLeft:YES disPlayType:PTDisplayTypeBlack];
    [self createSubUI];
}

- (void)createSubUI
{
    UIImageView *logoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_setting_logo"]];
    [self.view addSubview:logoImage];
    [logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(self.navView.mas_bottom).offset(60.f);
        make.width.height.mas_equalTo(124.f);
    }];
    
    UIImageView *webSiteImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_setting_back"]];
    [self.view addSubview:webSiteImage];
    [webSiteImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(logoImage.mas_bottom).offset(60.f);
        make.left.mas_equalTo(42.f);
        make.right.mas_equalTo(-42.f);
        make.height.mas_equalTo(49.f);
    }];
    
    QMUILabel *webSiteTileLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font(14.f) textColor:PTUIColorFromHex(0x2E313E)];
    webSiteTileLabel.text = @"Website";
    [webSiteImage addSubview:webSiteTileLabel];
    [webSiteTileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(20.f);
        make.height.mas_equalTo(16.f);
        make.width.mas_equalTo(60.f);
    }];
    
    QMUILabel *webSiteSubTileLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font(12.f) textColor:PTUIColorFromHex(0x637182)];
    webSiteSubTileLabel.text = @"https://www.next-horizon-lendinginc.com";
    webSiteSubTileLabel.numberOfLines = 0;
    webSiteSubTileLabel.textAlignment = NSTextAlignmentRight;
    [webSiteImage addSubview:webSiteSubTileLabel];
    [webSiteSubTileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-8.f);
        make.left.mas_equalTo(webSiteTileLabel.mas_right).offset(5);
    }];
    
    
    UIImageView *emailImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_setting_back"]];
    [self.view addSubview:emailImage];
    [emailImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(webSiteImage.mas_bottom).offset(20.f);
        make.left.mas_equalTo(42.f);
        make.right.mas_equalTo(-42.f);
        make.height.mas_equalTo(49.f);
    }];
    
    QMUILabel *emailTileLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font(14.f) textColor:PTUIColorFromHex(0x2E313E)];
    emailTileLabel.text = @"Email";
    [emailImage addSubview:emailTileLabel];
    [emailTileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(20.f);
        make.height.mas_equalTo(16.f);
    }];
    
    QMUILabel *emailSubTileLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font(12.f) textColor:PTUIColorFromHex(0x637182)];
    emailSubTileLabel.text = @"cs@next-horizon-lendinginc.com";
    [emailImage addSubview:emailSubTileLabel];
    [emailSubTileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-8.f);
        make.height.mas_equalTo(14.f);
    }];
    
    
    
    UIImageView *editionImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_setting_back"]];
    [self.view addSubview:editionImage];
    [editionImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(emailImage.mas_bottom).offset(20.f);
        make.left.mas_equalTo(42.f);
        make.right.mas_equalTo(-42.f);
        make.height.mas_equalTo(49.f);
    }];
    
    QMUILabel *editionTileLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font(14.f) textColor:PTUIColorFromHex(0x2E313E)];
    editionTileLabel.text = @"Edition";
    [editionImage addSubview:editionTileLabel];
    [editionTileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(20.f);
        make.height.mas_equalTo(16.f);
    }];
    
    QMUILabel *editionSubTileLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font(12.f) textColor:PTUIColorFromHex(0x637182)];
    editionSubTileLabel.text = [NSString stringWithFormat:@"V%@",PTNotNull([PTDeviceInfo version])];
    [editionImage addSubview:editionSubTileLabel];
    [editionSubTileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-8.f);
        make.height.mas_equalTo(14.f);
    }];
    
    QMUIButton *logoutBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    logoutBtn.titleLabel.font = PT_Font(14.f);
    logoutBtn.backgroundColor = PTUIColorFromHex(0xC8FB67);
    [logoutBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [logoutBtn setTitle:@"Logout" forState:UIControlStateNormal];
    [logoutBtn showRadius:8.f];
    [logoutBtn addTarget:self action:@selector(logoutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logoutBtn];
    [logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(editionImage.mas_bottom).offset(60.f);
        make.left.mas_equalTo(42.f);
        make.right.mas_equalTo(-42.f);
        make.height.mas_equalTo(40.f);
    }];
    
    
    QMUIButton *accountBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    accountBtn.titleLabel.font = PT_Font(14.f);
    accountBtn.backgroundColor = PTUIColorFromHex(0xffffff);
    [accountBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [accountBtn setTitle:@"Cancel Account" forState:UIControlStateNormal];
    [accountBtn showRadius:8.f];
    accountBtn.layer.borderColor = PTUIColorFromHex(0xC8FB67).CGColor;
    accountBtn.layer.borderWidth = 0.8f;
    [accountBtn addTarget:self action:@selector(accountBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:accountBtn];
    [accountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(logoutBtn.mas_bottom).offset(16.f);
        make.left.mas_equalTo(42.f);
        make.right.mas_equalTo(-42.f);
        make.height.mas_equalTo(40.f);
    }];
    
}

-(void)logoutBtnClick:(QMUIButton *)btn
{
    btn.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        btn.enabled = YES;
    });
    PTSettingLogoutView *logoutView = [[PTSettingLogoutView alloc] init];
    [logoutView showTitleStr:@"" subTitleStr:@"Are you sure you want to log out of this user?"];
    WEAKSELF
    logoutView.confirmClickBlock = ^{
        STRONGSELF
        [strongSelf setLogout];
    };
}

-(void)accountBtnClick:(QMUIButton *)btn
{
    btn.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        btn.enabled = YES;
    });
    PTSettingLogoutView *logoutView = [[PTSettingLogoutView alloc] init];
    [logoutView showTitleStr:@"" subTitleStr:@"Are you sure\nyou want to leave the software?"];
    WEAKSELF
    logoutView.confirmClickBlock = ^{
        STRONGSELF
        [strongSelf setLogout];
    };
}

- (void)setLogout
{
    PTSettLogoutService *logoutService = [[PTSettLogoutService alloc] init];
    [logoutService startWithCompletionBlockWithSuccess:^(__kindof PTBaseRequest * _Nonnull request) {
        if(request.response_code != 0){
            [PTTools showToast:request.response_message];
            return;
        }
        [PTUser logoutServer];
        [PTVCRouter switchTabAtIndex:0];
        [PTVCRouter jumpLoginWithSuccessBlock:^{
            
        }];
    } failure:^(__kindof PTBaseRequest * _Nonnull request) {
        
    }];
    
}

@end
