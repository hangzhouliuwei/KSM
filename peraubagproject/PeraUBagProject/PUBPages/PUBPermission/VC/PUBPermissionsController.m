//
//  PUBPermissionsController.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/12.
//

#import "PUBPermissionsController.h"

@interface PUBPermissionsController ()

@end

@implementation PUBPermissionsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
    [self hiddeNarbar];
    self.contentView.backgroundColor = [UIColor clearColor];
    //[self cretUI];
}

- (void)cretUI
{
//    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(20.f, KStatusBarHeight, KSCREEN_WIDTH - 40.f, self.contentView.height - KStatusBarHeight)];
//    backView.backgroundColor = [UIColor qmui_colorWithHexString:@"#313848"];
//    [backView showRadius:24.f];
//    [self.contentView addSubview:backView];
//    
//    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0,0, backView.width, 104.f)];
//    topView.backgroundColor = [UIColor qmui_colorWithHexString:@"#1E1E2B"];
//    [backView addSubview:topView];
//    
//    UILabel *tipLabel = [[UILabel alloc] qmui_initWithFont:FONT_MED_SIZE(28.f) textColor:[UIColor whiteColor]];
//    tipLabel.frame = CGRectMake(28.f, 6.f, 200.f, 90.f);
//    tipLabel.numberOfLines = 2.f;
//    tipLabel.text = @"Privacy\nAgreement";
//    [topView addSubview:tipLabel];
//    
//    
//    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, topView.bottom, backView.width, backView.height - 92.f -topView.bottom)];
//    scrollView.backgroundColor = [UIColor clearColor];
//    [backView addSubview:scrollView];
//    
//    
//    UIImageView *phoneImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pub_permissinos_phone"]];
//    phoneImage.frame = CGRectMake(24.f, 24.f, 40.f, 40.f);
//    [scrollView addSubview:phoneImage];
//    
//    UILabel *phoneLabel = [[UILabel alloc] qmui_initWithFont:FONT_MED_SIZE(20.f) textColor:[UIColor whiteColor]];
//    phoneLabel.text = @"Mobile Phone(Device)";
//    phoneLabel.frame = CGRectMake(phoneImage.right + 16.f , 24.f,200.f, 24.f);
//    phoneLabel.centerY = phoneImage.centerY;
//    [scrollView addSubview:phoneLabel];
//    
//    UILabel *phoneContnnetLabel = [[UILabel alloc] qmui_initWithFont:FONT(14.f) textColor:[UIColor whiteColor]];
//    phoneContnnetLabel.text = @"We will use your phone's code (IDFA) because with it we can prevent fraud by ensuring that other phones cannot replace you when requesting a loan.";
//    phoneContnnetLabel.numberOfLines = 0;
//    CGFloat labelH = [PUBTools getTextHeightWithString:phoneContnnetLabel.text font:FONT(14.f) maxWidth:backView.width - 48.f numOfLines:0];
//    phoneContnnetLabel.frame = CGRectMake(24.f, phoneImage.bottom + 12.f, backView.width - 48.f, labelH);
//    [scrollView addSubview:phoneContnnetLabel];
//    
//    
//    
//    UIImageView *smsImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pub_permissinos_sms"]];
//    smsImage.frame = CGRectMake(24.f, phoneContnnetLabel.bottom + 24.f, 40.f, 40.f);
//    [scrollView addSubview:smsImage];
//    
//    UILabel *smsLabel = [[UILabel alloc] qmui_initWithFont:FONT_MED_SIZE(20.f) textColor:[UIColor whiteColor]];
//    smsLabel.text = @"SMS";
//    smsLabel.frame = CGRectMake(smsImage.right + 16.f , 24.f,200.f, 24.f);
//    smsLabel.centerY = smsImage.centerY;
//    [scrollView addSubview:smsLabel];
//    
//    UILabel *smsContnnetLabel = [[UILabel alloc] qmui_initWithFont:FONT(14.f) textColor:[UIColor whiteColor]];
//    smsContnnetLabel.text = @"We will only collect the financial SMS from your inbox which helps us in identifying the various accounts that you are holding and the cash flow patterns that you have as a user to help us perform a credit risk assessment which enables us to determine your risk profile and to provide you with the appropriate credit analysis to enable you to take financial facilities from the regulated financial entities and other service providers available on the platform.The SMS data is encrypted via HTTPS and uploaded to our server (https://api.pro-peso.com/). We will delete the SMS information after we have determined your risk profile.";
//    smsContnnetLabel.numberOfLines = 0;
//    CGFloat smslabelH = [PUBTools getTextHeightWithString:smsContnnetLabel.text font:FONT(14.f) maxWidth:backView.width - 48.f numOfLines:0];
//    smsContnnetLabel.frame = CGRectMake(24.f, smsImage.bottom + 12.f, backView.width - 48.f, smslabelH);
//    [scrollView addSubview:smsContnnetLabel];
//    
//    
//    UIImageView *contactsImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pub_permissinos_contacts"]];
//    contactsImage.frame = CGRectMake(24.f, smsContnnetLabel.bottom + 24.f, 40.f, 40.f);
//    [scrollView addSubview:contactsImage];
//    
//    UILabel *contactsLabel = [[UILabel alloc] qmui_initWithFont:FONT_MED_SIZE(20.f) textColor:[UIColor whiteColor]];
//    contactsLabel.text = @"Contacts";
//    contactsLabel.frame = CGRectMake(contactsImage.right + 16.f , 24.f,200.f, 24.f);
//    contactsLabel.centerY = contactsImage.centerY;
//    [scrollView addSubview:contactsLabel];
//    
//    UILabel *contactsContnnetLabel = [[UILabel alloc] qmui_initWithFont:FONT(14.f) textColor:[UIColor whiteColor]];
//    contactsContnnetLabel.text = @"During filing the form on our App, we will collect your contact information to detect close contacts to enable you to autofill the data during the loan application process.Furthermore, we collect contact information from your device for the purposes of risk analysis by enabling us to detect credible references. The more credible the references are, the lower is the risk associated to a User.The data of the contact list will be encrypted via HTTPS and uploaded to our server (https://api.pro-peso.com/). We will never share this data with third parties.";
//    contactsContnnetLabel.numberOfLines = 0;
//    CGFloat contactslabelH = [PUBTools getTextHeightWithString:smsContnnetLabel.text font:FONT(14.f) maxWidth:backView.width - 48.f numOfLines:0];
//    contactsContnnetLabel.frame = CGRectMake(24.f, contactsImage.bottom + 12.f, backView.width - 48.f, contactslabelH);
//    [scrollView addSubview:contactsContnnetLabel];
//    
//    
//    UIImageView *appsImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pub_permissinos_apps"]];
//    appsImage.frame = CGRectMake(24.f, contactsContnnetLabel.bottom + 24.f, 40.f, 40.f);
//    [scrollView addSubview:appsImage];
//    
//    UILabel *appsLabel = [[UILabel alloc] qmui_initWithFont:FONT_MED_SIZE(20.f) textColor:[UIColor whiteColor]];
//    appsLabel.text = @"Installed Apps";
//    appsLabel.frame = CGRectMake(appsImage.right + 16.f , 24.f,200.f, 24.f);
//    appsLabel.centerY = appsImage.centerY;
//    [scrollView addSubview:appsLabel];
//    
//    UILabel *appsContnnetLabel = [[UILabel alloc] qmui_initWithFont:FONT(14.f) textColor:[UIColor whiteColor]];
//    appsContnnetLabel.text = @"We will collect a list of the installed applications metadata information which includes the application name ";
//    appsContnnetLabel.numberOfLines = 0;
//    CGFloat appsContnnetLabelH = [PUBTools getTextHeightWithString:appsContnnetLabel.text font:FONT(14.f) maxWidth:backView.width - 48.f numOfLines:0];
//    appsContnnetLabel.frame = CGRectMake(24.f, appsImage.bottom + 12.f, backView.width - 48.f, appsContnnetLabelH);
//    [scrollView addSubview:appsContnnetLabel];
//    
//    scrollView.contentSize = CGSizeMake(backView.width, appsContnnetLabel.bottom);
//    
//    QMUIButton *btn = [QMUIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(24.f, scrollView.bottom +20.f, backView.width - 48.f, 48.f);
//    btn.titleLabel.font = FONT_BOLD(20.f);
//    btn.backgroundColor = [UIColor qmui_colorWithHexString:@"#00FFD7"];
//    [btn setTitle:@"Accept&Continue" forState:UIControlStateNormal];
//    btn.cornerRadius = 24.f;
//    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
//    [backView addSubview:btn];
    
}

- (void)btnClick
{
    if(self.clickBlock){
        [[PUBCacheManager sharedPUBCacheManager] cacheYYObject:@"isFistApp" withKey:isFistAPP];
         self.clickBlock();
    }
}

@end
