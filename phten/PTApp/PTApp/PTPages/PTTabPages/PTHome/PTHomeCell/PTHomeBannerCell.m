//
//  PTHomeBannerCell.m
//  PTApp
//
//  Created by 刘巍 on 2024/8/3.
//

#import "PTHomeBannerCell.h"
#import "PTHomeBannerModel.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "EllipsePageControl.h"

@interface PTHomeBannerCell()<SDCycleScrollViewDelegate>
@property(nonatomic, strong) SDCycleScrollView *bannerView;
@property(nonatomic, strong) PTHomeBannerModel *model;
@property(nonatomic,strong) EllipsePageControl *myPageControl;

@end

@implementation PTHomeBannerCell

-(void)configModel:(PTHomeBannerModel*)model
{
    self.model = model;
    NSMutableArray *bannerImageArr = [NSMutableArray array];
    [model.gutengoyleNc enumerateObjectsUsingBlock:^(PTHomeBannerItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [bannerImageArr addObject:obj.artenisNc];
    }];
    self.bannerView.imageURLStringsGroup = bannerImageArr;
    self.myPageControl.numberOfPages = bannerImageArr.count;
    CGFloat width = 25+3*(bannerImageArr.count-1)+6*(bannerImageArr.count-1);
    self.myPageControl.frame = CGRectMake(kScreenWidth-40-width, 76+16, width, 6);
    [self.contentView layoutIfNeeded];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        [self createSubUI];
    }
    return self;
}

-(void)createSubUI
{
    [self.contentView addSubview:self.bannerView];
    _myPageControl = [[EllipsePageControl alloc] initWithFrame:CGRectZero];
    _myPageControl.numberOfPages = 0;
    _myPageControl.currentColor = PTUIColorFromHex(0x33E2FF);
    _myPageControl.otherColor = PTUIColorFromHex(0xc4f1fd);
    _myPageControl.currentControlSize=CGSizeMake(25, 6);
    _myPageControl.otherControlSize=CGSizeMake(6, 6);
    _myPageControl.controlSpacing = 3;
    self.myPageControl.currentPage = 0;
    [self.contentView addSubview:_myPageControl];
}

#pragma mark - SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if(self.bannerClickBloack && self.model.gutengoyleNc.count > index){
        PTHomeBannerItemModel *itemModel = [self.model.gutengoyleNc objectAtIndex:index];
        self.bannerClickBloack(itemModel.retenloomNc);
    }
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
    _myPageControl.currentPage = index;
}

#pragma mark - lazy
- (SDCycleScrollView *)bannerView{
    if(!_bannerView){
        _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(16.f, 8, kScreenWidth -32.f, 76.f) delegate:self placeholderImage:[UIImage imageNamed:@"PT_home_bannerPlaceholder"]];
        _bannerView.autoScrollTimeInterval = 3;
        _bannerView.infiniteLoop = YES;
        _bannerView.autoScroll = YES;
        _bannerView.contentMode = UIViewContentModeScaleAspectFit;
        _bannerView.backgroundColor = [UIColor clearColor];
        _bannerView.showPageControl = NO;
//        _bannerView.currentPageDotColor = [UIColor whiteColor];
//        _bannerView.pageDotColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
//        _bannerView.pageControlDotSize = CGSizeMake(40, 40);
//        _bannerView.pageControlBottomOffset = -24.f;
//        _bannerView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    }
    return _bannerView;
}


@end
