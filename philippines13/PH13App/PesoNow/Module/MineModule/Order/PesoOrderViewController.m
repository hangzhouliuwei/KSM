//
//  PesoOrderViewController.m
//  PesoApp
//
//  Created by Jacky on 2024/9/18.
//

#import "PesoOrderViewController.h"
#import "PesoOrderItemVC.h"
#import <JXCategoryView.h>
@interface PesoOrderViewController ()<JXCategoryListContainerViewDelegate,JXCategoryViewDelegate>
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@property(nonatomic, copy) NSArray <NSString*>*titlesArray;
@end

@implementation PesoOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"Loan Record";
    // Do any additional setup after loading the view.
}
- (void)createUI
{
    [super createUI];
    self.titlesArray = @[@"Borrowing", @"Order", @"Not fnished", @"Repaid"];
    
    self.listContainerView.frame = CGRectMake(0, kNavBarAndStatusBarHeight + 40, kScreenWidth, kScreenHeight - kNavBarAndStatusBarHeight - 40);
    
    [self.view addSubview:self.listContainerView];
    [self.view addSubview:self.categoryView];
    self.categoryView.defaultSelectedIndex = _selectIndex;
}

#pragma mark - JXCategoryListContainerViewDelegate
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titlesArray.count;
}

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    PesoOrderItemVC *list = [[PesoOrderItemVC alloc] init];
    if(index == 0){
        list.tag = 7;
    }else if(index == 1){
        list.tag = 4;
    }else if(index == 2){
        list.tag = 6;
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
        _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, kNavBarAndStatusBarHeight, kScreenWidth, 40.f)];
        _categoryView.titles = self.titlesArray;
        _categoryView.backgroundColor = [UIColor clearColor];
        _categoryView.delegate = self;
        _categoryView.titleFont = [UIFont systemFontOfSize:13];
        _categoryView.titleSelectedFont = [UIFont boldSystemFontOfSize:15];
        _categoryView.titleColor = ColorFromHex(0x616C5F);
        _categoryView.titleSelectedColor = [UIColor blackColor];
        
        _categoryView.titleColorGradientEnabled = YES;
        _categoryView.contentScrollViewClickTransitionAnimationEnabled = NO;
        _categoryView.listContainer = self.listContainerView;
        _categoryView.defaultSelectedIndex = 1;
        JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
        backgroundView.indicatorWidth = 22.f;
        backgroundView.indicatorHeight = 3;
        backgroundView.indicatorCornerRadius = 1.5;
        backgroundView.indicatorColor = ColorFromHex(0x94DB00);
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
