//
//  PTOrderViewController.m
//  PTApp
//
//  Created by Jacky on 2024/8/28.
//

#import "PTOrderViewController.h"
#import "PTOrderListVC.h"
#import <JXCategoryView.h>
@interface PTOrderViewController ()<JXCategoryListContainerViewDelegate,JXCategoryViewDelegate>
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@property(nonatomic, copy) NSArray <NSString*>*titlesArray;
@property(nonatomic, strong) NSMutableArray *vcArray;
@property(nonatomic, copy) NSMutableArray <QMUIButton*>*btnArray;
@property (nonatomic, strong) UIViewController *currentVC;
@end

@implementation PTOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showtitle:@"Loan Record" isLeft:YES disPlayType:PTDisplayTypeBlack];
    self.titlesArray = @[@"Borrowing", @"Order", @"Not fnished", @"Repaid"];
    
    self.listContainerView.frame = CGRectMake(0, kNavBarAndStatusBarHeight + 50, kScreenWidth, kScreenHeight - kNavBarAndStatusBarHeight - 50);
    
    [self.view addSubview:self.listContainerView];
    [self.view addSubview:self.categoryView];
    self.categoryView.defaultSelectedIndex = _selectIndex;
}
#pragma mark - JXCategoryListContainerViewDelegate
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titlesArray.count;
}

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    PTOrderListVC *list = [[PTOrderListVC alloc] init];
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
        _categoryView.backgroundColor = [UIColor clearColor];
        _categoryView.titleSelectedColor = [UIColor qmui_colorWithHexString:@"#111111"];
        _categoryView.delegate = self;
        _categoryView.titleFont = [UIFont systemFontOfSize:14];
        _categoryView.titleSelectedFont = [UIFont boldSystemFontOfSize:15];
        _categoryView.titleColor = RGBA(0, 0, 0, 0.38);
        
        _categoryView.titleColorGradientEnabled = YES;
        _categoryView.contentScrollViewClickTransitionAnimationEnabled = NO;
        _categoryView.listContainer = self.listContainerView;
        _categoryView.defaultSelectedIndex = 1;
        JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
        backgroundView.indicatorWidth = 16.f;
        backgroundView.indicatorHeight = 3;
        backgroundView.indicatorCornerRadius = 1.5;
        backgroundView.indicatorColor = [UIColor clearColor];
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
