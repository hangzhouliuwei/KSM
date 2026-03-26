//
//  BaseViewController.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/23.
//

#import "PLPBaseViewController.h"
#import "HoldAlertView.h"
@interface PLPBaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation PLPBaseViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *name = NSStringFromClass([self class]);
    self.navigationController.navigationBar.tintColor = kWhiteColor;
    if ([PLPDataManager manager].showServerImageView) {
        if (self.hideServeImageView) {
            [PLPDataManager manager].callImageView.hidden = YES;
        }else
        {
            [PLPDataManager manager].callImageView.hidden = NO;
            [[UIApplication sharedApplication].keyWindow addSubview:[PLPDataManager manager].callImageView];
        }
    }else
    {
        [PLPDataManager manager].callImageView.hidden = YES;
    }
}
-(instancetype)init
{
    self = [super init];
    if (self) {
        NSString *className = NSStringFromClass([self class]);
        BOOL isHome = ([className isEqualToString:@"PLPLoanViewController"] || [className isEqualToString:@"PLPOrderListViewController"] || [className isEqualToString:@"PLPMineViewController"] || [className isEqualToString:@"PLPLoginRegistViewController"]);
        self.hidesBottomBarWhenPushed = !isHome;
        if (!isHome) {
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[kImageName(@"mine_item_arrow") sd_rotatedImageWithAngle:-M_PI_2 fitSize:YES] sd_resizedImageWithSize:CGSizeMake(20, 20) scaleMode:SDImageScaleModeFill] style:UIBarButtonItemStylePlain target:self action:@selector(BASE_BackAction)];
            
        }
    }
    return self;
}
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == self.navigationController.interactivePopGestureRecognizer) {
        if (![self.navigationController.viewControllers.lastObject isKindOfClass:[PLPBaseViewController class]]) {
            return true;
        }
        if (self.holdConetent.length > 0) {
            NSLog(@"%@",self.holdConetent);
            HoldAlertView *view = [[HoldAlertView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 231) info:self.holdConetent];
            view.confirmButtonAction = ^{
                [self.navigationController popViewControllerAnimated:YES];
            };
            view.cancelButtonAction = ^{
                
            };
            [view popAlertViewOnBottom];
            return false;
        }
        return true;
    }
    return true;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.startTime = [NSString stringWithFormat:@"%.f",[[NSDate date] timeIntervalSince1970] *1000];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    imageView.image = kImageName(@"base_bg_image");
    imageView.userInteractionEnabled = YES;
    self.baseImageView = imageView;
    self.navigationItem.backButtonTitle = @"";
    self.navigationController.navigationBar.tintColor = kWhiteColor;
    self.view.backgroundColor = kHexColor(0xF5F5F5);
    
    [self BASE_GenerateSubview];
    [self BASE_RequestHTTPInfo];
    [self setupTransparentNavigationBar];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.shouldPopHome) {
            [PLPCommondTools clearCurrentNavigationStack:self];
        }
    });
    
}

-(void)BASE_BackAction
{
    if ([self.holdConetent isReal]) {
        kWeakSelf
        HoldAlertView *view = [[HoldAlertView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 231) info:self.holdConetent];
        view.confirmButtonAction = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        view.cancelButtonAction = ^{
            
        };
        [view popAlertViewOnBottom];
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
//self.holdConetent = @"kajsdhlasdhkasdhjkasdhjkashjk";
//HoldAlertView *view = [[HoldAlertView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 200) info:self.holdConetent];
//[view showBottom];
//-(void)willMoveToParentViewController:(UIViewController *)parent
//{
//    [super willMoveToParentViewController:parent];
//    if (!parent) {
////        return;
////        if (self.holdConetent.length > 0) {
////           
////        }
//
//    }
//}
-(void)BASE_GenerateSubview
{
    
}
-(void)BASE_RequestHTTPInfo
{
    
}

-(void)decodeAuthResponseData:(NSDictionary *)data
{
    BOOL review = [kMMKV getBoolForKey:kReviewKey];
    if(review){
        kHideLoading
        NSMutableArray *VCArr = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
        [VCArr removeObject:self];
        self.navigationController.viewControllers =VCArr;
        return;
    }
    if (data.allKeys.count == 0) {//跳转完成页面
        kShowLoading
        [PLPCommondTools queryURLWithOrderNo:[PLPDataManager manager].orderId];
        return;
    }
    NSString *str = data[@"excuse"];
    NSString *name = [PLPDataManager manager].controllerMap[str];
    if (name) {
        Class cls = NSClassFromString(name);
        [self.navigationController pushViewController:[cls new] animated:YES];
    }else
    {
        kShowLoading
        [PLPCommondTools queryURLWithOrderNo:[PLPDataManager manager].orderId];
//        NSAssert(true, @"insert key to controllerMap");
    }
}
-(NSDictionary *)BASE_GeneragePointDictionaryWithType:(NSString *)type
{
    NSString *crretnTime = [NSString stringWithFormat:@"%.f",[[NSDate date] timeIntervalSince1970] *1000];
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    result[@"deamtwelveatoryNc"] = @(self.startTime.doubleValue);
    result[@"munitwelveumNc"] = [PLPDataManager manager].productId;
    result[@"hyratwelverthrosisNc"] = type;
    result[@"boomtwelveofoNc"] = [[PLPLocationManager sharedManager] getCurrentLatitude];
    result[@"unevtwelveoutNc"] = [[PLPLocationManager sharedManager] getCurrentLongitude];
    result[@"unultwelveyNc"] = @(crretnTime.doubleValue);
    result[@"cacotwelvetomyNc"] = [PLPCommondTools getDeviceIDFV];
    return result;
}
- (void)setupTransparentNavigationBar {
    // 获取当前的导航栏
    UINavigationBar *navigationBar = self.navigationController.navigationBar;

    // 设置背景图片为空
    [navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:[UIImage new]];
    navigationBar.translucent = YES;
    navigationBar.backgroundColor = [UIColor clearColor];
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
