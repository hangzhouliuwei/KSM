//
//  BagOrderVC.m
//  NewBag
//
//  Created by Jacky on 2024/3/31.
//

#import "BagOrderVC.h"
#import "BagOrderListVC.h"
#import <JXCategoryView.h>
#import "BagNavBar.h"

@interface BagOrderVC ()<JXCategoryListContainerViewDelegate,JXCategoryViewDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@property(nonatomic, copy) NSArray <NSString*>*titlesArray;
@property (nonatomic, strong) BagNavBar *navBar;

@end

@implementation BagOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor qmui_colorWithHexString:@"#F0F4F7"];
    self.titlesArray = @[@"Borrowing", @"All", @"Not fnished", @"Repaid"];

    [self.view addSubview:self.navBar];
    [self.navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(kNavBarAndStatusBarHeight);
    }];
    self.listContainerView.frame = CGRectMake(0, kNavBarAndStatusBarHeight + 50, kScreenWidth, kScreenHeight - kNavBarAndStatusBarHeight - 50);

    [self.view addSubview:self.listContainerView];
    [self.view addSubview:self.categoryView];
    self.categoryView.defaultSelectedIndex = _selectIndex;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    self.navigationController.delegate = nil;
}
- (void)setSelectIndex:(NSInteger)selectIndex
{
    _selectIndex = selectIndex;
}
#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    if (navigationController.viewControllers.count == 1) {
        self.navigationController.delegate = nil;
        return;
    }
    BOOL isSelf = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isSelf animated:YES];
}
#pragma mark - JXCategoryListContainerViewDelegate
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titlesArray.count;
}

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    BagOrderListVC *list = [[BagOrderListVC alloc] init];
    if(index == 0){
        list.tag = 6;
    }else if(index == 1){
        list.tag = 4;
    }else if(index == 2){
        list.tag = 7;
    }else if(index == 3){
        list.tag = 5;
    }
    return list;
}

#pragma mark - getter
- (BagNavBar *)navBar
{
    if (!_navBar) {
        _navBar = [BagNavBar createNavBar];
        WEAKSELF
        _navBar.gobackBlock = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    return _navBar;
}
- (JXCategoryListContainerView *)listContainerView {
    if (!_listContainerView) {
        _listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    }
    return _listContainerView;
}
- (JXCategoryTitleView *)categoryView
{
    if(!_categoryView){
        _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, kNavBarAndStatusBarHeight, kScreenWidth, 50.f)];
        _categoryView.titles = self.titlesArray;
        _categoryView.backgroundColor = [UIColor colorWithPatternImage:[UIImage qmui_imageWithGradientColors:@[[UIColor qmui_colorWithHexString:@"#205EAB"],[UIColor qmui_colorWithHexString:@"#13407C"]] type:QMUIImageGradientTypeHorizontal locations:nil size:CGSizeMake(kScreenWidth, 50) cornerRadiusArray:nil]];
        _categoryView.titleSelectedColor = [UIColor qmui_colorWithHexString:@"#FFFFFF"];
        _categoryView.delegate = self;
        _categoryView.titleFont = [UIFont systemFontOfSize:14];
        _categoryView.titleSelectedFont = [UIFont boldSystemFontOfSize:15];

        _categoryView.titleColor = [UIColor qmui_colorWithHexString:@"#C1CDFF"];
        _categoryView.titleColorGradientEnabled = YES;
        _categoryView.contentScrollViewClickTransitionAnimationEnabled = NO;
        _categoryView.listContainer = self.listContainerView;
        _categoryView.defaultSelectedIndex = 1;
        JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
        backgroundView.indicatorWidth = 16.f;
        backgroundView.indicatorHeight = 3;
        backgroundView.indicatorCornerRadius = 1.5;
//        backgroundView.indicatorWidthIncrement = 16;
        backgroundView.indicatorColor = [UIColor qmui_colorWithHexString:@"#25BD70"];
        backgroundView.indicatorCornerRadius = JXCategoryViewAutomaticDimension;
        _categoryView.indicators = @[backgroundView];
        backgroundView.verticalMargin = -20;
        
    }
    return _categoryView;
}
- (void)dealloc
{
    
}

@end
