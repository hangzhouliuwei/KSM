//
//  BagBaseVC.m
//  NewBag
//
//  Created by Jacky on 2024/3/12.
//

#import "BagBaseVC.h"

@interface BagBaseVC ()

@end

@implementation BagBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createLeft];
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;

    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self createLeft];
}
- (void)setLeftTitle:(NSString *)leftTitle
{
    _leftTitle = leftTitle;
    [self createLeft];
}
- (void)createLeft{
    self.navigationController.navigationBar.tintColor = [UIColor qmui_colorWithHexString:_leftTitleColor ? : @"#ffffff"];

    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithImage:nil style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
    
    // 使用SDWebImage加载图片
        [[SDWebImageManager sharedManager] loadImageWithURL:[Util loadImageUrl:@"icon_nav_return"]
                                                    options:0
                                                   progress:nil
                                                  completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            if (image && finished) {
                // 加载成功后设置图像
                dispatch_async(dispatch_get_main_queue(), ^{
                    back.image = [Util imageResize:image ResizeTo:CGSizeMake(20.f, 20.f)];
                });
            }
        }];
    if ([NotNull(_leftTitle) br_isBlankString]) {
        self.navigationItem.leftBarButtonItems = @[back];
    }else{
        UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, kNavBarHeight)];
        bg.backgroundColor = [UIColor clearColor];
        UIButton *btn = [[UIButton alloc] initWithFrame:bg.bounds];
        [btn setTitleColor:[UIColor qmui_colorWithHexString:_leftTitleColor ? : @"#ffffff"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
      
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:19];
        [btn setTitle:_leftTitle forState:UIControlStateNormal];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [bg addSubview:btn];
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:bg];
        self.navigationItem.leftBarButtonItems = @[back, left];
    }
}
/**手势**/
- (BOOL)forceEnableInteractivePopGestureRecognizer{
    return YES;
}
//手势滑动监听
- (void)navigationController:(nonnull QMUINavigationController *)navigationController
poppingByInteractiveGestureRecognizer:(nullable UIScreenEdgePanGestureRecognizer *)gestureRecognizer isCancelled:(BOOL)isCancelled
 viewControllerWillDisappear:(nullable UIViewController *)viewControllerWillDisappear
    viewControllerWillAppear:(nullable UIViewController *)viewControllerWillAppear{

}
- (void)backClick{
    [self.navigationController qmui_popViewControllerAnimated:YES completion:nil];
}
- (void)showToast:(NSString *)title duration:(CGFloat)duration
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = title;
    hud.detailsLabel.font = [UIFont systemFontOfSize:14];
    hud.detailsLabel.textColor = [UIColor whiteColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor br_colorWithRGB:0x000000 alpha:0.6];
    dispatch_async(dispatch_get_main_queue(), ^{
        [hud hideAnimated:YES afterDelay:duration];
    });
}
- (void)showToastInWindow:(NSString *)title duration:(CGFloat)duration
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:UIApplication.sharedApplication.windows.firstObject animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = title;
    hud.detailsLabel.font = [UIFont systemFontOfSize:14];
    hud.detailsLabel.textColor = [UIColor whiteColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor br_colorWithRGB:0x000000 alpha:0.6];
    dispatch_async(dispatch_get_main_queue(), ^{
        [hud hideAnimated:YES afterDelay:duration];
    });
}
- (void)dissmiss{
    if (self.navigationController) {
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}
- (void)removeViewController {
    NSMutableArray *VCArr = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [VCArr removeObject:self];
    self.navigationController.viewControllers =VCArr;
}
- (void)dealloc
{
    NSLog(@"------------%@--销毁",NSStringFromClass(self.class));
}
@end
