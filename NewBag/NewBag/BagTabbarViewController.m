//
//  BagTabbarViewController.m
//  NewBag
//
//  Created by Jacky on 2024/3/14.
//

#import "BagTabbarViewController.h"
#import "BagHomeViewController.h"
#import "BagMeViewController.h"
@interface BagTabbarViewController ()
@property(nonatomic, strong) BagHomeViewController *homeVC;
@property(nonatomic, strong) BagNavigationViewController *homeNav;
@property(nonatomic, strong) BagMeViewController *meVC;
@property(nonatomic, strong) BagNavigationViewController *meNav;
@end

@implementation BagTabbarViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [Util startNetWorkMonitor];
    });
    
    WEAKSELF
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:NetWorkMonitor object:nil] subscribeNext:^(NSNotification * _Nullable x) {
       STRONGSELF
        [strongSelf loadTabBarImages];
    }];
    [self setupInitialTabBar];
    [self forceLogin];
}

- (void)setupInitialTabBar {
    self.viewControllers = @[self.homeNav, self.meNav];
    self.tabBar.tintColor = [UIColor qmui_colorWithHexString:@"#154685"];
    [[UITabBar appearance] setBackgroundColor:[UIColor qmui_colorWithHexString:@"#ffffff"]];
}

- (void)loadTabBarImages {
    dispatch_group_t group = dispatch_group_create();

    __block UIImage *homeNormalImage = nil;
    __block UIImage *homeSelectedImage = nil;
    __block UIImage *meNormalImage = nil;
    __block UIImage *meSelectedImage = nil;

    NSArray *imageURLs = @[@"tab_home_normal", @"tab_home_selected", @"tab_me_normal", @"tab_me_selected"];
    NSArray<void (^)(UIImage *)> *imageBlocks = @[
        ^(UIImage *image) { homeNormalImage = [Util imageResize:image ResizeTo:CGSizeMake(32.f, 32.f)]; },
        ^(UIImage *image) { homeSelectedImage = [Util imageResize:image ResizeTo:CGSizeMake(32.f, 32.f)]; },
        ^(UIImage *image) { meNormalImage = [Util imageResize:image ResizeTo:CGSizeMake(32.f, 32.f)]; },
        ^(UIImage *image) { meSelectedImage = [Util imageResize:image ResizeTo:CGSizeMake(32.f, 32.f)]; }
    ];

    for (NSInteger i = 0; i < imageURLs.count; i++) {
        dispatch_group_enter(group);
        [[SDWebImageManager sharedManager] loadImageWithURL:[Util loadImageUrl:imageURLs[i]]
                                                    options:0
                                                   progress:nil
                                                  completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            if (image) {
                imageBlocks[i](image);
            }
            dispatch_group_leave(group);
        }];
    }

    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        self.homeVC.tabBarItem.image = [homeNormalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.homeVC.tabBarItem.selectedImage = [homeSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

        self.meVC.tabBarItem.image = [meNormalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.meVC.tabBarItem.selectedImage = [meSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.viewControllers = @[];
        [self setupInitialTabBar];
    });
}

- (BagHomeViewController *)homeVC {
    if (!_homeVC) {
        _homeVC = [[BagHomeViewController alloc] init];
    }
    return _homeVC;
}

- (BagNavigationViewController *)homeNav {
    if (!_homeNav) {
        _homeNav = [[BagNavigationViewController alloc] initWithRootViewController:self.homeVC];
    }
    return _homeNav;
}

- (BagMeViewController *)meVC {
    if (!_meVC) {
        _meVC = [[BagMeViewController alloc] init];
    }
    return _meVC;
}

- (BagNavigationViewController *)meNav {
    if (!_meNav) {
        _meNav = [[BagNavigationViewController alloc] initWithRootViewController:self.meVC];
    }
    return _meNav;
}


#pragma - 用户强制登录
- (void)forceLogin
{
    if (!BagUserManager.shareInstance.isLogin) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[BagRouterManager shareInstance] jumpLoginWithSuccessBlock:^{
               
            }];
           
        });
    }
   
}

@end
