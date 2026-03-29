//
//  PPBasePage.m
// FIexiLend
//
//  Created by jacky on 2024/10/31.
//

#import "PPBasePageController.h"

@interface PPBasePageController () <UIGestureRecognizerDelegate>
@end

@implementation PPBasePageController

- (id)init {
    self = [super init];
    if (self) {
        self.canGestureBack = YES;
    }
    return self;
}

- (void)loadView{
    [super loadView];
    [self.view addSubview:self.content];
}

- (PPBaseWidgetView *)content {
    if (!_content) {
        CGFloat height = [self contentHeight];
        _content = [[PPBaseWidgetView alloc] initWithFrame:CGRectMake(0, self.naviBarHidden ? 0 : NavBarHeight, ScreenWidth, height)];
        _content.contentSize = CGSizeMake(_content.w, _content.h + 1);
        _content.backgroundColor = UIColor.clearColor;
        _content.userInteractionEnabled = YES;
        _content.showsVerticalScrollIndicator = NO;
        self.content.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    return _content;
}

- (CGFloat)contentHeight{
    CGFloat height = ScreenHeight;
    if (!self.naviBarHidden) {
        height -= NavBarHeight;
    }
    if (self.tabBarController) {
        height -= TabBarHeight;
    }
    return height;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navBar.hidden = self.naviBarHidden;
}

- (PPNavTopStausAndBar *)navBar {
    if (!_navBar) {
        _navBar = [[PPNavTopStausAndBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, NavBarHeight)];
        kWeakself;
        _navBar.backBtnClick = ^{
            [weakSelf backAction];
        };
        
        [self.view addSubview:_navBar];
    }
    return _navBar;
}

- (void)setTitle:(NSString *)title {
    self.navBar.titleView.text = title;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!self.canGestureBack) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (!self.canGestureBack) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)backAction {
    [Page pop];
}

@end
