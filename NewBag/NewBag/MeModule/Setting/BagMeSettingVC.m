//
//  BagMeSettingVC.m
//  NewBag
//
//  Created by Jacky on 2024/3/31.
//

#import "BagMeSettingVC.h"
#import "BagMeSetAlertView.h"
#import "BagDeleteAccountService.h"
@interface BagMeSettingVC ()<UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *logotBtn;
@property (weak, nonatomic) IBOutlet UILabel *productTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *websiteLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *websiteImageView;
@property (weak, nonatomic) IBOutlet UIImageView *emailImageView;
@property (weak, nonatomic) IBOutlet UIImageView *editionImageView;

@end

@implementation BagMeSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftTitle = @"Set Up";
    self.leftTitleColor = @"#333333";
    self.productTitleLabel.text = appName;
    [self.logoImageView sd_setImageWithURL:[Util loadImageUrl:@"login_logo"]];
    [self.websiteImageView sd_setImageWithURL:[Util loadImageUrl:@"icon-Website"]];
    [self.emailImageView sd_setImageWithURL:[Util loadImageUrl:@"icon-Email"]];
    [self.editionImageView sd_setImageWithURL:[Util loadImageUrl:@"icon-Edition"]];
    self.versionLabel.text = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    self.logotBtn.qmui_borderLocation = QMUIViewBorderLocationOutside;
    self.logotBtn.qmui_borderPosition = QMUIViewBorderPositionTop | QMUIViewBorderPositionBottom | QMUIViewBorderPositionLeft | QMUIViewBorderPositionRight;
    self.navigationController.delegate = self;

    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.leftTitleColor = @"#333333";

}
- (IBAction)logoutAction:(id)sender {
    BagMeSetAlertView *alert = [BagMeSetAlertView createAlert];
    alert.confirmBlock = ^{
        BagDeleteAccountService *service = [[BagDeleteAccountService alloc] init];
        [service startWithCompletionBlockWithSuccess:^(__kindof BagBaseRequest * _Nonnull request) {
            if (request.response_code == 0) {
                [[BagUserManager shareInstance] logout];
                [[BagRouterManager shareInstance] setSelectedIndex:0 viewController:nil];
                [[BagRouterManager shareInstance] jumpLogin];
            }else{
                [self showToast:request.response_message duration:1.0f];
            }
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
        }];
    };
    [alert showwithTitle:@"Are you sure \n you want to leave the software?"];
    
}
- (IBAction)cancelAction:(id)sender {
    BagMeSetAlertView *alert = [BagMeSetAlertView createAlert];
    alert.confirmBlock = ^{
        BagDeleteAccountService *service = [[BagDeleteAccountService alloc] init];
        [service startWithCompletionBlockWithSuccess:^(__kindof BagBaseRequest * _Nonnull request) {
            if (request.response_code == 0) {
                [[BagUserManager shareInstance] logout];
                [[BagRouterManager shareInstance] setSelectedIndex:0 viewController:nil];
                [[BagRouterManager shareInstance] jumpLogin];
            }else{
                [self showToast:request.response_message duration:1.0f];
            }
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
        }];
    };
    [alert showwithTitle:@"Are you sure \n you want to cancel account?"];
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isSelf = [viewController isKindOfClass:[self class]];
    if (isSelf) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

@end
