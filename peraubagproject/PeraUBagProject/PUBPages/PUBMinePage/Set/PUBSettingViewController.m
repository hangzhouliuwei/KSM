//
//  PUBSettingViewController.m
//  PeraUBagProject
//
//  Created by Jacky on 2024/1/16.
//

#import "PUBSettingViewController.h"
#import "PUBSetView.h"
#import "PUBUserManager.h"
#import "PUBTabBarController.h"
#import "PUBSetLogoutAlertView.h"
#import "PUBEnvironmentViewController.h"
@interface PUBSettingViewController ()
@property (nonatomic, strong) PUBSetView *setView;
@end

@implementation PUBSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navBar showtitle:@"Set up" isLeft:YES];
    [self setupUI];
    // Do any additional setup after loading the view.
}
- (void)setupUI{
    [self.contentView addSubview:self.setView];
}
- (void)backBtnClick:(UIButton *)btn
{
    [self.navigationController qmui_popViewControllerAnimated:YES completion:nil];
}
- (void)sendDeleteAccountRequest{
    WEAKSELF
    [HttPPUBRequest postWithPath:deleteAccount params:@{} success:^(NSDictionary * _Nonnull responseDataDic, PUBBaseResponseModel * _Nonnull mode) {
        STRONGSELF
        [PUBTools showToast:mode.desc];
       
        if(mode.success){
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[PUBUserManager sharedUser] logoutCallServer];
                [[PUBMianVCManager sharedPUBMianVCManager]switchTabAtIndex:0];
                [PUBTools checkLogin:^(NSInteger uid) {
                    
                }];
            });
        }
       
    } failure:^(NSError * _Nonnull error) {
    }];
}
- (PUBSetView *)setView
{
    if (!_setView) {
        _setView = [PUBSetView createSetView];
        _setView.logoutBlock = ^{
            PUBSetLogoutAlertView *alert = [PUBSetLogoutAlertView createAlertView];
            alert.confirmBlock = ^{
                [[PUBUserManager sharedUser] logoutCallServer];
                [[PUBMianVCManager sharedPUBMianVCManager]switchTabAtIndex:0];
                [PUBTools checkLogin:^(NSInteger uid) {
                    
                }];
            };
            [alert showTiltle:@"Are you sure you want to leave the software?"];

        };
        WEAKSELF
        _setView.cancelBlock = ^{
            STRONGSELF
            PUBSetLogoutAlertView *alert = [PUBSetLogoutAlertView createAlertView];
            alert.confirmBlock = ^{
                [strongSelf sendDeleteAccountRequest];
            };
            [alert showTiltle:@"Are you sure you want to log out of this user?"];
        };
        
        _setView.logImageBlock = ^{
            //STRONGSELF
            //[strongSelf.navigationController qmui_pushViewController:[[PUBEnvironmentViewController alloc] init] animated:YES completion:nil];
        };
    }
    return _setView;
}


@end
