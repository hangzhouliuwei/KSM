//
//  PUBLoanBannerCell.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/25.
//

#import "PUBLoanBannerCell.h"
#import "PUBLoanBannerModel.h"

@interface PUBLoanBannerCell()<SDCycleScrollViewDelegate>
@property(nonatomic, strong) SDCycleScrollView *bannerView;
@property(nonatomic, strong) PUBLoanBannerModel *model;
@end

@implementation PUBLoanBannerCell

- (void)configModel:(PUBLoanBannerModel*)model
{
    self.model = model;
    NSMutableArray *imgsArr = [NSMutableArray array];
    [model.obliterate_eg enumerateObjectsUsingBlock:^(PUBLoanBannerItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [imgsArr addObject:obj.sequestrumnew_eg];
    }];
    self.bannerView.imageURLStringsGroup = imgsArr;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self initSubViews];
        [self initSubFormes];
    }
    
    return self;
}

- (void)initSubViews
{
    self.selected = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.bannerView];
}

- (void)initSubFormes
{
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(130.f);
    }];
}
#pragma mark - SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if(self.bannerClickBlock && self.model.obliterate_eg.count > index){
        PUBLoanBannerItemModel *itemModel = [self.model.obliterate_eg objectAtIndex:index];
        self.bannerClickBlock(itemModel);
    }
}

#pragma mark - lazy
- (SDCycleScrollView *)bannerView{
    if(!_bannerView){
        _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 130.f) delegate:self placeholderImage:nil];
        _bannerView.autoScrollTimeInterval = 3;
        _bannerView.contentMode = UIViewContentModeScaleAspectFit;
        _bannerView.backgroundColor = [UIColor clearColor];
        _bannerView.showPageControl = YES;
        _bannerView.currentPageDotColor = [UIColor whiteColor];
        _bannerView.pageDotColor = [UIColor qmui_colorWithHexString:@"#E9EDF1"];
        _bannerView.pageControlDotSize = CGSizeMake(40, 40);
        _bannerView.pageControlBottomOffset = -10.f;
    }
    return _bannerView;
}

@end
