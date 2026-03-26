//
//  PUBBaseViewController.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/16.
//

#import "PUBBaseViewController.h"
#import "PUBNavigationBar.h"

@interface PUBBaseViewController ()

@end

@implementation PUBBaseViewController

- (void)backBtnClick:(UIButton *)btn
{
    
}

- (void)reponseData
{
    
}

- (void)hiddeNarbar
{
    self.navBar.hidden = YES;
    self.navBar.height =  0;
    self.contentView.y = self.navBar.bottom;
    self.contentView.height = KSCREEN_HEIGHT -  self.navBar.bottom - QMUIHelper.safeAreaInsetsForDeviceWithNotch.bottom;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    [self cretSubViews];
}

- (void)cretSubViews
{
    [self.view addSubview:self.navBar];
    [self.view addSubview:self.contentView];
    [self certemptyView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
        if([QMUIHelper isKeyboardVisible]){
            [self.view endEditing:YES];
        }
}

- (BOOL)forceEnableInteractivePopGestureRecognizer{
    return YES;
}

//手势滑动监听
- (void)navigationController:(nonnull QMUINavigationController *)navigationController
poppingByInteractiveGestureRecognizer:(nullable UIScreenEdgePanGestureRecognizer *)gestureRecognizer isCancelled:(BOOL)isCancelled
 viewControllerWillDisappear:(nullable UIViewController *)viewControllerWillDisappear
    viewControllerWillAppear:(nullable UIViewController *)viewControllerWillAppear{

}

- (void)certemptyView
{
    self.emptyView.imageViewInsets = UIEdgeInsetsMake( -20,  0, 0, 0);
    self.emptyView.textLabelFont = [UIFont boldSystemFontOfSize:17.f];
    self.emptyView.textLabelTextColor  = [UIColor whiteColor];
    self.emptyView.textLabelInsets = UIEdgeInsetsMake( 17,  0,  46,  0);
    self.emptyView.actionButtonTitleColor = [UIColor qmui_colorWithHexString:@"#13062A"];
    self.emptyView.actionButtonFont = [UIFont boldSystemFontOfSize:20.f];
    self.emptyView.actionButton.backgroundColor = [UIColor qmui_colorWithHexString:@"#00FFD7"];
    self.emptyView.actionButton.layer.cornerRadius = 24.f;
    self.emptyView.actionButton.contentEdgeInsets = UIEdgeInsetsMake(12,  KSCREEN_WIDTH / 2 - 64, 12,  KSCREEN_WIDTH / 2 - 64);
}

#pragma mark - lazy
- (PUBNavigationBar *)navBar {
    if(!_navBar){
        _navBar = [[PUBNavigationBar alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KNavigationBarHeight)];
        WEAKSELF
        _navBar.leftBtnClick = ^{
            [weakSelf backBtnClick:nil];
        };
        
    }
    return _navBar;
}

- (UIView *)contentView{
    if(!_contentView){
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navBar.bottom, KSCREEN_WIDTH, KSCREEN_HEIGHT - self.navBar.bottom - QMUIHelper.safeAreaInsetsForDeviceWithNotch.bottom)];
        _contentView.backgroundColor = MainBgColor;
    }
    
    return _contentView;
}

@end
