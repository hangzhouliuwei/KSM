//
//  PUBOrderViewController.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/18.
//

#import "PUBOrderViewController.h"
#import <JXCategoryView.h>
#import "PUBOrderDetailController.h"

@interface PUBOrderViewController ()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate>
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property(nonatomic, copy) NSArray <NSString*>*titlesArray;
@end

@implementation PUBOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navBar hideLeftBtn];
    [self.navBar showtitle:@"Loan Record" isLeft:YES];
    self.contentView.backgroundColor = [UIColor qmui_colorWithHexString:@"#313848"];
    self.contentView.height = KSCREEN_HEIGHT - KTabBarHeight - self.navBar.height;
    [self certUI];
}

- (void)certUI
{
    self.listContainerView.frame = CGRectMake(0, 60, KSCREEN_WIDTH, self.contentView.height - 60.f);
    self.listContainerView.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:self.listContainerView];
    
    self.titlesArray = @[@"To be repaid", @"All", @"Not fnished", @"Repaid"].copy;
    [self.contentView addSubview:self.categoryView];
}


#pragma mark - JXCategoryListContainerViewDelegate
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titlesArray.count;
}

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    PUBOrderDetailController *list = [[PUBOrderDetailController alloc] init];
    if(index == 0){
        list.hydroairplaneEg = 6;
    }else if(index == 1){
        list.hydroairplaneEg = 4;
    }else if(index == 2){
        list.hydroairplaneEg = 7;
    }else if(index == 3){
        list.hydroairplaneEg = 5;
    }
    return list;
}



#pragma mark - lazy

- (JXCategoryListContainerView *)listContainerView {
    if (!_listContainerView) {
        _listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    }
    return _listContainerView;
}

-(JXCategoryTitleView *)categoryView{
    if(!_categoryView){
        _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 10, KSCREEN_WIDTH, 50.f)];
        _categoryView.titles = self.titlesArray;
        _categoryView.backgroundColor = [UIColor qmui_colorWithHexString:@"#313848"];
        _categoryView.titleSelectedColor = [UIColor qmui_colorWithHexString:@"#13062A"];
        _categoryView.delegate = self;
        _categoryView.titleFont = FONT(14.f);
        _categoryView.titleColor = [UIColor whiteColor];
        _categoryView.titleColorGradientEnabled = YES;
        _categoryView.contentScrollViewClickTransitionAnimationEnabled = NO;
        _categoryView.listContainer = self.listContainerView;
        _categoryView.defaultSelectedIndex = 1;
        JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
        backgroundView.indicatorHeight = 32;
        backgroundView.indicatorCornerRadius = 10;
        backgroundView.indicatorWidthIncrement = 20;
        backgroundView.indicatorColor = [UIColor qmui_colorWithHexString:@"#00FFD7"];
        backgroundView.indicatorCornerRadius = JXCategoryViewAutomaticDimension;
        _categoryView.indicators = @[backgroundView];
        
    }
    return _categoryView;
}


@end
