//
//  BagHomeBannerCell.m
//  NewBag
//
//  Created by Jacky on 2024/3/28.
//

#import "BagHomeBannerCell.h"
#import <SDCycleScrollView.h>
#import "BagHomeModel.h"
@interface BagHomeBannerCell ()<SDCycleScrollViewDelegate>
@property (nonatomic, strong) SDCycleScrollView *bannerView;
@property (nonatomic, strong) BagHomeBannerModel *model;
@property(nonatomic, strong) UIImage *bannerPlaceholderImage;
@end
@implementation BagHomeBannerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        self.contentView.backgroundColor = self.backgroundColor = [UIColor clearColor];
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}

- (void)setupUI{
    WEAKSELF
    [[SDWebImageManager sharedManager] loadImageWithURL:[Util loadImageUrl:@""]
                                                options:0
                                               progress:nil
                                              completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        STRONGSELF
        if (image) {
            strongSelf.bannerPlaceholderImage = image;
        }
       
    }];
    [self.contentView addSubview:self.bannerView];
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(9.f);
        make.left.mas_equalTo(14.f);
        make.right.mas_equalTo(-14.f);
        make.height.mas_equalTo(kScreenWidth/347*125);
    }];
}
- (void)updateUIWithModel:(BagHomeBannerModel *)model
{
    NSMutableArray *imgsArr = [NSMutableArray array];
    [model.gugofourteenyleNc enumerateObjectsUsingBlock:^(BagHomeBannerItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [imgsArr addObject:obj.arisfourteenNc];
    }];
    _model = model;
    self.bannerView.imageURLStringsGroup = imgsArr;
}
#pragma mark - SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if(self.bannerClickBlock && self.model.gugofourteenyleNc.count > index){
        BagHomeBannerItemModel *itemModel = [self.model.gugofourteenyleNc objectAtIndex:index];
        self.bannerClickBlock(itemModel);
    }
}

#pragma mark - lazy
- (SDCycleScrollView *)bannerView{
    if(!_bannerView){
        _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth - 28, 125) delegate:self placeholderImage:self.bannerPlaceholderImage];
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
