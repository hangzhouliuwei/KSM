//
//  PesoHomeBannerCell.m
//  PesoApp
//
//  Created by Jacky on 2024/9/11.
//

#import "PesoHomeBannerCell.h"
#import "PesoHomeBannerModel.h"
#import <SDCycleScrollView/SDCycleScrollView.h>

@interface PesoHomeBannerCell()<SDCycleScrollViewDelegate>
@property (nonatomic, strong) SDCycleScrollView *banner;
@property (nonatomic, strong) PesoHomeBannerModel *model;
@end

@implementation PesoHomeBannerCell

- (void)createUI
{
    [super createUI];
    self.contentView.backgroundColor = self.backgroundColor = UIColor.clearColor;
    _banner = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(12.f, 14, kScreenWidth -24.f, kScreenWidth/375*148) delegate:self placeholderImage:[UIImage br_imageWithColor:[UIColor clearColor]]];
    _banner.autoScrollTimeInterval = 3;
    _banner.infiniteLoop = YES;
    _banner.autoScroll = YES;
    _banner.contentMode = UIViewContentModeScaleAspectFit;
    _banner.backgroundColor = [UIColor clearColor];
    _banner.showPageControl = YES;
    _banner.currentPageDotColor = [UIColor whiteColor];
    _banner.pageDotColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    _banner.pageControlDotSize = CGSizeMake(40, 40);
    _banner.pageControlBottomOffset = -24.f;
    _banner.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    [self.contentView addSubview:_banner];
    
}
- (void)configUIWithModel:(PesoHomeBannerModel *)model
{
    self.model = model;
    NSMutableArray *bannerImageArr = [NSMutableArray array];
    [model.gugothirteenyleNc enumerateObjectsUsingBlock:^(PesoHomeBannerItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [bannerImageArr addObject:obj.aristhirteenNc];
    }];
    self.banner.imageURLStringsGroup = bannerImageArr;
}
#pragma mark - SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if(self.click && self.model.gugothirteenyleNc.count > index){
        PesoHomeBannerItemModel *itemModel = [self.model.gugothirteenyleNc objectAtIndex:index];
        self.click(itemModel.relothirteenomNc);
    }
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
//    _myPageControl.currentPage = index;
}
@end
